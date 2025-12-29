package com.cjz.secondshop.utils;

import java.util.regex.Pattern;

/**
 * 信息检查
 * @author RTX 9090
 */
public class InfoCheck {

	/**
	 * 用户邮箱格式检查
	 */
	public static String CHECK_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

	public boolean isEmail(String email) {
		return Pattern.matches(CHECK_EMAIL, email);
	}

	/**
	 * 用户电话格式检查
	 */
	public static String CHECK_MOBILE = "^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\\d{8}$";

	public boolean isMobile(String mobile) {
		return Pattern.matches(CHECK_MOBILE, mobile);
	}

}
