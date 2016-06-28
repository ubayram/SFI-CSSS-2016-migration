package rw.netcdf;

import java.io.Closeable;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;

import ucar.nc2.dt.grid.GeoGrid;

/**
 * 
 * nearest neighbour interpolation is used
 *
 */
public class NetcdfReader1 implements Closeable {

	private final int indexZ;
	private final String[] variableNames;

	private final IndexedDataSetSource source;
	private final long[] timestamps = new long[2];
	private final int[] indexTs = new int[2];
	private final GeoGrid[][] geoGrids;
	private final double[][][] values;

	private long currentTimestamp = -1;

	public NetcdfReader1(IndexedDataSetSource source, int indexZ, String[] variableNames) throws Exception {
		this.source = source;
		this.indexZ = indexZ;
		this.variableNames = variableNames;
		this.geoGrids = new GeoGrid[2][variableNames.length];
		this.values = new double[2][variableNames.length][];
	}

	public NetcdfReader1(File rootFile, FileFilter fileFilter, int indexZ, String... variableNames) throws Exception {
		this(new IndexedDataSetSource(rootFile, fileFilter, variableNames[0]), indexZ, variableNames);
	}

	public NetcdfReader1(File rootFile, FileFilter fileFilter, String... variableNames) throws Exception {
		this(rootFile, fileFilter, 0, variableNames);
	}


	public NetcdfReader1(File rootFile,  String... variableNames) throws Exception {
		this(rootFile, new FileFilter() {
			
			@Override
			public boolean accept(File pathname) {
				return true;
			}
		},  variableNames);
	}

	public boolean moveToTimestamp(long ts) throws Exception {
		if (ts >= timestamps[0] && ts <= timestamps[1]) {
			this.currentTimestamp = ts;
			return true;
		} else if (source.findNeighbouringTimestamps(ts, timestamps)) {
			this.currentTimestamp = ts;
			for (int i = 0; i < 2; i++) {
				indexTs[i] = source.getGrids(timestamps[i], variableNames, geoGrids[i]);
				for (int j = 0; j < variableNames.length; j++)
					values[i][j] = (double[]) geoGrids[i][j].readYXData(indexTs[i], indexZ)
							.get1DJavaArray(double.class);
			}
			return true;
		} else
			return false;
	}

	public double[] getValues(double lng, double lat, double[] out) throws Exception {
		if (out == null)
			out = new double[variableNames.length];
		int[] indexesX = new int[2];
		int[] indexesY = new int[2];
		double[][] bilinearWeightsXy = new double[2][2];
		double[] bilinearWeightsT;
		if (source.getTemporalResolution() == 0)
			bilinearWeightsT = new double[] { 1, 0 };
		else if (currentTimestamp == timestamps[0])
			bilinearWeightsT = new double[] { 1, 0 };
		else if (currentTimestamp == timestamps[1])
			bilinearWeightsT = new double[] { 0, 1 };
		else
			bilinearWeightsT = new double[] {
					(timestamps[1] - currentTimestamp) * 1.0 / (timestamps[1] - timestamps[0]),
					(currentTimestamp - timestamps[0]) * 1.0 / (timestamps[1] - timestamps[0]) };
		if (source.findNeighbouringCells(lng, lat, indexesX, indexesY, bilinearWeightsXy)) {
			for (int iv = 0; iv < variableNames.length; iv++) {
				double sum = 0;
				for (int it = 0; it < 2; it++) {
					for (int ix = 0; ix < 2; ix++) {
						for (int iy = 0; iy < 2; iy++) {
							int indexXY = indexesX[ix] + indexesY[iy] * source.getSizeX();
							double weightXY = bilinearWeightsXy[ix][iy];
							double weightT = bilinearWeightsT[it];
							double v = values[it][iv][indexXY];
							sum += (v * weightXY * weightT);
						}
					}
				}
				out[iv] = sum;
			}
		}
		return out;
	}

	public long[] getTimestamps() {
		return source.getTimestamps();
	}

	@Override
	public void close() throws IOException {
		source.close();
	}

}
