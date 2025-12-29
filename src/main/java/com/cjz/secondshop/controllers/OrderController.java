package com.cjz.secondshop.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cjz.secondshop.models.Order;
import com.cjz.secondshop.models.User;
import com.cjz.secondshop.services.GoodService;
import com.cjz.secondshop.services.OrderService;
import com.cjz.secondshop.services.UserService;

/**
 * @author cuijingzhi
 */
@Controller
public class OrderController {
	private final GoodService goodService;
	private final OrderService orderService;
	private final UserService userService;

	@Autowired
	public OrderController(GoodService goodService, OrderService orderService, UserService userService) {
		this.goodService = goodService;
		this.orderService = orderService;
		this.userService = userService;
	}

	// 这是表示这个方法用于处理/user/orderInfo的GET请求
	@RequestMapping(value = "/user/orderInfo", method = RequestMethod.GET)
	public String getOrderInfo(ModelMap model,
				@RequestParam(value = "orderId", required = false) Integer orderId, HttpSession session) {
		// 从会话中获取用户对象
		User sessionUser = (User) session.getAttribute("user");
		// 通过订单id查询订单对象
		Order orderInfo = orderService.getOrderById(orderId);
		// 通过订单对象的卖家id查询卖家对象
		User user1 = userService.getUserById(orderInfo.getSellerId());
		// 通过订单对象的买家id查询买家对象
		User user2 = userService.getUserById(orderInfo.getCustomerId());
		// 判断用户对象是否为空
		if (sessionUser != null) {
			// 如果不为空，表示已登录，从数据库中查询用户的最新信息，并给订单对象设置卖家和买家的地址属性
			orderInfo.setSellerAddress(user1.getAddress());
			orderInfo.setCustomerAddress(user2.getAddress());
			// 更新会话和模型中的用户信息
			session.setAttribute("user", sessionUser);
			model.addAttribute("user", sessionUser);
		}else {
			// 如果为空，表示未登录，重定向到首页
			return "redirect:/";
		}
		// 调用orderService的getOtherOrderByCustomerId方法，传入用户id和订单id，获取其他的订单列表
		List<Order> orders = orderService.getOtherOrderByCustomerId(
				sessionUser.getId(), orderId);
		// 打印订单对象到控制台（调试用）
		System.out.println(orderInfo);
		// 把订单对象添加到模型中，以便在视图中使用
		model.addAttribute("orderInfo", orderInfo);
		// 把其他的订单列表添加到模型中，以便在视图中使用
		model.addAttribute("orders", orders);
		// 返回user/orderInfo，表示要跳转到user文件夹下的orderInfo.jsp页面
		return "user/orderInfo";
	}

	//处理查看订单的请求
	@GetMapping(value = "/admin/orderInfo")
	public String viewOrder(@RequestParam Integer orderId, ModelMap model, HttpSession session){
		//从session中获取管理员信息，如果为空，重定向到登录页面
		User admin = (User) session.getAttribute("admin");
		if (admin == null){
			return "redirect:/admin/adminLogin";
		}
		//根据订单id获取订单信息
		// 通过订单id查询订单对象
		Order orderInfo = orderService.getOrderById(orderId);
		// 通过订单对象的卖家id查询卖家对象
		User user1 = userService.getUserById(orderInfo.getSellerId());
		// 通过订单对象的买家id查询买家对象
		User user2 = userService.getUserById(orderInfo.getCustomerId());
		orderInfo.setSellerAddress(user1.getAddress());
		orderInfo.setCustomerAddress(user2.getAddress());
		//将订单信息添加到模型中
		model.addAttribute("orderInfo", orderInfo);
//        model.addAttribute("orders", orders);
		return "admin/orderInfo";
	}

	@RequestMapping(value = "/user/sellerInfo", method = RequestMethod.GET)
	public String getSellerInfo(ModelMap model,
			@RequestParam(value = "orderId", required = false) Integer orderId,
			HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		Order orderInfo = orderService.getOrderById(orderId);
		User user1 = userService.getUserById(orderInfo.getSellerId());
		User user2 = userService.getUserById(orderInfo.getCustomerId());
		if (sessionUser != null) {
			// 从数据库中查询用户的最新信息
			sessionUser = userService.getUserById(sessionUser.getId());
			// 更新会话和模型中的用户信息
			session.setAttribute("user", sessionUser);
			model.addAttribute("user", sessionUser);
		}else {
			return "redirect:/";
		}
//		if (!user1.getAddress().equals(orderInfo.getSellerAddress()) && !user2.getAddress().equals(orderInfo.getCustomerAddress())){
//			orderInfo.setSellerAddress(user1.getAddress());
//			orderInfo.setCustomerAddress(user2.getAddress());
//		}
		List<Order> orders = orderService.getOtherOrderBySellerId(
				sessionUser.getId(), orderId);
		model.addAttribute("orderInfo", orderInfo);
		model.addAttribute("orders", orders);
		System.out.println("sellerInfo.size:" + orders.size());
		return "user/sellerInfo";
	}

	@RequestMapping(value = "/user/order/delete/{orderId}", method = RequestMethod.GET)
	public ResponseEntity deleteOrderById(@PathVariable Integer orderId) {
		boolean success = false;
		Order order = orderService.getOrderById(orderId);
		if (order.getEndDate() != null){
			success = orderService.deleteOrderById(orderId) > 0;
		}else {
			goodService.updateGoodStatusId(1,order.getGoodId());
			success = orderService.deleteOrderById(orderId) > 0;
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/cancel/status/{orderId}&{statusId}&{goodId}", method = RequestMethod.GET)
	public ResponseEntity cancelOrderById(@PathVariable Integer orderId,
			 @PathVariable Integer statusId,@PathVariable Integer goodId) {
		Boolean success = orderService.updateStatus(statusId, orderId) > 0;
		Order order = orderService.getOrderById(orderId);
		if (success) {
			if (order.getGoodId() == goodId){
				goodService.updateGoodStatusId(1,order.getGoodId());
				order = orderService.getOrderById(orderId);
				return ResponseEntity.ok(order);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/sellerOrder/delete/{orderId}&{goodId}", method = RequestMethod.GET)
	public ResponseEntity deleteSellerOrderById(@PathVariable Integer orderId,
			@PathVariable Integer goodId) {
		Boolean success;
		success = goodService.updateGoodStatusId(1, goodId) > 0;
		if (success) {
			success = orderService.deleteOrderById(orderId) > 0;
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/update/status/{orderId}&{statusId}", method = RequestMethod.GET)
	public ResponseEntity updateOrderStatus(@PathVariable Integer orderId,
			@PathVariable Integer statusId) {
		Boolean success = orderService.updateStatus(statusId, orderId) > 0;
		if (success) {
			Order order = orderService.getOrderById(orderId);
			return ResponseEntity.ok(order);
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/create", method = RequestMethod.POST)
	public ResponseEntity createOrder(@RequestBody Order order) {
		boolean success = orderService.insertOrder(order) > 0;
		System.out.println(order);
		if (success) {
			success = goodService.updateGoodStatusId(0, order.getGoodId()) > 0;
			if (success) {
				return ResponseEntity.ok(order.getId());
			} else {
				orderService.deleteOrderById(order.getId());
				return ResponseEntity.ok(success);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/allOrder", method = RequestMethod.GET)
	public ResponseEntity getAllOrders() {
		List<Order> orderList = orderService.getOrderList();
		return ResponseEntity.ok(orderList);
	}
}
