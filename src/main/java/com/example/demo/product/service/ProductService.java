package com.example.demo.product.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.example.demo.product.dao.*;
import com.example.demo.product.dto.*;
import com.example.demo.product.dto.ProductDto.*;
import com.example.demo.product.entity.*;

@Service
public class ProductService {
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ImageDao imageDao;
	@Value("10")
	private Long numberOfProductsPerPage;
	@Value("5")
	private Long numberOfPagePerPagination;
	
	@Transactional(readOnly=true)
	public Page list(Long pageno) {
		Long startRownum = (pageno-1) * numberOfProductsPerPage + 1;
		Long endRownum = startRownum + numberOfProductsPerPage - 1;
		Long countOfProducts = productDao.count();
		
		// 1~5 : 0,  6~10:5
		Long prev = (pageno-1)/numberOfPagePerPagination;
		Long start = prev + 1;
		Long end = prev + numberOfPagePerPagination;
		Long next = end + 1;
		if(end>countOfProducts) {
			end = countOfProducts;
			next = 0L;
		}
		
		List<ProductDto.ForList> products = productDao.findAll(startRownum, endRownum);
		return new ProductDto.Page(products, prev, start, end, next, pageno);
	}

	@Transactional(readOnly=true)
	public Read read(Long pno) {
		Product product = productDao.findById(pno);
		List<ReviewDto.Read> reviews = reviewDao.findByPno(pno);
		List<Image> images = imageDao.findByPno(pno);
		return new ProductDto.Read(product, images, reviews);
	}
}
