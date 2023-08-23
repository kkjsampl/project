package com.example.demo.product.dto;


import lombok.*;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ReviewDto {
	@Data
	public static class Create {
		private String content;
		private Long star;
		private Long pno;
	}
	
	@Data
	public static class Read {
		private Long rno;
		private String content;
		private String writer;
		private String writeTime;
		private Long star;
	}
}
