package com.example.demo.member.dto;

import java.time.*;

import org.springframework.format.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.member.entity.*;

import lombok.*;

@NoArgsConstructor(access=AccessLevel.PRIVATE)
public class MemberDto {
	@Data
	public static class Join {
		private String username;
		private String password;
		private String email;
		
		// date형식은 2023-11-20 형식의 문자열
		// 이 문자열을 스프링이 LocalDate 변환해야 한다
		// 넘기는 형식과 스프링에서 받는 형식을 정확하게 통일해주자 -> 400
		@DateTimeFormat(pattern="yyyy-MM-dd")
		private LocalDate birthday;
		private MultipartFile profile;
		
		public Member toEntity(String pname, String pwd) {
			return new Member(username,pwd,email,birthday,LocalDate.now(),pname,"USER");
		}
	}
	
	@Data
	@AllArgsConstructor
	public static class Read {
		private String username;
		private String email;
		private String birthday;
		private String joinday;
		private Long days;
		private String profile;	
	}
}




