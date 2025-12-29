package com.cjz.secondshop.controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cjz.secondshop.models.FirstType;
import com.cjz.secondshop.models.Good;
import com.cjz.secondshop.models.Image;
import com.cjz.secondshop.models.Reply;
import com.cjz.secondshop.models.Review;
import com.cjz.secondshop.models.User;
import com.cjz.secondshop.services.CollectService;
import com.cjz.secondshop.services.GoodService;
import com.cjz.secondshop.services.ImageService;
import com.cjz.secondshop.services.ReviewService;
import com.cjz.secondshop.services.TypeService;
import com.cjz.secondshop.services.UserService;
import com.cjz.secondshop.utils.FileCheck;
import com.cjz.secondshop.utils.RandomString;

@Controller
public class GoodController {
	private final CollectService collectService;
	private final GoodService goodService;
	private final TypeService typeService;
	private final ReviewService reviewService;
	private final UserService userService;
	private final ImageService imageService;
	private static String message = "";
	@Autowired
    private ServletContext servletContext;

	@Autowired
	public GoodController(CollectService collectService, GoodService goodService, TypeService typeService, ReviewService reviewService, UserService userService, ImageService imageService) {
		this.collectService = collectService;
		this.goodService = goodService;
		this.typeService = typeService;
		this.reviewService = reviewService;
		this.userService = userService;
		this.imageService = imageService;
	}

	//使用@GetMapping注解来映射一个网页的请求，指定请求的路径和方法
	@GetMapping("/")
	//定义一个方法来处理请求，返回一个视图名称和一些模型数据
	public String getHomeGoods(Model model1, ModelMap model, @RequestParam(required = false, defaultValue = "") String searchText,
							   @RequestParam(required = false) Integer secondTypeId,
							   @RequestParam(required = false, defaultValue = "0") int offset,
							   @RequestParam(required = false, defaultValue = "8") int limit) {
		//调用goodService的方法，根据搜索文本和二级分类的id，以及分页的参数，获取一些商品的列表
		List<Good> goods = goodService.getGoodsBySearchAndType(searchText, secondTypeId, offset, limit);
		//调用goodService的方法，根据搜索文本和二级分类的id，获取商品的总数
		double goodsNum = goodService.getGoodsBySearchAndTypeCount(searchText, secondTypeId);
		//调用typeService的方法，获取所有的一级分类的列表
		List<FirstType> firstTypes = typeService.getAllFirstType();
		//遍历一级分类的列表，为每个一级分类设置对应的二级分类的列表
		for (FirstType firstType : firstTypes) {
			firstType.setSecondTypes(typeService.getSecondTypeByFirstTypeId(firstType.getId()));
		}
		//把一级分类的列表添加到模型中，用于在视图中显示
		model.addAttribute("firstTypes", firstTypes);
		//把商品的列表添加到模型中，用于在视图中显示
		model.addAttribute("goods", goods);
		//计算商品的总页数，并添加到模型中，用于在视图中显示
		model.addAttribute("pages", Math.ceil(goodsNum / limit));
		//把商品的总数添加到模型中，用于在视图中显示
		model.addAttribute("goodsNum", goodsNum);
		//把分页的参数添加到模型中，用于在视图中显示
		model.addAttribute("offset", offset);
		model.addAttribute("limit", limit);
		//返回一个视图名称，表示要渲染的网页模板
		return "home/homeGoods";
	}

