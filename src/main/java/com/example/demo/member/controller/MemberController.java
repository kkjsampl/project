package com.example.demo.member.controller;

import java.security.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.example.demo.member.dto.*;
import com.example.demo.member.service.*;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	// 접근 제어(access control) : 권한 확인 -> 실패하면 403
	@PreAuthorize("isAnonymous()")
	@GetMapping("/member/join")
	public void join() {
	}
	
	@PreAuthorize("isAnonymous()")
	@GetMapping("/member/login")
	public void login() {
	}
	
	@Secured("ROLE_USER")
	@GetMapping("/member/find")
	public void find() {
	}
	
	@Secured("ROLE_USER")
	@GetMapping("/member/check-password")
	public void checkPassword() {
	}
	
	
	@PostMapping("/member/join")
	public String join(MemberDto.Join dto) {
		service.join(dto);
		return "redirect:/member/login";
	}
	
	@Secured("ROLE_USER")
	@PostMapping("/member/check-password")
	public ModelAndView checkPassword(String password, Principal principal, HttpSession session) {
		Boolean result = service.checkPassword(password, principal.getName());
		if(result==false)
			return new ModelAndView("redirect:/member/check-password?error");
		session.setAttribute("checkPassword", true);
		return new ModelAndView("redirect:/member/read");
	}
	
	@Secured("ROLE_USER")
	@GetMapping("/member/read")
	public ModelAndView read(Principal principal, HttpSession session) {
		if(session.getAttribute("checkPassword")==null)
			return new ModelAndView("redirect:/member/check-password");
		MemberDto.Read dto = service.read(principal.getName());
		return new ModelAndView("member/read").addObject("member", dto);
	}
	
	@Secured("ROLE_USER")
	@PostMapping("/member/change-email")
	public ModelAndView changeEmail(String email, Principal principal, Authentication a) {
		System.out.println(a);
		service.changeEmail(email, principal.getName());
		return new ModelAndView("redirect:/member/read");
	}
	
	@Secured("ROLE_USER")
	@PostMapping("/member/quit")
	public ModelAndView quit(Principal principal, HttpSession session) {
		session.invalidate();
		service.quit(principal.getName());
		return new ModelAndView("redirect:/");
	}
}
