package com.memo.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@RequestMapping("/sign_up_view")
	public String singUpView(Model model) {
		model.addAttribute("viewName", "user/sign_up");
		return "/template/layout";
	}
}