	// 方法用于处理/goods/goodInfo的GET请求
	@GetMapping("/goods/goodInfo")
	// 这是一个方法，返回一个字符串，表示要跳转到的视图名
	public String getGoodInfo(ModelMap model,HttpSession session,
							  // 这是一个参数，表示商品的id，如果没有则为null
							  @RequestParam(required = false) Integer goodId) {
		// 通过商品id查询商品对象
		Good goodInfo = goodService.getGoodById(goodId);
		// 判断商品对象是否为空
		if (goodInfo == null) {
			// 如果为空，跳转到错误页面
			return "goods/error";
		}
		// 是否收藏
		int collect = 0;
		User user = (User) session.getAttribute("user");
		if (user != null && goodInfo.getUserId() != user.getId()) {
			collect = collectService.getCollect(goodId, user.getId()) ? 2 : 1;
		}
		// 通过商品id查询商品的图片列表
		List<Image> images = imageService.getImageByGoodId(goodId);
		// 通过商品对象的用户id查询商品的卖家对象
		User goodUser = userService.getUserById(goodInfo.getUserId());
		// 给商品对象设置卖家对象属性
		goodInfo.setGoodUser(userService.getUserById(goodInfo.getUserId()));
		// 给商品对象设置二级分类对象属性
		goodInfo.setGoodSecondType(typeService.getSecondTypeById(goodInfo
				.getSecondTypeId()));
		// 调用goodService的getRECGoods方法，传入商品的二级分类id和商品id，获取推荐的其他商品列表
		List<Good> goods = goodService.getRECGoods(goodInfo.getSecondTypeId(),
				goodInfo.getId());
		model.addAttribute("collect", collect);
		// 把提示信息添加到模型中，以便在视图中使用（提示信息是一个全局变量）
		model.addAttribute("message", message);
		// 把商品对象添加到模型中，以便在视图中使用
		model.addAttribute("goodInfo", goodInfo);
		// 把图片列表添加到模型中，以便在视图中使用
		model.addAttribute("images", images);
		// 把卖家对象添加到模型中，以便在视图中使用
		model.addAttribute("goodUser", goodUser);
		// 把推荐的其他商品列表添加到模型中，以便在视图中使用
		model.addAttribute("goods", goods);
		// 清空提示信息（提示信息是一个全局变量）
		message = "";
		// 返回goods/goodInfo，表示要跳转到goods文件夹下的goodInfo.jsp页面
		List<Review> reviews = reviewService.gerReviewByGoodId(goodId);
		if (reviews.size() > 0) {
			for (Review review : reviews) {
				List<Reply> replys = reviewService.gerReplyByReviewId(review.getId());
				review.setReplys(replys);
			}
		}
		model.addAttribute("reviews", reviews);
		return "goods/goodInfo";
	}

	//定义一个处理GET请求的方法，映射到/goods/pay路径
	@RequestMapping(value = "/goods/pay", method = RequestMethod.GET)
	public String getGoodPay(ModelMap model,HttpSession session,
							 @RequestParam(required = false) Integer goodId) {
		//如果请求中没有提供goodId参数，返回错误页面
		if (goodId == null) {
			return "goods/error";
		}
		//根据goodId查询商品信息
		Good goodInfo = goodService.getGoodById(goodId);
		//如果商品信息不存在，返回错误页面
		if (goodInfo == null) {
			return "goods/error";
		}
		//根据goodId查询商品图片列表
		List<Image> images = imageService.getImageByGoodId(goodId);
		//根据商品信息中的userId查询用户信息
		User goodUser = userService.getUserById(goodInfo.getUserId());
		//将用户信息设置到商品信息中
		goodInfo.setGoodUser(userService.getUserById(goodInfo.getUserId()));
		//将消息、商品信息、图片列表、用户信息添加到模型中
		model.addAttribute("message", message);
		model.addAttribute("goodInfo", goodInfo);
		model.addAttribute("images", images);
		model.addAttribute("goodUser", goodUser);
		//清空消息
		message = "";
		//返回支付页面
		return "goods/pay";
	}


