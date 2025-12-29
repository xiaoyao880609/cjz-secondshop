package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户表
 * @author cuijingzhi
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	private int id; //ID
	private String name; //姓名
	private String mobile; //手机
	private String email; //邮箱
	private String password; // 密码
	private String password2; //  确认密码
	private String code; // 信息
	private String photoUrl; // 图片地址
	private int roleId;
	private int statusId; // 状态
	private String gender; // 性别
	private String registerDate; // 注册时间
	private String address;  // 地址

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", name='" + name + '\'' +
				", mobile='" + mobile + '\'' +
				", email='" + email + '\'' +
				", password='" + password + '\'' +
				", password2='" + password2 + '\'' +
				", code='" + code + '\'' +
				", photoUrl='" + photoUrl + '\'' +
				", roleId=" + roleId +
				", statusId=" + statusId +
				", gender='" + gender + '\'' +
				", registerDate='" + registerDate + '\'' +
				", address='" + address + '\'' +
				'}';
	}
}
