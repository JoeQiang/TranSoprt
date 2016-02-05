package test;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

public class DealerServiceTest {
	@Test
	public void test() {
		SimpleDateFormat format = new SimpleDateFormat("yyyymmdd");
		String date = format.format(new Date());
		String id = String.valueOf(41);
		String seqNum = "";
		switch (id.length()) {
		case 1:
			seqNum = "00".concat(id);
			break;
		case 2:
			seqNum = "0".concat(id);
			break;
		default:
			seqNum = id;
			break;
		}
		StringBuilder seq = new StringBuilder(date).append(seqNum);
	}
}
