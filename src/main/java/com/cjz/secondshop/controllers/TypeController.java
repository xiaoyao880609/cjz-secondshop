package com.cjz.secondshop.controllers;

import com.cjz.secondshop.models.FirstType;
import com.cjz.secondshop.models.SecondType;
import com.cjz.secondshop.services.GoodService;
import com.cjz.secondshop.services.TypeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("type")
public class TypeController {
	private final TypeService typeService;
	private final GoodService goodService;

	@Autowired
	public TypeController(TypeService typeService, GoodService goodService) {
		this.typeService = typeService;
		this.goodService = goodService;
	}

	@RequestMapping(value = "/secondType/{firstTypeId}", method = RequestMethod.GET)
	public ResponseEntity getSecondTypeId(@PathVariable Integer firstTypeId) {
		List<SecondType> secondTypes = typeService
				.getSecondTypeByFirstTypeId(firstTypeId);
		if (secondTypes == null) {
			return ResponseEntity.ok("isNull");
		}
		return ResponseEntity.ok(secondTypes);
	}

	@RequestMapping(value = "/secondType/delete/{secondTypeId}", method = RequestMethod.GET)
	public ResponseEntity deleteSecondType(@PathVariable Integer secondTypeId) {
		Boolean success = goodService.getGoodsAdminByType(secondTypeId)
				.isEmpty();
		System.out.println(goodService.getGoodsAdminByType(secondTypeId));
		if (success) {
			Integer thisFirstTypeId = typeService.getSecondTypeById(
					secondTypeId).getFirstTypeId();
			success = typeService.deleteSecondType(secondTypeId);
			if (success) {
				List<SecondType> secondTypeList = typeService
						.getSecondTypeByFirstTypeId(thisFirstTypeId);
				if (secondTypeList == null) {
					return ResponseEntity.ok("isNull");
				}
				return ResponseEntity.ok(secondTypeList);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/firstType/delete/{firstTypeId}", method = RequestMethod.GET)
	public ResponseEntity deleteFirstType(@PathVariable Integer firstTypeId) {
		Boolean success = typeService.getSecondTypeByFirstTypeId(firstTypeId)
				.isEmpty();
		if (success) {
			success = typeService.deleteFirstType(firstTypeId);
			if (success) {
				List<FirstType> firstTypeList = typeService.getAllFirstType();
				if (firstTypeList == null) {
					return ResponseEntity.ok("isNull");
				}
				return ResponseEntity.ok(firstTypeList);
			}
		}
		return ResponseEntity.ok(success);
	}

	// 这是表示这个方法用于处理/secondType/create的POST请求
	@RequestMapping(value = "/secondType/create", method = RequestMethod.POST)
	// 这是一个方法，返回一个ResponseEntity对象，表示响应的数据和状态码
	public ResponseEntity createSecondType(@RequestBody SecondType secondType) {
		// 从请求体中获取二级分类对象，并获取其对应的一级分类id
		int thisFirstTypeId = secondType.getFirstTypeId();
		// 调用typeService的createSecondType方法，传入二级分类对象，返回创建是否成功的布尔值
		Boolean success = typeService.createSecondType(secondType);
		// 判断创建是否成功
		if (success) {
			// 如果成功，通过一级分类id查询该一级分类下的所有二级分类列表
			List<SecondType> secondTypeList = typeService
					.getSecondTypeByFirstTypeId(thisFirstTypeId);
			// 返回一个ResponseEntity对象，包含二级分类列表和状态码200（OK）
			return ResponseEntity.ok(secondTypeList);
		}
		// 如果失败，返回一个ResponseEntity对象，包含创建是否成功的布尔值和状态码200（OK）
		return ResponseEntity.ok(success);
	}

	// 这是表示这个方法用于处理/firstType/create的POST请求
	@RequestMapping(value = "/firstType/create", method = RequestMethod.POST)
	// 这是一个方法，返回一个ResponseEntity对象，表示响应的数据和状态码
	public ResponseEntity createSecondType(@RequestBody FirstType firstType) {
		// 从请求体中获取一级分类对象
		Boolean success = typeService.createFirstType(firstType);
		// 调用typeService的createFirstType方法，传入一级分类对象，返回创建是否成功的布尔值
		if (success) {
			// 如果成功，查询所有的一级分类列表
			List<FirstType> firstTypeList = typeService.getAllFirstType();
			// 返回一个ResponseEntity对象，包含一级分类列表和状态码200（OK）
			return ResponseEntity.ok(firstTypeList);
		}
		// 如果失败，返回一个ResponseEntity对象，包含创建是否成功的布尔值和状态码200（OK）
		return ResponseEntity.ok(success);
	}

}
