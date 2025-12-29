/*
 Navicat Premium Dump SQL

 Source Server         : secondshop
 Source Server Type    : MySQL
 Source Server Version : 80011 (8.0.11)
 Source Host           : localhost:3306
 Source Schema         : secondshop

 Target Server Type    : MySQL
 Target Server Version : 80011 (8.0.11)
 File Encoding         : 65001

 Date: 29/12/2025 14:26:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for collect_table
-- ----------------------------
DROP TABLE IF EXISTS `collect_table`;
CREATE TABLE `collect_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `good_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `good_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect_table
-- ----------------------------
INSERT INTO `collect_table` VALUES (2, 3, '毛绒玩具', 4);

-- ----------------------------
-- Table structure for first_type_table
-- ----------------------------
DROP TABLE IF EXISTS `first_type_table`;
CREATE TABLE `first_type_table`  (
  `id` int(11) NOT NULL COMMENT '第一分类ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第一分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '第一分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of first_type_table
-- ----------------------------
INSERT INTO `first_type_table` VALUES (1, '电子产品');
INSERT INTO `first_type_table` VALUES (2, '生活用品');

-- ----------------------------
-- Table structure for good_table
-- ----------------------------
DROP TABLE IF EXISTS `good_table`;
CREATE TABLE `good_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
  `photo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片URL',
  `first_type_id` int(11) NULL DEFAULT NULL COMMENT '第一分类ID',
  `second_type_id` int(11) NULL DEFAULT NULL COMMENT '第二分类ID',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品描述',
  `upload_date` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `prise` float NULL DEFAULT NULL COMMENT '商品价格',
  `status_id` int(11) NULL DEFAULT NULL COMMENT '状态ID',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `update` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good_table
-- ----------------------------
INSERT INTO `good_table` VALUES (1, 'iphone13', '/statics/image/goods/3/1/1lWWJZSg8WH.jpeg', 1, 1001, '此处省略500字', '2025-12-25 20:12:37', 500, 0, 3, '2025-12-26 09:26:44');
INSERT INTO `good_table` VALUES (2, 'iphone', '/statics/image/goods/3/2/2HTAVQa9hjK.jpeg', 1, 1001, '二手苹果手机。', '2025-12-26 09:35:05', 600, 0, 3, '2025-12-26 12:03:57');
INSERT INTO `good_table` VALUES (3, '毛绒玩具', '/images/goods/3/3/3hWh65Wqwbe.jpeg', 2, 2001, '二手毛绒玩具，便宜甩卖，求打包带走！', '2025-12-26 09:36:01', 99, 1, 3, '2025-12-26 19:42:47');
INSERT INTO `good_table` VALUES (4, 'iphone13', '/images/goods/4/4/4hGDvJjeZ6H.jpeg', 1, 1001, '用了3年的手机便宜甩了！', '2025-12-26 12:50:20', 600, 1, 4, '2025-12-26 19:53:05');
INSERT INTO `good_table` VALUES (5, '华为手机', '/images/goods/3/5/5pju21GM6O4.jpeg', 1, 1001, '华为手机便宜转让！', '2025-12-26 12:54:34', 500, 1, 3, '2025-12-26 19:55:52');
INSERT INTO `good_table` VALUES (6, '小米手机', '/images/goods/3/6/67On3oWdUQS.jpeg', 1, 1001, '小米手机便宜转让！', '2025-12-26 12:55:08', 400, 1, 3, '2025-12-26 19:55:36');
INSERT INTO `good_table` VALUES (7, '联想笔记本', '/images/goods/4/7/78gd78Rf3Gj.jpeg', 1, 1002, '联想笔记本便宜了。', '2025-12-26 17:24:22', 800, 1, 4, '2025-12-26 19:52:40');
INSERT INTO `good_table` VALUES (8, '海尔冰箱', '/images/goods/4/8/8Drpsic5PuV.jpeg', 1, 1004, '海尔二手冰箱。', '2025-12-26 17:26:25', 0, 1, 4, '2025-12-26 19:53:26');
INSERT INTO `good_table` VALUES (9, '小米洗衣机', '/images/goods/4/9/9xkVePnxG7V.jpeg', 1, 1003, '小米二手洗衣机！', '2025-12-26 17:30:21', 750, 1, 4, '2025-12-26 19:54:02');
INSERT INTO `good_table` VALUES (10, '二手桌子', '/images/goods/4/10/10AHAUbHK9a4.jpeg', 2, 2002, '二手桌子', '2025-12-26 17:32:04', 50, 1, 4, '2025-12-26 19:54:21');
INSERT INTO `good_table` VALUES (11, '二手椅子', '/images/goods/4/11/11rp7yD57GeR.jpeg', 2, 2003, '二手椅子！', '2025-12-26 17:33:06', 99, 1, 4, '2025-12-26 19:54:49');
INSERT INTO `good_table` VALUES (12, 'vivo手机', '/images/goods/3/12/12C5ca4WxZs4.jpeg', 1, 1001, '二手vivo手机', '2025-12-26 20:01:14', 111, 1, 3, '2025-12-26 20:02:31');

-- ----------------------------
-- Table structure for image_table
-- ----------------------------
DROP TABLE IF EXISTS `image_table`;
CREATE TABLE `image_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品图片ID',
  `good_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图片管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of image_table
-- ----------------------------
INSERT INTO `image_table` VALUES (5, 1, '18RY38zk3fP.jpeg', '/statics/image/goods/3/1/18RY38zk3fP.jpeg');
INSERT INTO `image_table` VALUES (6, 1, '1OH82BBec4U.jpeg', '/statics/image/goods/3/1/1OH82BBec4U.jpeg');
INSERT INTO `image_table` VALUES (17, 2, '2A3s4egPY6P.jpeg', '/statics/image/goods/3/2/2A3s4egPY6P.jpeg');
INSERT INTO `image_table` VALUES (18, 2, '2djZ7HGfmjl.jpeg', '/statics/image/goods/3/2/2djZ7HGfmjl.jpeg');
INSERT INTO `image_table` VALUES (56, 3, '3EgreEHUZ1I.jpeg', '/images/goods/3/3/3EgreEHUZ1I.jpeg');
INSERT INTO `image_table` VALUES (57, 3, '3A6JBpPtWGv.jpeg', '/images/goods/3/3/3A6JBpPtWGv.jpeg');
INSERT INTO `image_table` VALUES (58, 7, '7JjzuwERS3J.jpeg', '/images/goods/4/7/7JjzuwERS3J.jpeg');
INSERT INTO `image_table` VALUES (59, 7, '74dPumNrfNd.jpeg', '/images/goods/4/7/74dPumNrfNd.jpeg');
INSERT INTO `image_table` VALUES (60, 4, '44dB96Lpvja.jpeg', '/images/goods/4/4/44dB96Lpvja.jpeg');
INSERT INTO `image_table` VALUES (61, 4, '4xlGNAe2eIY.jpeg', '/images/goods/4/4/4xlGNAe2eIY.jpeg');
INSERT INTO `image_table` VALUES (62, 8, '8m74onfMmZq.jpeg', '/images/goods/4/8/8m74onfMmZq.jpeg');
INSERT INTO `image_table` VALUES (63, 8, '8BOB3F9guWA.jpeg', '/images/goods/4/8/8BOB3F9guWA.jpeg');
INSERT INTO `image_table` VALUES (64, 9, '9dzhZJXG8DG.jpeg', '/images/goods/4/9/9dzhZJXG8DG.jpeg');
INSERT INTO `image_table` VALUES (65, 9, '9qQMeMMhyaC.jpeg', '/images/goods/4/9/9qQMeMMhyaC.jpeg');
INSERT INTO `image_table` VALUES (66, 10, '10fAsKahFd8k.jpeg', '/images/goods/4/10/10fAsKahFd8k.jpeg');
INSERT INTO `image_table` VALUES (67, 11, '112PolNGj3Cd.jpeg', '/images/goods/4/11/112PolNGj3Cd.jpeg');
INSERT INTO `image_table` VALUES (68, 6, '67vctS3vg7P.jpeg', '/images/goods/3/6/67vctS3vg7P.jpeg');
INSERT INTO `image_table` VALUES (69, 6, '6Ya99DWDagE.jpeg', '/images/goods/3/6/6Ya99DWDagE.jpeg');
INSERT INTO `image_table` VALUES (70, 5, '5IUaTGE9fz4.jpeg', '/images/goods/3/5/5IUaTGE9fz4.jpeg');
INSERT INTO `image_table` VALUES (71, 5, '5abyIzDKbjX.jpeg', '/images/goods/3/5/5abyIzDKbjX.jpeg');
INSERT INTO `image_table` VALUES (72, 12, '12VeevM5lz9v.jpeg', '/images/goods/3/12/12VeevM5lz9v.jpeg');

-- ----------------------------
-- Table structure for order_table
-- ----------------------------
DROP TABLE IF EXISTS `order_table`;
CREATE TABLE `order_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `good_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
  `seller` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卖家',
  `seller_id` int(11) NULL DEFAULT NULL COMMENT '卖家ID',
  `seller_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卖家手机',
  `seller_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卖家地址',
  `customer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT '顾客ID',
  `customer_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客手机',
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客地址',
  `good_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `money` int(11) NULL DEFAULT NULL COMMENT '金额',
  `submit_date` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `status_id` int(11) NULL DEFAULT NULL COMMENT '状态ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_table
-- ----------------------------
INSERT INTO `order_table` VALUES (1, 'iphone13', 'zhangsan', 3, '15100000001', '大连', 'zhaosi', 4, '15100000002', '北京', 1, 500, '2025-12-26 09:26:44', '2025-12-26 09:26:51', 3);

-- ----------------------------
-- Table structure for reply_table
-- ----------------------------
DROP TABLE IF EXISTS `reply_table`;
CREATE TABLE `reply_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '回复ID',
  `review_id` int(11) NULL DEFAULT NULL COMMENT '评论ID',
  `from_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回复人',
  `from_user_id` int(11) NULL DEFAULT NULL COMMENT '回复人ID',
  `to_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '被回复人',
  `to_user_id` int(11) NULL DEFAULT NULL COMMENT '被回复人ID',
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `upload_date` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '回复表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reply_table
-- ----------------------------
INSERT INTO `reply_table` VALUES (2, 2, 'zhangsan', 3, 'zhaosi', 4, '一口价！', '2025-12-26 11:56:55', 1);
INSERT INTO `reply_table` VALUES (3, 2, 'zhaosi', 4, 'zhangsan', 4, '好吧...', '2025-12-26 11:57:30', 0);

-- ----------------------------
-- Table structure for review_table
-- ----------------------------
DROP TABLE IF EXISTS `review_table`;
CREATE TABLE `review_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `good_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `from_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论人',
  `from_user_id` int(11) NULL DEFAULT NULL COMMENT '评论人ID',
  `to_user_id` int(11) NULL DEFAULT NULL COMMENT '被评论人ID',
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `upload_date` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review_table
-- ----------------------------
INSERT INTO `review_table` VALUES (1, 3, 'zhangsan', 3, 3, '求带走！给钱就卖啦', '2025-12-26 11:46:34', 0);
INSERT INTO `review_table` VALUES (2, 3, 'zhaosi', 4, 3, '还能便宜点吗？', '2025-12-26 11:47:08', 1);

-- ----------------------------
-- Table structure for second_type_table
-- ----------------------------
DROP TABLE IF EXISTS `second_type_table`;
CREATE TABLE `second_type_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_type_id` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2004 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '第二分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of second_type_table
-- ----------------------------
INSERT INTO `second_type_table` VALUES (1001, 1, '手机');
INSERT INTO `second_type_table` VALUES (1002, 1, '电脑');
INSERT INTO `second_type_table` VALUES (1003, 1, '洗衣机');
INSERT INTO `second_type_table` VALUES (1004, 1, '冰箱');
INSERT INTO `second_type_table` VALUES (2001, 2, '玩具');
INSERT INTO `second_type_table` VALUES (2002, 2, '桌子');
INSERT INTO `second_type_table` VALUES (2003, 2, '椅子');

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `photo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `status_id` int(11) NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `register_date` datetime NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES (2, 'admin', '15100000000', 'admin@mail.com', 'c2ca6ff0b2bc705897b78c26cf208d00', NULL, 'xrvGJ', '/statics/image/photos/default/default.png', 101, 4, '男', '2025-12-25 18:57:09', 'test');
INSERT INTO `user_table` VALUES (3, 'zhangsan', '15100000001', 'zhangsan@mail.com', '1794d76ba0f1437c43e4b11f6a6d3045', NULL, 'xjj2j', '/statics/image/photos/default/default.png', 102, 4, '男', '2025-12-25 18:59:40', '大连');
INSERT INTO `user_table` VALUES (4, 'zhaosi', '15100000002', 'zhaosi@mail.com', 'b853257230b72f79c461586c5a950926', NULL, 'VVWvL', '/statics/image/photos/default/default.png', 102, 4, '男', '2025-12-25 20:21:45', '北京');

SET FOREIGN_KEY_CHECKS = 1;
