package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "customerControllerOfAdmin")
public class CustomerController {

	@Autowired
	ICustomerService customerService;
	@Autowired
	IUserService userService;

	@RequestMapping(value = "/admin/customer-list", method = RequestMethod.GET)
	public ModelAndView buildingList(@ModelAttribute("customerSearch") CustomerDTO customerDTO) {
		ModelAndView mav = new ModelAndView("admin/customer/list");
		mav.addObject("customerSearch", customerDTO);
		mav.addObject("customers", customerService.findCustomer(customerDTO));
		mav.addObject("staffMaps", userService.getStaffMap());
		return mav;
	}

	@RequestMapping(value = "/admin/customer-edit", method = RequestMethod.GET)
	public ModelAndView customerEdit(@ModelAttribute("modelEdit") CustomerDTO customerDTO, @RequestParam(value = "id", required = false) Long id) {
		ModelAndView mav = new ModelAndView("admin/customer/edit");
		if(id != null){
			customerDTO = customerService.findOne(id);
		}
		mav.addObject("modelEdit", customerDTO);
		return mav;
	}
}
