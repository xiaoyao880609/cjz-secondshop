package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 订单表
 *
 * @author cuijingzhi
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
	private int id;
	/**
	 * 商品名称
	 */
	private String goodName;
	/**
	 * 卖家
	 */
	private String seller;
	/**
	 * 卖家ID
	 */
	private int sellerId;

	private String sellerMobile;

	private String sellerAddress;
	/**
	 * 顾客
	 */
	private String customer;
	/**
	 * 顾客ID
	 */
	private int customerId;

	private String customerMobile;

	private String customerAddress;
	/**
	 * 商品ID
	 */
	private int goodId;
	/**
	 * 价格
	 */
	private int money;
	/**
	 * 提交时间
	 */
	private String submitDate;
	/**
	 * 收货时间
	 */
	private String endDate;
	/**
	 * 状态
	 */
	private int statusId;

	@Override
	public String toString() {
		return "Order{" +
				"id=" + id +
				", goodName='" + goodName + '\'' +
				", seller='" + seller + '\'' +
				", sellerId=" + sellerId +
				", sellerPhone='" + sellerMobile + '\'' +
				", sellerAddress='" + sellerAddress + '\'' +
				", customer='" + customer + '\'' +
				", customerId=" + customerId +
				", customerPhone=" + customerMobile +
				", customerAddress=" + customerAddress +
				", goodId=" + goodId +
				", money=" + money +
				", submitDate='" + submitDate + '\'' +
				", endDate='" + endDate + '\'' +
				", statusId=" + statusId +
				'}';
	}
}