	@RequestMapping(value = "/goods/goodInfo", method = RequestMethod.POST)
	public String putReview(
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "reviewId", required = false) Integer reviewId,
			@RequestParam(value = "fromUserId", required = false) Integer fromUserId,
			@RequestParam(value = "toUserId", required = false) Integer toUserId,
			@RequestParam(value = "fromUser", required = false) String fromUser,
			@RequestParam(value = "toUser", required = false) String toUser,
			@RequestParam(value = "replyText", required = false, defaultValue = "") String replyText,
			@RequestParam(value = "reviewText", required = false, defaultValue = "") String reviewText) {
		if ("".equals(reviewText)) {
			if ("".equals(replyText)) {
				message = "内容不能为空！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			} else {
				Reply reply = new Reply();
				reply.setReviewId(reviewId);
				reply.setFromUser(fromUser);
				reply.setFromUserId(fromUserId);
				reply.setToUser(toUser);
				reply.setToUserId(toUserId);
				reply.setText(replyText);
				if (reviewService.insertReply(reply) == 1) {
					message = "回复成功！";
					return "redirect:/goods/goodInfo?goodId=" + goodId;
				} else {
					message = "回复失败！";
					return "redirect:/goods/goodInfo?goodId=" + goodId;
				}
			}
		} else {
			Review review = new Review();
			review.setGoodId(goodId);
			review.setFromUser(fromUser);
			review.setFromUserId(fromUserId);
			review.setToUserId(toUserId);
			review.setText(reviewText);
			if (reviewService.insertReview(review) == 1) {
				message = "评论成功！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			} else {
				message = "评论失败！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			}
		}
	}

	@RequestMapping(value = "/goods/publishGood", method = RequestMethod.GET)
	public String getPublishGood(ModelMap model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		Good good = new Good();
		List<FirstType> firstTypes = typeService.getAllFirstType();
		List<Good> goods = goodService.getAllGoods(0, 5);
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/publishGood";
	}

	@RequestMapping(value = "/goods/publishGood", method = RequestMethod.POST)
	public String getGoodId(ModelMap model, HttpSession session,
			@Valid Good good) {
		List<FirstType> firstTypes = typeService.getAllFirstType();
		User user = (User) session.getAttribute("user");
		List<Good> goods = goodService.getAllGoods(0, 5);
		good.setUserId(user.getId());
		good.setPhotoUrl("/images/goods/default/nophoto.png");
		if (goodService.insertGood(good) != 1) {
			System.out.println("插入商品失败！");
		}
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/publishGood";
	}

	@PostMapping("/goods/publishGood/uploadImage")
	public String uploadImage(
			HttpSession session,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "mainFile", required = false) MultipartFile mainFile,
			@RequestParam(value = "file", required = false) MultipartFile[] file)
			throws IOException {
		User user = (User) session.getAttribute("user");
		FileCheck fileCheck = new FileCheck();
		RandomString randomString = new RandomString();
		//从配置文件中读取要保存的位置
		String filePath = servletContext.getInitParameter("UPLOAD_IMAGE_PATH") + user.getId() + "/" + goodId;
		String pathRoot = fileCheck.checkGoodFolderExist(filePath);
		String name;
		if (!mainFile.isEmpty()) {
			String fileName = goodId + randomString.getRandomString(10);
			String contentType = mainFile.getContentType();
			String imageName = contentType
					.substring(contentType.indexOf("/") + 1);
			name = fileName + "." + imageName;
			mainFile.transferTo(new File(pathRoot + name));
			String photoUrl = "/images/goods/" + user.getId() + "/" + goodId + "/" + name;
			goodService.updateGoodPhotoUrl(photoUrl, goodId);
		}
		for (MultipartFile mf : file) {
			if (!mf.isEmpty()) {
				// 生成uuid作为文件名称
				String fileName = goodId + randomString.getRandomString(10);
				// 获得文件类型（可以判断如果不是图片，禁止上传）
				String contentType = mf.getContentType();
				// 获得文件后缀名称
				String imageName = contentType.substring(contentType
						.indexOf("/") + 1);
				name = fileName + "." + imageName;
				System.out.println("name:" + name);
				mf.transferTo(new File(pathRoot + name));
				Image image = new Image();
				image.setGoodId(goodId);
				image.setName(name);
				image.setUrl("/images/goods/" + user.getId() + "/" + goodId + "/" + name);
				imageService.insertImage(image);
			} else {
				System.out.println("文件为空！");
			}
		}
		return "redirect:/goods/goodInfo?goodId=" + goodId;
	}

	@GetMapping("/goods/userGoods")
	public String getUserGoods(ModelMap model,
			@RequestParam(value = "userId", required = false) Integer userId) {
		User user = userService.getUserById(userId);
		List<Good> userGoods = goodService.getGoodStatusByUserId(userId);
		List<Good> goods = goodService.getAllGoods(0, 4);
		model.addAttribute("user", user);
		model.addAttribute("userGoods", userGoods);
		model.addAttribute("goods", goods);
		return "goods/userGood";
	}

	@RequestMapping(value = "/goods/userGoodEdit", method = RequestMethod.GET)
	public String getUserGoodEdit(ModelMap model,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		Good good = goodService.getGoodById(goodId);
		List<FirstType> firstTypes = typeService.getAllFirstType();
		List<Good> goods = goodService.getAllGoods(0, 5);
		List<Image> goodImages = imageService.getImageByGoodId(goodId);
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("goodImages", goodImages);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/userGoodEdit";
	}

	// 这是表示这个方法用于处理/goods/userGoodEdit的POST请求
	@RequestMapping(value = "/goods/userGoodEdit", method = RequestMethod.POST)
	// 这是一个方法，返回一个字符串，表示要跳转到的视图名
	public String postGoodEdit(ModelMap model, HttpSession session,
							   // 这是一个参数，表示商品对象，使用@Valid注解进行数据校验
							   @Valid Good good) {
		// 查询所有的一级分类列表
		List<FirstType> firstTypes = typeService.getAllFirstType();
		// 从会话中获取用户对象
		User user = (User) session.getAttribute("user");
		// 判断用户对象是否为空
		if (user == null) {
			// 如果为空，重定向到首页
			return "redirect:/";
		}
		// 查询所有的商品列表，分页显示，每页5个
		List<Good> goods = goodService.getAllGoods(0, 5);
		// 调用goodService的updateGood方法，传入商品对象，返回修改是否成功的整型值
		if (!(goodService.updateGood(good) > 0)) {
			// 如果修改失败，打印修改商品失败到控制台（调试用）
			System.out.println("修改商品失败！");
		}
		// 通过商品id查询商品的图片列表
		List<Image> goodImages = imageService.getImageByGoodId(good.getId());
		// 把商品列表添加到模型中，以便在视图中使用
		model.addAttribute("goods", goods);
		// 把商品对象添加到模型中，以便在视图中使用
		model.addAttribute("good", good);
		// 把图片列表添加到模型中，以便在视图中使用
		model.addAttribute("goodImages", goodImages);
		// 把一级分类列表添加到模型中，以便在视图中使用
		model.addAttribute("firstTypes", firstTypes);
		// 返回goods/userGoodEdit，表示要跳转到goods文件夹下的userGoodEdit.jsp页面
		return "goods/userGoodEdit";
	}


	@RequestMapping(value = "/goods/userGoodEdit/updateImage", method = RequestMethod.POST)
	public String updateImage(
			HttpSession session,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "mainFile", required = false) MultipartFile mainFile,
			@RequestParam(value = "file", required = false) MultipartFile[] file)
			throws IOException {
		User user = (User) session.getAttribute("user");
		FileCheck fileCheck = new FileCheck();
		imageService.deleteImage(goodId);
		RandomString randomString = new RandomString();
		//从配置文件中读取要保存的位置
		String filePath = servletContext.getInitParameter("UPLOAD_IMAGE_PATH") + user.getId() + "/" + goodId;
		String pathRoot = fileCheck.checkGoodFolderExist(filePath);
		String name;
		if (!mainFile.isEmpty()) {
			String contentType = mainFile.getContentType();
			String fileName = goodId + randomString.getRandomString(10);
			String imageName = contentType
					.substring(contentType.indexOf("/") + 1);
			name = fileName + "." + imageName;
			mainFile.transferTo(new File(pathRoot + name));
			String photoUrl = "/images/goods/" + user.getId() + "/" + goodId + "/" + name;
			goodService.updateGoodPhotoUrl(photoUrl, goodId);
		}

		for (MultipartFile mf : file) {
			if (!mf.isEmpty()) {
				String contentType = mf.getContentType();
				String fileName = goodId + randomString.getRandomString(10);
				String imageName = contentType.substring(contentType
						.indexOf("/") + 1);
				name = fileName + "." + imageName;
				System.out.println("name:" + name);
				mf.transferTo(new File(pathRoot + name));
				Image image = new Image();
				image.setGoodId(goodId);
				image.setName(name);
				image.setUrl("/images/goods/" + user.getId() + "/" + goodId + "/" + name);
				imageService.insertImage(image);
			}
		}
		return "redirect:/goods/goodInfo?goodId=" + goodId;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/goods/userGoodEdit/delete/{goodId}", method = RequestMethod.GET)
	public ResponseEntity deleteGood(@PathVariable Integer goodId) {
		Boolean success;
		Good goods = goodService.getGoodById(goodId);
		if (goods.getStatusId() != 0){
			success = goodService.deleteGood(goodId) > 0;
		}else {
			goodService.updateGoodStatusId(1,goodId);
			success = goodService.deleteGood(goodId) > 0;
		}
		return ResponseEntity.ok(success);
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/goods/userGoodEdit/updateGoodStatus/{goodId}", method = RequestMethod.GET)
	public ResponseEntity updateGoodStatus(@PathVariable Integer goodId) {
		Boolean success;
		success = goodService.updateGoodStatusId(0, goodId) > 0;
		return ResponseEntity.ok(success);
	}

	// 这是表示这个方法用于处理/admin/goods/allGoods的GET请求
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/admin/goods/allGoods", method = RequestMethod.GET)
	// 这是一个方法，返回一个ResponseEntity对象，表示响应的数据和状态码
	public ResponseEntity adminGetAllGoods() {
		// 调用goodService的getAllGoodList方法，获取所有的商品列表
		List<Good> goodList = goodService.getAllGoodList();
		for (Good good : goodList) {
			// 给每个商品对象设置卖家对象属性
			good.setGoodUser(userService.getUserById(good.getUserId()));
			// 给每个商品对象设置二级分类对象属性
			good.setGoodSecondType(typeService.getSecondTypeById(good
					.getSecondTypeId()));
		}
		// 返回一个ResponseEntity对象，包含商品列表和状态码200（OK）
		return ResponseEntity.ok(goodList);
	}

}
