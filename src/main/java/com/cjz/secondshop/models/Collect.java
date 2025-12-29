package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 收藏表
 *
 * @author cuijingzhi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Collect {
	private int id;
	private int goodId;
	private String goodName;
	private int userId;
	private Good good;

}
