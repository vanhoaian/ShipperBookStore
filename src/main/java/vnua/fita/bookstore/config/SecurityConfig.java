package vnua.fita.bookstore.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vnua.fita.bookstore.util.Constant;

public class SecurityConfig {
	private static final Map<Byte, List<String>> mapConfig = new HashMap<Byte, List<String>>();

	static {
		init();
	}

	private static void init() {
		// TODO Auto-generated method stub
		List<String> urlPatterns1 = new ArrayList<String>();
		urlPatterns1.add("/accountInfo");
		urlPatterns1.add("/cartBook");
		urlPatterns1.add("/customerOrderList");
		urlPatterns1.add("/order");
		mapConfig.put(Constant.CUSTOMER_ROLE, urlPatterns1);

		List<String> urlPatterns2 = new ArrayList<String>();
		urlPatterns2.add("/accountInfo");
		urlPatterns2.add("/cartBook");
		urlPatterns2.add("/adminHome");
		urlPatterns2.add("/adminOrderList");
		urlPatterns2.add("/createBook");
		urlPatterns2.add("/deleteBook");
		urlPatterns2.add("/editBook");
		mapConfig.put(Constant.ADMIN_ROLE, urlPatterns2);

		List<String> urlPatterns3 = new ArrayList<String>();
		urlPatterns3.add("/accountInfo");
		urlPatterns3.add("/delivering");
		urlPatterns3.add("/delivered");
		urlPatterns3.add("/reject");
		mapConfig.put(Constant.SHIPPER_ROLE, urlPatterns3);
	}

	public static boolean checkPermission(byte role, String servletPath) {
		List<String> urlPatternsForRole = mapConfig.get(role);
		if (urlPatternsForRole.contains(servletPath)) {
			return true;
		}
		return false;
	}

	public static boolean checkDenyUrlPattern(String servletPath) {
		for (Map.Entry<Byte, List<String>> entry : mapConfig.entrySet()) {
			List<String> urlPatterns = entry.getValue();
			if (urlPatterns.contains(servletPath)) {
				return true;
			}
		}
		return false;
	}
}
