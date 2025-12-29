package com.cjz.secondshop.models;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 评论表
 * @author cuijingzhi
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Review {
	private int id;
	private int goodId; // 物品id
	private String fromUser; //评论人
	private int fromUserId; //评论人ID
	private int toUserId; //被评论人ID
	private String text; //内容
	private String uploadDate; //评论时间
	private List<Reply> replys;//回复内容
	private int status; // 状态

}
