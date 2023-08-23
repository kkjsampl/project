package com.example.demo.member.service;

import java.io.*;
import java.time.*;
import java.time.format.*;
import java.time.temporal.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.member.dao.*;
import com.example.demo.member.dto.*;
import com.example.demo.member.dto.MemberDto.*;
import com.example.demo.member.entity.*;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PasswordEncoder encoder;
	@Value("${profileFolder}")
	private String profileFolder;
	@Value("${profileUrl}")
	private String profileUrl;
	@Value("${defaultProfileName}")
	private String defaultProfileName;
	
	// @Transactional은 테스트에서 사용하면 rollback한다
	// transaction : 사람이 생각하는 하나의 작업(여러개의 sql일 수 있다)
	// 				 지정하면 db작업들은 모두 성공하거나 아니면 모두 실패한다
	// readOnlye=true : select만 사용한다
	@Transactional(readOnly=true)
	public Boolean usernameAvailable(String username) {
		return memberDao.findById(username)==null;	
	}
	
	
	public Boolean join(MemberDto.Join dto) {
		MultipartFile profile = dto.getProfile();
		String profileName = defaultProfileName;
				
		if(profile.isEmpty()==false) {
			String extension = FilenameUtils.getExtension(profile.getOriginalFilename());
			profileName = dto.getUsername() + "." + extension;
			// 폴더에 파일명을 주고 파일 객체를 생성 -> 0바이트 파일 생성
			File file = new File(profileFolder, profileName);
			// profile의 내용을 file로 이동시키자
			try {
				profile.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		String encodedPassword = encoder.encode(dto.getPassword());
		Member member = dto.toEntity(profileName, encodedPassword);
		return memberDao.save(member)==1;
	}


	@Transactional(readOnly=true)
	public String findUsername(String email) {
		//!!! null 주의
		Member member = memberDao.findByEmail(email);
		return member==null? null : member.getUsername();
	}

	public Read read(String loginId) {
		Member m = memberDao.findById(loginId);
		
		// LocalDate, LocalDateTime을 형식을 가진 문자열로 변환 
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
		String birthday = dtf.format(m.getBirthday());
		String joinday = dtf.format(m.getJoinday());
		
		// 가입기간을 계산
		Long days = ChronoUnit.DAYS.between(m.getJoinday(), LocalDate.now());
		
		// 프로필
		String profile = profileUrl + m.getProfile();
		return new MemberDto.Read(m.getUsername(), m.getEmail(), birthday, joinday, days, profile);
	}


	public Boolean changeEmail(String email, String loginId) {
		return memberDao.changeEmail(email, loginId)==1;
	}
	
	public Boolean quit(String loginId) {
		return memberDao.deleteById(loginId)==1;
	}

	@Transactional(readOnly=true)
	public Boolean checkPassword(String password, String loginId) {
		Member member = memberDao.findById(loginId);
		if(member==null)
			return false;
		return encoder.matches(password, member.getPassword());
	}
}

