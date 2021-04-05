package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.util.MessageUtil;
import com.laptrinhjavaweb.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "userControllerOfAdmin")
public class UserController {
	@Autowired
	private IUserService userService;
	@Autowired
	private MessageUtil messageUtil;

	@RequestMapping(value = "/admin/user-list", method = RequestMethod.GET)
	public ModelAndView buildingList(@ModelAttribute("model") UserDTO userDTO,
									 @RequestParam(value = "message", required = false) String message) {
		ModelAndView mav = new ModelAndView("admin/user/list");
		List<String> roles = SecurityUtils.getAuthorities();
		if(message!=null){
			mav.addObject("message", messageUtil.getMessage(message));
		}
		mav.addObject("model", userDTO);
		mav.addObject("users", userService.findAll(userDTO));
		return mav;
	}

	@RequestMapping(value = "/admin/user-edit", method = RequestMethod.GET)
	public ModelAndView buildingEdit(@ModelAttribute("modelEdit") UserDTO userDTO,
									 @RequestParam(value = "id", required = false) Long id,
									 @RequestParam(value = "message", required = false) String message) {
		ModelAndView mav= new ModelAndView("admin/building/edit");
		if(id != null){
			userDTO = userService.findOne(id);
		}
		if(message!=null){
			mav.addObject("message", messageUtil.getMessage(message));
		}
		mav.addObject("modelEdit", userDTO);
		return mav;
	}
}
