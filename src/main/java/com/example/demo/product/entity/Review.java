package com.example.demo.product.entity;

import java.time.*;

import lombok.*;

@Data
public class Review {
	private Long rno;
	private String content;
	private String writer;
	private LocalDateTime writeTime=LocalDateTime.now();
	private Long star;
	private Long pno;
}
