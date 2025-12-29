package com.cjz.secondshop.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 回复表
 *
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private int reviewId; // 回复的ID
	private String fromUser;// 回复人
	private int fromUserId;// 回复人ID
	private String toUser;// 被回复人
	private int toUserId;// 被回复人ID
	private String text;// 回复内容
	private String uploadDate; // 回复时间
	private int status; // 状态

}
