package com.example.demo.product.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.example.demo.product.dto.*;
import com.example.demo.product.service.*;

//@Secured("ROLE_ADMIN")
@Controller
public class ProductAdminController {
	@Autowired
	private ProductAdminService service;
	
	@GetMapping("/product/add")
	public void add() {
	}
	
	@PostMapping("/product/add")
	public ModelAndView add(ProductDto.Create dto) {
		Long pno = service.add(dto);
		return new ModelAndView("redirect:/product/read?pno=" + pno);
	}
	
	@PostMapping("/product/delete")
	public ModelAndView delete(Long pno) {
		service.delete(pno);
		return new ModelAndView("redirect:/");
	}
}
