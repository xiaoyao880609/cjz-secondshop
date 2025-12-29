package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 商品照片表
 *
 * @author cuijingzhi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Image {

	private int id;
	/**
	 * 商品ID
	 */
	private int goodId;
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 图片地址
	 */
	private String url;

}
