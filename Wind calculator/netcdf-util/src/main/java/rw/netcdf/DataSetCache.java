package rw.netcdf;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;

import org.apache.commons.collections4.map.LRUMap;

import ucar.nc2.dt.grid.GridDataset;

public class DataSetCache implements Closeable {

	private final LRUMap<File, GridDataset> dataSetByFile;

	public DataSetCache(int maxSize) {
		dataSetByFile = new LRUMap<File, GridDataset>(maxSize) {
		};
	}

	public synchronized GridDataset get(File file) throws Exception {
		if (!dataSetByFile.containsKey(file)) {
			if (dataSetByFile.isFull()) {
				File file0 = dataSetByFile.firstKey();
				GridDataset ds = dataSetByFile.get(file0);
				dataSetByFile.remove(file0);
				try {
					ds.close();
				} catch (Exception e) {
				}
			}
			dataSetByFile.put(file, GridDataset.open(file.getAbsolutePath()));
		}
		return dataSetByFile.get(file);
	}

	public synchronized GridDataset remove(File file) throws Exception {
		GridDataset ds = dataSetByFile.remove(file);
		if (ds != null)
			try {
				ds.close();
			} catch (Exception e) {
			}
		return ds;
	}

	@Override
	public void close() throws IOException {
		for (GridDataset ds : dataSetByFile.values())
			ds.close();
	}

}
