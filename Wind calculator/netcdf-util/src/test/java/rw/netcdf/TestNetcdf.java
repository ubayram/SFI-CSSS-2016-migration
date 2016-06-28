package rw.netcdf;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

import junit.framework.TestCase;

public class TestNetcdf extends TestCase {

	public void test() throws Exception {
		NetcdfReader1 r = new NetcdfReader1(new File("/tmp/bart/sfc"), new FileFilterRegex(".*165\\.128.*\\.grib"), 0,
				"10_metre_U_wind_component_surface");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		df.setTimeZone(TimeZone.getTimeZone("GMT"));
		long ts = df.parse("2014-01-01 00:00:00").getTime();
		for (int i = 0; i < 7; i++) {
			if (r.moveToTimestamp(ts + 60 * 60 * 1000 * i))
				System.out.println(r.getValues(6, 81.7, null)[0]);
		}
		r.close();
	}

	public void test2() throws Exception {
		NetcdfReader1 r = new NetcdfReader1(new File("/tmp/bart/pl/850"), new FileFilterRegex(
				".*131\\\\.128.*\\\\.grib"), 0, "U_velocity_isobaric");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		df.setTimeZone(TimeZone.getTimeZone("GMT"));
		long ts = df.parse("2014-01-01 00:00:00").getTime();
		for (int i = 0; i < 7; i++) {
			if (r.moveToTimestamp(ts + 60 * 60 * 1000 * i))
				System.out.println(r.getValues(6, 81, null)[0]);
		}
		r.close();
	}
}
