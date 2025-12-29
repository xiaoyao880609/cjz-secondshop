package com.cjz.secondshop.mappers;

import org.apache.ibatis.annotations.*;

import com.cjz.secondshop.models.Order;

import java.util.List;
@Mapper
public interface OrderMapper {
	@Select("select * from order_table where customer_id = #{customerId} ORDER BY submit_date DESC;")
	List<Order> getOrderByCustomerId(Integer customerId);

	@Select("select * from order_table ORDER BY submit_date DESC;")
	List<Order> getOrderList();

	@Select("select * from order_table where seller_id = #{sellerId} ORDER BY submit_date DESC;")
	List<Order> getOrderBySellerId(Integer sellerId);

	@Select("select * from order_table where id = #{orderId} ORDER BY submit_date DESC;")
	Order getOrderById(Integer orderId);

	@Select("select * from order_table where customer_id = #{0} and id != #{1} ORDER BY submit_date DESC;")
	List<Order> getOtherOrderByCustomerId(Integer customerId, Integer orderId);

	@Select("select * from order_table where seller_id = #{0} and id != #{1} ORDER BY submit_date DESC;")
	List<Order> getOtherOrderBySellerId(Integer sellerId, Integer orderId);

	@Update("update order_table set status_id = #{0}, end_date = now() where id = #{1};")
	int updateStatus(Integer statusId, Integer orderId);

	@Delete("DELETE FROM order_table WHERE id = #{orderId};")
	int deleteOrderById(Integer orderId);

	@Insert("insert into order_table(good_name, seller, seller_id, seller_mobile, seller_address, customer, customer_id, customer_mobile, customer_address, good_id, money, status_id, submit_date ) "
			+ "values(#{goodName}, #{seller}, #{sellerId}, #{sellerMobile}, #{sellerAddress}, #{customer}, #{customerId}, #{customerMobile}, #{customerAddress}, #{goodId}, #{money}, 2, now());")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int insertOrder(Order order);
}
