package com.cjz.secondshop.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.cjz.secondshop.models.FirstType;
import com.cjz.secondshop.models.Good;
import com.cjz.secondshop.models.Order;
import com.cjz.secondshop.models.User;
import com.cjz.secondshop.services.GoodService;
import com.cjz.secondshop.services.OrderService;
import com.cjz.secondshop.services.TypeService;
import com.cjz.secondshop.services.UserService;

@Controller // 声明这是一个控制器类，用于处理请求
@RequestMapping(value = "admin") // 声明这个类的请求路径是/admin
public class AdminController {
    private static final String TRUE = "true"; // 定义一个名为AdminController的公共类
    private static final String FALSE = "false";
    private final UserService userService; // 定义一个私有的最终的UserService类型的变量，用于调用用户服务
    private final GoodService goodService; // 定义一个私有的最终的GoodService类型的变量，用于调用商品服务
    private final TypeService typeService; // 定义一个私有的最终的TypeService类型的变量，用于调用类型服务
    private final OrderService orderService; // 定义一个私有的最终的OrderService类型的变量，用于调用订单服务

    @Autowired // 声明这是一个自动注入的构造方法，用于初始化变量
    public AdminController(UserService userService, GoodService goodService, TypeService typeService, OrderService orderService) { // 定义一个公共的构造方法，接收四个参数
        this.userService = userService; // 将参数赋值给变量
        this.goodService = goodService; // 将参数赋值给变量
        this.typeService = typeService; // 将参数赋值给变量
        this.orderService = orderService; // 将参数赋值给变量
    }

    @GetMapping(value = "/adminLogin") // 使用@GetMapping注解简化@RequestMapping注解，处理/adminLogin路径的GET请求
    public String getAdminLogin(){ // 定义一个公共的字符串类型的方法，返回一个视图名称
        return "admin/adminLogin"; // 返回admin/adminLogin视图名称，表示跳转到管理员登录页面
    }

    @PostMapping(value = "/adminLogin") // 使用@PostMapping注解简化@RequestMapping注解，处理/adminLogin路径的POST请求
    public String postAdminLogin(ModelMap model, @RequestParam(value = "email", required = false) String email, @RequestParam(value = "password", required = false) String password, HttpSession session) { // 定义一个公共的字符串类型的方法，接收四个参数，分别是模型映射对象，邮箱地址，密码和会话对象
        User admin = userService.getUserByEmail(email); // 调用用户服务的getUserByEmail方法，根据邮箱地址查询用户，并将结果赋值给User类型的变量admin
        String message; // 定义一个字符串类型的变量message，用于存储提示信息
        if (admin != null) { // 判断admin是否不为空，即是否存在该用户
            String mdsPass = DigestUtils.md5DigestAsHex((password + admin.getCode()).getBytes()); // 调用DigestUtils工具类的md5DigestAsHex方法，对密码和用户编码进行加密，并将结果赋值给字符串类型的变量mdsPass
            if (!mdsPass.equals(admin.getPassword())) { // 判断mdsPass是否不等于admin的密码，即是否密码错误
                message = "用户名或密码错误！"; // 将提示信息赋值为用户名或密码错误
            } else if (admin.getRoleId() != 101) { // 判断admin的角色id是否不等于101，即是否不是管理员角色
                message = "用户没有权限访问！"; // 将提示信息赋值为用户没有权限访问
            } else { // 否则表示登录成功
                session.setAttribute("admin", admin);// 将admin对象存储到会话对象中，作为登录状态标识
                session.setMaxInactiveInterval(1800);
                return "redirect:/admin/adminPage"; // 返回重定向到/admin/adminPage视图名称，表示跳转到管理员主页
            }
        } else { // 否则表示不存在该用户
            message = "用户不存在！"; // 将提示信息赋值为用户不存在
        }
        model.addAttribute("message", message); // 将message对象添加到模型映射对象中

        return "admin/adminLogin"; // 返回admin/adminLogin视图名称，
    }

    //处理管理员退出的请求
    @GetMapping("/adminLogout")
    public String adminLogout(@RequestParam(required = false, defaultValue = "false" )String adminLogout, @SessionAttribute("admin") User admin,HttpSession session){
        //如果参数为true，移除session中的管理员信息
        if (TRUE.equals(adminLogout)){
            session.removeAttribute("admin");
        }
        //如果参数为false，重定向到管理员页面
        else if (FALSE.equals(adminLogout)){
            return "redirect:/admin/adminPage";
        }
        //否则重定向到首页
        return "redirect:/";
    }


    //获取管理员页面的请求
    @GetMapping(value = "/adminPage")
    public String getAdminPage(ModelMap model, HttpSession session){
        //从session中获取管理员信息，如果为空，重定向到登录页面
        User admin = (User) session.getAttribute("admin");
        if (admin == null){
            return "redirect:/admin/adminLogin";
        }
        //获取所有商品列表，并为每个商品设置用户和二级分类信息
        List<Good> goodList = goodService.getAllGoodList();
        for (Good good : goodList) {
            good.setGoodUser(userService.getUserById(good.getUserId()));
            good.setGoodSecondType(typeService.getSecondTypeById(good.getSecondTypeId()));
        }
        //获取所有用户列表
        List<User> userList = userService.getAllUser();
        //获取所有一级分类列表
        List<FirstType> firstTypeList = typeService.getAllFirstType();
        //获取所有订单列表
        List<Order> orderList = orderService.getOrderList();
        //将数据添加到模型中
        model.addAttribute("goodList", goodList);
        model.addAttribute("userList", userList);
        model.addAttribute("firstTypeList", firstTypeList);
        model.addAttribute("orderList", orderList);
        //返回管理员页面视图
        return "admin/adminPage";
    }

    //更新用户状态的请求
    @SuppressWarnings("rawtypes")
	@RequestMapping(value = "/user/update/status/{statusId}&{userId}", method = RequestMethod.GET)
    public ResponseEntity updateUserStatus(@PathVariable Integer statusId, @PathVariable Integer userId){
        //调用服务层方法更新用户状态，返回是否成功
        Boolean success = userService.updateUserStatus(statusId, userId);
        if (success){
            //如果成功，重新获取所有用户列表并返回
            List<User> userList = userService.getAllUser();
            return ResponseEntity.ok(userList);
        }
        //否则返回失败信息
        return ResponseEntity.ok(success);
    }


    //处理删除用户的请求
    @SuppressWarnings("rawtypes")
	@GetMapping("/user/delete/{userId}")
    public ResponseEntity deleteUser(@PathVariable Integer userId){
        //调用服务层方法删除用户，返回是否成功
        Boolean success = userService.deleteUser(userId);
        if (success){
            //如果成功，重新获取所有用户列表并返回
            List<User> userList = userService.getAllUser();
            return ResponseEntity.ok(userList);
        }
        //否则返回失败信息
        return ResponseEntity.ok(success);
    }

}
