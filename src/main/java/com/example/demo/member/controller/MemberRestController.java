package com.example.demo.member.controller;

import java.io.*;
import java.nio.file.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.example.demo.member.service.*;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService service;
	
	@GetMapping("/member/username/available/{username}")
	public ResponseEntity<Void> usernameAvailable(@PathVariable String username) {
		Boolean result = service.usernameAvailable(username);
		return result? ResponseEntity.ok(null): ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
	
	@GetMapping("/member/username/{email}")
	public ResponseEntity<String> findUsername(@PathVariable String email) {
		String username = service.findUsername(email);
		if(username==null)
			return ResponseEntity.status(HttpStatus.CONFLICT).body("아이디를 찾을 수 없습니다");
		return ResponseEntity.ok(username);
	}
	
	
	// 서버에서 데이터를 쏴 줄때 파일인 경우 byte[]로 처리한다
	// 서버가 바이트 덩어리를 쏴주면 브라우저 입장에서는
	//		자기가 아는 파일 종류면 처리한다
	//			이미지인 경우 스스로 처리
	//			예를 들어 엑셀 파일이라면 엑셀이 설치된 경우 엑셀을 실행해서 파일을 연다
	//		자기가 모르는 파일 종류면 다운로드한다
	//			엑셀 파일인데 엑셀이 없는 경우 다운로드한다
	@GetMapping("/profiles/{imageName}")
	public ResponseEntity<byte[]> viewProfile(@PathVariable String imageName) {
	  File file = new File("c:/upload/profile", imageName);
	  try {
		// 1. 파일을 byte[]로 변환
		byte[] bytes = Files.readAllBytes(file.toPath());
		
		// 2. 파일의 종류를 MIME 타입이라고 한다
		// MIME은 원래 첨부파일을 추가한 이메일을 위해 만들어졌다
		// 즉 이메일에 첨부된 파일의 종류를 구별하기 위한 표준
		//	  application/excel, text/html, image/jpg.....
		// mime 타입을 웹에서는 contentType이라고 한다
		String contentType = Files.probeContentType(file.toPath()); 
		
		// 3. byte[]과 종류로 ResponseEntity를 만들어 보내준다
		// 문자열 contentType을 enum으로 변환
		MediaType type = MediaType.parseMediaType(contentType);
		return ResponseEntity.ok().contentType(type).body(bytes);
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
	  return null;
	}
}