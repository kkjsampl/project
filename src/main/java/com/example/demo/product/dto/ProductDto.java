package com.example.demo.product.dto;

import java.util.*;

import org.springframework.web.multipart.*;

import com.example.demo.product.entity.*;

import lombok.*;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ProductDto {
	@Data
	public static class Create {
		private String vendor;
		private String name;
		private String info;
		private Long price;
		private Long stock;
		private List<MultipartFile> images;
	}
	
	@Data
	public static class ForList {
		private Long pno;
		private String vendor;
		private String name;
		private Long price;
		private Long salesCount;
	}
	
	@Data
	@AllArgsConstructor
	public static class Page {
		private List<ForList> products;
		private Long prev;
		private Long start;
		private Long end;
		private Long next;
		private Long pageno;
	}
	
	@Data
	@AllArgsConstructor
	public static class Read {
		private Product product;
		private List<Image> images;
		private List<ReviewDto.Read> reviews;
	}
}
