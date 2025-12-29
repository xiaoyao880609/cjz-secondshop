package com.cjz.secondshop.models;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 一级分类表
 *
 * @author cuijingzhi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class FirstType {
	private int id;
	private String name;
	private List<SecondType> secondTypes;
}