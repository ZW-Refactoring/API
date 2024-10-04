package com.zero.user.auth;

import java.util.Collections;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.zero.user.dto.User;
import com.zero.user.service.UserService;
import com.zero.waste.mapper.UserMapper;

import lombok.RequiredArgsConstructor;


// 시큐리티 설정에서 loginProcessingUrl("/login");
// /login 요청이 오면 자동으로 UserDetailsService 타입으로 IOC되어 있는 loadUserByUsername 함수가 실행
@Slf4j
@Service
@RequiredArgsConstructor
public class PrincipalDetailsService implements UserDetailsService{
	private final UserService userService;
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		System.out.println(userid);
		User user = userService.findByUsername(userid);
		System.out.println(user);
		if(user == null) {
            throw new UsernameNotFoundException(userid);
		}else {
			PrincipalDetails userDetails = new PrincipalDetails(user);
			userDetails.setAuthenticated(true);
			return userDetails;
		}
		
	}

}

