package com.cjz.secondshop.models;

import lombok.Data;

/**
 * 二级分类表
 * @author cuijingzhi
 */

@Data
public class SecondType {
	private int id; // ID
	private int firstTypeId; // 一级菜单ID
	private String name; // 菜单名字

}
