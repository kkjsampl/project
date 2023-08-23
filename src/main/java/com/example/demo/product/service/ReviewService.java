package com.example.demo.product.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.product.dao.*;
import com.example.demo.product.dto.*;
import com.example.demo.product.entity.*;

@Service
public class ReviewService {
	@Autowired
	private ReviewDao reviewDao;
	
	public List<ReviewDto.Read> create(Review review, String loginId) {
		review.setWriter(loginId);
		reviewDao.save(review);
		return reviewDao.findByPno(review.getPno());
	}

	public List<ReviewDto.Read> delete(Long rno, Long pno, String loginId) {
		reviewDao.deleteByIdAndWriter(rno, loginId);
		return reviewDao.findByPno(pno);
	}
}
