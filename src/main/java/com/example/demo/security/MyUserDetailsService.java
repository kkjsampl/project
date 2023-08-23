package com.example.demo.security;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;

import com.example.demo.member.dao.*;
import com.example.demo.member.entity.*;

@Component
public class MyUserDetailsService implements UserDetailsService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		if(username.equals("admin")) 
			return User.builder().username("admin").password(encoder.encode("1234")).roles("ADMIN").build(); 
		Member member = memberDao.findById(username);
		if(member==null)
			throw new UsernameNotFoundException("사용자를 찾을 수 없습니다");
		return User.builder().username(member.getUsername()).password(member.getPassword()).roles(member.getRole()).build();
	}
}
