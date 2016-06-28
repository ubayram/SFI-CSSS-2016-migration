package rw.netcdf;

import java.io.Closeable;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.List;
import java.util.TreeMap;

import ucar.nc2.dataset.CoordinateAxis1D;
import ucar.nc2.dataset.CoordinateAxis1DTime;
import ucar.nc2.dt.GridCoordSystem;
import ucar.nc2.dt.grid.GeoGrid;
import ucar.nc2.dt.grid.GridDataset;
import ucar.nc2.time.CalendarDate;
import ucar.unidata.geoloc.ProjectionPointImpl;

public class IndexedDataSetSource implements Closeable {

	private final boolean wrapLongitude = true;

	private final DataSetSource source;
	private final TreeMap<Long, FileAndIndex> dataSetFileByTimestamp;
	private final long temporalResolution;
	private final GridCoordSystem coordinateSystem;
	private final CoordinateAxis1D xAxis;
	private final CoordinateAxis1D yAxis;
	private final int xAxisDirection;
	private final int yAxisDirection;

	private static class FileAndIndex {
		final File file;
		final int indexT;

		FileAndIndex(File file, int indexT) {
			this.file = file;
			this.indexT = indexT;
		}

	}

	public IndexedDataSetSource(DataSetSource source, String templateVariableName) throws Exception {
		this.source = source;
		this.dataSetFileByTimestamp = new TreeMap<>();
		GridCoordSystem coordinateSystem0 = null;
		for (File file : source.getDataSetFiles()) {
			GridDataset ds = source.getDataSet(file);
			GridCoordSystem coordinateSystem1 = ((GeoGrid) ds.findGridByShortName(templateVariableName))
					.getCoordinateSystem();
			CoordinateAxis1DTime timeAxis = coordinateSystem1.getTimeAxis1D();
			if (coordinateSystem0 == null) {
				coordinateSystem0 = coordinateSystem1;
			}
			List<CalendarDate> tss = timeAxis.getCalendarDates();
			for (int i = 0; i < tss.size(); i++)
				dataSetFileByTimestamp.put(tss.get(i).getMillis(), new FileAndIndex(file, i));
			source.removeDataSet(file);
		}
		this.coordinateSystem = coordinateSystem0;
		this.temporalResolution = (long) coordinateSystem.getTimeAxis1D().getTimeResolution().getValueInSeconds() * 1000;
		this.xAxis = ((ucar.nc2.dataset.CoordinateAxis1D) coordinateSystem.getXHorizAxis());
		this.yAxis = ((ucar.nc2.dataset.CoordinateAxis1D) coordinateSystem.getYHorizAxis());
		this.xAxisDirection = xAxis.getCoordValue(0) < xAxis.getCoordValue(1) ? 1 : -1;
		this.yAxisDirection = yAxis.getCoordValue(0) < yAxis.getCoordValue(1) ? 1 : -1;
	}

	public IndexedDataSetSource(File rootFile, FileFilter fileFilter, String templateVariableName) throws Exception {
		this(new DataSetSource(rootFile, fileFilter), templateVariableName);
	}

	public final long getTemporalResolution() {
		return temporalResolution;
	}

	public final int getSizeX() {
		return (int) xAxis.getSize();
	}

	public final int getSizeY() {
		return (int) yAxis.getSize();
	}

	public boolean findNeighbouringTimestamps(long ts, long[] timestampsOut) {
		Long timestampBefore = dataSetFileByTimestamp.floorKey(ts);
		Long timestampAfter = dataSetFileByTimestamp.ceilingKey(ts);
		if (timestampBefore != null
				&& timestampAfter != null
				&& (temporalResolution == 0 || (ts - timestampBefore < temporalResolution && timestampAfter - ts < temporalResolution))) {
			timestampsOut[0] = timestampBefore;
			timestampsOut[1] = timestampAfter;
			return true;
		} else
			return false;
	}

	/**
	 * 
	 * @return indexT 
	 */
	public int getGrids(long ts, String[] variableNames, GeoGrid[] gridsOut) throws Exception {
		FileAndIndex fileAndIndex = dataSetFileByTimestamp.get(ts);
		for (int i = 0; i < variableNames.length; i++)
			gridsOut[i] = ((GeoGrid) source.getDataSet(fileAndIndex.file).findGridByShortName(variableNames[i]));
		return fileAndIndex.indexT;
	}

	public boolean findNeighbouringCells(double lng, double lat, int[] indexesXOut, int[] indexesYOut,
			double[][] bilinearWeightsOut) {
		ProjectionPointImpl xy = coordinateSystem.getProjection().latLonToProj(lat, lng);
		int[] indexXY = coordinateSystem.findXYindexFromCoord(xy.x, xy.y, null);
		boolean found = true;
		if (indexXY[0] != -1 && indexXY[1] != -1) {
			double x0 = xAxis.getCoordValue(indexXY[0]);
			double y0 = yAxis.getCoordValue(indexXY[1]);
			if ((xy.x - x0) * xAxisDirection >= 0) {
				if (indexXY[0] < getSizeX() - 1) {
					indexesXOut[0] = indexXY[0];
					indexesXOut[1] = indexXY[0] + 1;
				} else {
					if (wrapLongitude) {
						indexesXOut[0] = indexXY[0];
						indexesXOut[1] = 0;
					} else
						found = false;
				}
			} else {
				if (indexXY[0] > 0) {
					indexesXOut[0] = indexXY[0] - 1;
					indexesXOut[1] = indexXY[0];
				} else {
					if (wrapLongitude) {
						indexesXOut[0] = getSizeX() - 1;
						indexesXOut[1] = indexXY[0];
					} else
						found = false;
				}
			}
			if ((xy.y - y0) * yAxisDirection >= 0) {
				indexesYOut[0] = indexXY[1];
				indexesYOut[1] = indexXY[1] + 1;
			} else {
				indexesYOut[0] = indexXY[1] - 1;
				indexesYOut[1] = indexXY[1];
			}
		} else
			found = false;
		if (found) {
			double dx = Math.abs(xAxis.getCoordValue(indexesXOut[0]) - xAxis.getCoordValue(indexesXOut[1]));
			double dy = Math.abs(yAxis.getCoordValue(indexesYOut[0]) - yAxis.getCoordValue(indexesYOut[1]));
			for (int i = 0; i < 2; i++)
				for (int j = 0; j < 2; j++)
					bilinearWeightsOut[i][j] = Math.abs(xAxis.getCoordValue(indexesXOut[1 - i]) - xy.x)
							* Math.abs(yAxis.getCoordValue(indexesYOut[1 - j]) - xy.y) / (dx * dy);
		}
		return found;
	}

	public long[] getTimestamps() {
		Long[] v0 = dataSetFileByTimestamp.keySet().toArray(new Long[0]);
		long[] v = new long[v0.length];
		for (int i = 0; i < v.length; i++)
			v[i] = v0[i];
		return v;
	}

	@Override
	public void close() throws IOException {
		source.close();
	}

}
