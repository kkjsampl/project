package com.example.demo.product.controller;

import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.example.demo.product.entity.*;
import com.example.demo.product.service.*;

@PreAuthorize("isAuthenticated()")
@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	@PostMapping("/review/create")
	public ModelAndView create(Review review, Principal principal) {
		service.create(review, principal.getName());
		return new ModelAndView("redirect:/product/read?pno=" + review.getPno());
	}
	
	@PostMapping("/review/delete")
	public ModelAndView delete(Long rno, Long pno, Principal principal) {
		service.delete(rno, pno, principal.getName());
		return new ModelAndView("redirect:/product/read?pno=" + pno);
	}
}
