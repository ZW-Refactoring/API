package com.zero.user.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.zero.user.dto.User;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

// 시큐리티가 /login 주소 요청이 오면 낚아채서 로그인을 진행시킨다.
// 로그인을 진행이 완료가 되면 시큐리티 session을 만들어줍니다. (Security ContextHolder)
// 오브젝트 타입 => Authentication 타입 객체
// Authentication 안에 User정보가 있어야 됨.
// User오브젝트타입 => UserDetails 타입 객체

// Security Session => Authentication => UserDetails(PrincipalDetails)
@Slf4j
@Data
public class PrincipalDetails implements UserDetails, OAuth2User {
	private User user;
	private String password;
	private String phoneNum;
	private String email;
    private Collection<? extends GrantedAuthority> authorities;
    private boolean authenticated;

	private Map<String, Object> attributes;

	public boolean isAuthenticated() {
        return this.authenticated;
    }

	// 일반 로그인
	public PrincipalDetails(User user) {
		this.user = user;
		this.password = user.getPassword();
		this.phoneNum = user. getPhoneNum();
		this.email = user.getEmail();
		this.authorities = Collections.singleton(new SimpleGrantedAuthority(user.getRole().toString()));
		this.authenticated = true;
	}
	
	
	// OAuth 로그인
	public PrincipalDetails(User user, Map<String, Object> attributes) {
		this.user = user;
		this.attributes = attributes;
		this.authorities = Collections.singleton(new SimpleGrantedAuthority(user.getRole().toString()));
	    this.authenticated = true;
	}

	// 해당 User의 권한을 리턴하는 곳!!
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<>();
		collect.add(new GrantedAuthority() {
			@Override
			public String getAuthority() {
				return user.getRole();
			}
		});
		return collect;
	}

	@Override
	public String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getUserid();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public String getName() {
		return null;
	}
	
}
