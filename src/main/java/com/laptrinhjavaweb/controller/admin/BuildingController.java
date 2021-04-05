package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.dto.BaseDTO;
import com.laptrinhjavaweb.dto.BuildingDTO;
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

import java.util.Collection;
import java.util.List;
import java.util.Map;

@Controller(value = "buildingControllerOfAdmin")
public class BuildingController {
	@Autowired
	private IBuildingService buildingService;
	@Autowired
	private IUserService userService;
	@Autowired
	private MessageUtil messageUtil;

	@RequestMapping(value = "/admin/building-list", method = RequestMethod.GET)
	public ModelAndView buildingList(@ModelAttribute("model") BuildingDTO buildingDTO,
									 @RequestParam(value = "page", required = false) Integer page,
									 @RequestParam(value = "limit", required = false) Integer limit,
									 @RequestParam(value = "message", required = false) String message) {
		ModelAndView mav = new ModelAndView("admin/building/list");
		buildingDTO.setPage(page);
		buildingDTO.setLimit(limit);
		buildingDTO.setTotalItem(buildingService.getTotalItems(buildingDTO));
		buildingDTO.setTotalPage((buildingDTO.getTotalItem() / buildingDTO.getLimit()) + 1);
		List<String> roles = SecurityUtils.getAuthorities();
		if(message!=null){
			if (roles.contains("ROLE_STAFF") && message.equalsIgnoreCase("delete_success")){
				message = "incompetent";
			}
			mav.addObject("message", messageUtil.getMessage(message));
		}
		mav.addObject("model", buildingDTO);
		mav.addObject("buildings", buildingService.findAll(buildingDTO));
		mav.addObject("staffMaps", userService.getStaffMap());
		mav.addObject("district", buildingService.getDistrictMap());
		mav.addObject("types", buildingService.getTypeMap());
		return mav;
	}

	@RequestMapping(value = "/admin/building-edit", method = RequestMethod.GET)
	public ModelAndView buildingEdit(@ModelAttribute("modelEdit") BuildingDTO buildingDTO,
									 @RequestParam(value = "id", required = false) Long id,
									 @RequestParam(value = "message", required = false) String message) {
		ModelAndView mav;
		List<String> roles = SecurityUtils.getAuthorities();
		if ( roles.contains("ROLE_STAFF") && !buildingService.checkStaff(id,SecurityUtils.getPrincipal().getId().longValue())){
			mav =new ModelAndView("redirect:/login?accessDenied");
		} else{
			mav = new ModelAndView("admin/building/edit");
			if(id != null){
				buildingDTO = buildingService.findOne(id);
			}
			if(message!=null){
				mav.addObject("message", messageUtil.getMessage(message));
			}
			mav.addObject("modelEdit", buildingDTO);
			mav.addObject("district", buildingService.getDistrictMap());
			mav.addObject("types", buildingService.getTypeMap());
		}
		return mav;
	}
	@RequestMapping(value = "/admin/building-upload", method = RequestMethod.GET)
	public ModelAndView buildingUpload() {
		ModelAndView mav;
		List<String> roles = SecurityUtils.getAuthorities();
		if ( roles.contains("ROLE_STAFF")){
			mav =new ModelAndView("redirect:/admin/building-list?page=1&limit=6&message=incompetent");
		} else{
			mav = new ModelAndView("admin/building/upload");
		}
		return mav;
	}
	@RequestMapping(value = "/admin/building-detail", method = RequestMethod.GET)
	public ModelAndView buildingDetail(@RequestParam(value = "id", required = false) Long id) {
		ModelAndView mav;
		List<String> roles = SecurityUtils.getAuthorities();
		if ( roles.contains("ROLE_STAFF") && !buildingService.checkStaff(id,SecurityUtils.getPrincipal().getId().longValue())){
			mav =new ModelAndView("redirect:/login?accessDenied");
		} else{
			mav = new ModelAndView("admin/building/detail");
			if(id != null){
				mav.addObject("model", buildingService.findOne(id));
			}
			mav.addObject("types", buildingService.getTypeMap());
		}

		return mav;
	}
}
