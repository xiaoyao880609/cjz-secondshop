package com.cjz.secondshop.controllers;

import com.cjz.secondshop.models.User;
import com.cjz.secondshop.services.UserService;
import com.cjz.secondshop.utils.InfoCheck;
import com.cjz.secondshop.utils.RandomString;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Map;

@Controller
public class HomeController {
    private final UserService userService;

    @Autowired
    public HomeController(UserService userService) {
        this.userService = userService;
    }

    //表示这个方法用于处理/login的GET请求
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    // 这是一个方法，返回一个字符串，表示要跳转到的视图名
    public String loginPage(ModelMap mode, HttpServletRequest request) {
        // 从请求头中获取Referer字段，表示上一个页面的URL
        String preURL = request.getHeader("Referer");
        // 把preURL添加到模型中，以便在视图中使用
        mode.addAttribute("preURL", preURL);
        // 返回home/login，表示要跳转到home文件夹下的login.jsp页面
        return "home/login";
    }

    // 这是一个注解，表示这个方法用于处理/login的POST请求
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    // 这是一个方法，返回一个字符串，表示要跳转到的视图名
    public String loginSubmit(ModelMap model,
                              // 这是一个参数，表示上一个页面的URL，如果没有则为空字符串
                              @RequestParam(value = "preURL", required = false, defaultValue = "") String preURL,
                              // 这是一个参数，表示用户输入的邮箱
                              @RequestParam(value = "email", required = false) String email,
                              // 这是一个参数，表示用户输入的密码
                              @RequestParam(value = "password", required = false) String password,
                              // 这是一个参数，表示会话对象
                              HttpSession session) {
        // 通过邮箱查询用户对象
        User user = userService.getUserByEmail(email);
        // 定义一个字符串变量，用于存储提示信息
        String message = "";
        // 判断用户对象是否为空
        if (user != null){
            // 对用户输入的密码和用户对象的code进行MD5加密
            String mdsPass = DigestUtils.md5DigestAsHex((password + user.getCode()).getBytes());
            // 判断加密后的密码是否和用户对象的密码相同
            if (!mdsPass .equals(user.getPassword())){
                // 如果不同，提示用户密码错误
                message = "用户密码错误！";
            } else {
                // 如果相同，判断用户对象的状态是否为4（有效）
                if (user.getStatusId() == 4){
                    // 如果有效，把用户对象存入会话中
                    session.setAttribute("user",user);
                    session.setMaxInactiveInterval(1800);
//                    ServletContext application = session.getServletContext();
//                    String sessionId = (String) application.getAttribute(user.getName()); //获取登录用户的 sessionId
//                    if (sessionId!=null && !"".equals(sessionId)) {
//                        message = "该账号已登录，请您更换账号进行登录！";
//                        model.addAttribute("message", message);
//                        //跳转到登陆页面
//                        return "home/login";
//                    } else {
//                        application.setAttribute(user.getName(), session.getId());//设置登录用户的 sessionId
//                    }
                    // 判断上一个页面的URL是否为空
                    if ("".equals(preURL)){
                        // 如果为空，重定向到首页
                        return "redirect:/";
                    } else {
                        // 如果不为空，重定向到上一个页面的URL
                        return "redirect:" + preURL;
                    }
                } else {
                    // 如果无效，提示用户已失效
                    message = "用户已失效！";
                }
            }
        } else {
            // 如果为空，提示用户不存在
            message = "用户不存在！";
        }
        // 把提示信息添加到模型中，以便在视图中使用
        model.addAttribute("message", message);
        // 返回home/login，表示要跳转到home文件夹下的login.jsp页面
        return "home/login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(@RequestParam(required = false, defaultValue = "false" )String logout,
//                         @RequestParam(value = "email", required = false) String email,
                         HttpSession session){
//        User user = userService.getUserByEmail(email);
        session.removeAttribute("user");
//        ServletContext application = session.getServletContext();
//        application.removeAttribute(user.getName());    //系统退出，移除该用户的sessionId
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        return "home/register";
    }

    // 这个方法用于处理/register的POST请求
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    // 这是一个方法，返回一个字符串，表示要跳转到的视图名
    public String registerSuccess(ModelMap model,
                                  // 这是一个参数，表示用户对象，使用@Valid注解进行数据校验
                                  @Valid User user) {
        // 定义一个字符串变量，用于存储提示信息
        String status;
        // 定义一个布尔变量，用于判断用户注册是否成功
        Boolean insertSuccess;
        // 创建一个InfoCheck对象，用于检查用户输入的手机号和邮箱是否合法
        InfoCheck infoCheck = new InfoCheck();
        // 判断用户输入的手机号是否合法
        if (!infoCheck.isMobile(user.getMobile())){
            // 如果不合法，提示请输入正确的手机号
            status = "请输入正确的手机号！";
            // 判断用户输入的邮箱是否合法
        } else if (!infoCheck.isEmail(user.getEmail())){
            // 如果不合法，提示请输入正确的邮箱
            status = "请输入正确的邮箱！";
            // 判断用户输入的手机号是否已被使用
        } else if (userService.getUserByMobile(user.getMobile()) != null) {
            // 如果已被使用，提示此手机号码已使用
            status = "此手机号码已使用！";
            // 判断用户输入的邮箱是否已被使用
        } else if (userService.getUserByEmail(user.getEmail()) != null) {
            // 如果已被使用，提示此邮箱已使用
            status = "此邮箱已使用！";
            // 判断用户输入的地址是否为空
        }  else if (user.getAddress() == null) {
            // 如果为空，提示地址不能为空
            status = "地址不能为空！";
            // 判断用户是否确认密码
        } else if (user.getPassword2() == null){
            // 如果没有确认密码，提示请确认密码
            status = "请确认密码！";
        } else {
            // 如果以上条件都满足，进行注册操作
            // 创建一个RandomString对象，用于生成随机字符串作为用户的code
            RandomString randomString = new RandomString();
            user.setCode(randomString.getRandomString(5));
            // 对用户输入的密码和用户对象的code进行MD5加密，并设置为用户对象的密码
            String md5Pass = DigestUtils.md5DigestAsHex((user.getPassword() + user.getCode()).getBytes());
            user.setPassword(md5Pass);
            // 调用userService的registerUser方法，传入用户对象，返回注册是否成功的布尔值
            insertSuccess = userService.registerUser(user);
            // 判断注册是否成功
            if (insertSuccess){
                // 如果成功，跳转到登录页面
                return "home/login";
            } else {
                // 如果失败，提示注册失败，并把用户对象和提示信息添加到模型中，返回注册页面
                status = "注册失败！";
                model.addAttribute("user", user);
                model.addAttribute("status", status);
                return "home/register";
            }
        }
        // 打印用户输入的手机号和提示信息到控制台（调试用）
        System.out.println(user.getMobile());
        System.out.println(status);
        // 把用户对象和提示信息添加到模型中，返回注册页面
        model.addAttribute("user", user);
        model.addAttribute("status", status);
        return "home/register";
    }


    @GetMapping("/about")
    public String aboutPage(ModelMap mode, HttpServletRequest request) {
        String preURL = request.getHeader("Referer");
        mode.addAttribute("preURL", preURL);
        return "home/about";
    }
}