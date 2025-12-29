package com.cjz.secondshop.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author cuijingzhi
 */
@Controller
public class ExceptionController {
	@RequestMapping(value = "/error")
	public void toError() {
		int b = 10 / 0;
		System.out.println(b);
	}
}
