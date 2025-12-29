package com.cjz.secondshop.models;

import lombok.Data;

/**
 * 权限表
 * @author cuijingzhi
 */

@Data
public class Role {
	private int id;  //id
	private String code;  // 码
	private String role;  //权限

}
