package rw.netcdf;

import java.io.Closeable;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.Collections;
import java.util.SortedSet;
import java.util.TreeSet;

import ucar.nc2.dt.grid.GridDataset;

public class DataSetSource implements Closeable {

	private SortedSet<File> dataSetFiles;
	private DataSetCache dataSetCache;

	public DataSetSource(File rootFile, FileFilter fileFilter, DataSetCache dataSetCache) {
		TreeSet<File> files = new TreeSet<>();
		findFiles(rootFile, fileFilter, files);
		this.dataSetFiles = Collections.unmodifiableSortedSet(files);
		this.dataSetCache = dataSetCache;
	}

	public DataSetSource(File rootFile, FileFilter fileFilter) {
		this(rootFile, fileFilter, new DataSetCache(100));
	}

	public DataSetSource(File rootFile) {
		this(rootFile, new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				return true;
			}
		}, new DataSetCache(100));
	}

	void findFiles(File rootFile, FileFilter fileFilter, TreeSet<File> filesOut) {
		if (rootFile.isDirectory())
			for (File childFile : rootFile.listFiles())
				findFiles(childFile, fileFilter, filesOut);
		else if (fileFilter.accept(rootFile))
			filesOut.add(rootFile);
	}

	public GridDataset getDataSet(File file) throws Exception {
		return dataSetCache.get(file);
	}

	public GridDataset removeDataSet(File file) throws Exception {
		return dataSetCache.remove(file);
	}

	public SortedSet<File> getDataSetFiles() {
		return dataSetFiles;
	}

	@Override
	public void close() throws IOException {
		dataSetCache.close();
	}

}
