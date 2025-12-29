package com.cjz.secondshop.models;

import lombok.Data;

/**
 * 头像表
 * @author cuijingzhi
 */

@Data
public class Photo {
	private int id; //id
	private int userId; //用户ID
	private String name; //名字
	private String url; //图片地址

}
