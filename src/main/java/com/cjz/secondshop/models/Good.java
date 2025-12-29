package com.cjz.secondshop.models;

import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 物品表
 * @author cuijingzhi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Good {
	private int id;
	/**
	 * 商品名字
	 */
	private String name;
	/**
	 * 图片地址
	 */
	private String photoUrl;
	/**
	 * 一级菜单
	 */
	private int firstTypeId;
	/**
	 * 二级菜单
	 */
	private int secondTypeId;
	/**
	 * 商品二级菜单
	 */
	private SecondType goodSecondType;
	/**
	 * 描述
	 */
	private String describe;
	/**
	 * 上传时间
	 */
	private String uploadDate;
	/**
	 * 价格
	 */
	private float prise;
	/**
	 * 商品状态
	 */
	private int statusId;
	/**
	 * 用户ID
	 */
	private int userId;
	private User goodUser;
	private String update;

	public void setUpdate(java.sql.Timestamp update) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.update = sdf.format(update);
	}

}
