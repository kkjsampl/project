package com.example.demo.product.entity;

import lombok.*;

@Data
@AllArgsConstructor
public class Product {
	private Long pno;
	private String vendor;
	private String name;
	private String info;
	private Long price;
	private Long salesCount;
	private Long salesVolume;
	private Long stock;
}
