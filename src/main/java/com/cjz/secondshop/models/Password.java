package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 密码表
 * @author cuijingzhi
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Password {
	/**
		用户ID
	 */
	private int userId;
	/**
	 旧密码
	 */
	private String oldPassword;
	/**
	 新密码
	 */
	private String newPassword;

}
