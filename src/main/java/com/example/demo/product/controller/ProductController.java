package com.example.demo.product.controller;

import java.io.*;
import java.nio.file.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.example.demo.product.dto.*;
import com.example.demo.product.service.*;

@Controller
public class ProductController {
	@Autowired
	private ProductService service;
	@Value("${imageFolder}")
	private String imageFolder;
	
	@GetMapping({"/", "/product/list"})
	public ModelAndView list(@RequestParam(defaultValue="1")  Long pageno) {
		ProductDto.Page page = service.list(pageno);
		return new ModelAndView("index").addObject("page", page);
	}
	
	@GetMapping("/product/read")
	public ModelAndView read(Long pno) {
		ProductDto.Read dto = service.read(pno);
		return new ModelAndView("product/read").addObject("dto", dto);
	}

	@GetMapping(value="image/{imageName}", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<byte[]> viewPhoto(@PathVariable String imageName, HttpServletRequest req) {
		File file = new File(imageFolder, imageName);
		try {
			byte[] bytes = Files.readAllBytes(file.toPath());
			String contentType = Files.probeContentType(file.toPath());
			MediaType type = MediaType.parseMediaType(contentType);
			return ResponseEntity.ok().contentType(type).body(bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}