package rw.netcdf;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

public class FileFilterRegex implements FileFilter {

	List<String> regexes = new ArrayList<String>();

	public FileFilterRegex(String... regexes) {
		this.regexes.addAll(Arrays.asList(regexes));
	}

	@Override
	public boolean accept(File pathname) {
		for (String regex : regexes)
			if (!Pattern.matches(regex, pathname.getName()))
				return false;
		return true;
	}

	public FileFilter narrow(final FileFilter filter) {
		return new FileFilter() {
			@Override
			public boolean accept(File pathname) {
				return FileFilterRegex.this.accept(pathname) & filter.accept(pathname);
			}
		};
	}

}
