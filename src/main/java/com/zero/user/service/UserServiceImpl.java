package com.zero.user.service;

import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zero.user.dto.User;
import com.zero.waste.mapper.UserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper;

    private final PasswordEncoder passwordEncoder;

	@Override
    @Transactional
	public void insertUser(User user) {
		try {
	        // 사용자 역할 설정
	        user.setRole("ROLE_USER");
	   
	     // 비밀번호 암호화
	        updatePassword(user, user.getPassword());
	        
	        // 사용자 등록
	        userMapper.insertUser(user);
	    } catch (IllegalArgumentException e) {
	        // 비밀번호 암호화 실패 시 예외 처리
	        throw new RuntimeException("사용자 등록 중에 오류가 발생했습니다.", e);
	    }
	}

	@Override
	@Transactional(readOnly = true)
	public User findByUsername(String userid) {
		return userMapper.findByUsername(userid);
	}

	@Override
	@Transactional
	public void updateUser(User user) {

		User updateUser = userMapper.findByUsername(user.getUserid());

		
	    // 이메일 업데이트
		if (StringUtils.isNotEmpty(user.getEmail())) {
			updateUser.setEmail(user.getEmail());
		}
		// 휴대폰 업데이트
		if (StringUtils.isNotEmpty(user.getPhoneNum())) {
			updateUser.setPhoneNum(user.getPhoneNum());
		}
		// 생일 업데이트
		if (user.getBirthday() != null) {
			updateUser.setBirthday(user.getBirthday());
		}
		// 주소 업테이트
		if (StringUtils.isNoneEmpty(user.getZipCode(), user.getStreetAddress(), user.getDetailAddress())) {
			updateUser.setZipCode(user.getZipCode());
			updateUser.setStreetAddress(user.getStreetAddress());
			updateUser.setDetailAddress(user.getDetailAddress());
		}
		// 비밀번호 업데이트
	    if (StringUtils.isNotEmpty(user.getPassword())) {
	        updatePassword(updateUser, user.getPassword());
	    }
		
		
		try {
	        // 사용자 정보 업데이트
			System.out.println(updateUser);
	        userMapper.updateUser(updateUser);
	    } catch (Exception e) {
	        // 업데이트 중에 예외가 발생하면 로그에 기록
	        log.error("Error updating user: " + e.getMessage());
	        System.out.println(e.getMessage());
	        // 사용자에게 오류 메시지 표시
	        throw new RuntimeException("사용자 정보를 업데이트하는 중에 오류가 발생했습니다.");
	    }
	}

	// 아이디 중복체크
	@Transactional(readOnly = true)
	public boolean isUsernameUnique(String userid) {
		return userMapper.findByUsername(userid) == null;
	}
	
    // 비밀번호와 확인용 비밀번호가 일치하는지 확인하는 메서드
	public boolean passwordMatches(String password, String passwordConfirm) {
	    return password.equals(passwordConfirm);
	}
	
	// 소셜 로그인 사용자인지 확인하는 메서드
	public boolean isSocialLoginUser() {
		String userid = getCurrentUserid();
		User user = userMapper.findByUsername(userid);
		return user.getProvider() != null;
	}

	// 회원 삭제
	@Override
	@Transactional
	public void deactivateUser(String password, User user) {
		if (passwordEncoder.matches(password, user.getPassword())) {
			String ranPassword = passwordEncoder.encode(generateRandomPassword());
			user.setPassword(ranPassword);
			userMapper.delete(user);
		} else {
			throw new IllegalArgumentException("패스워드가 일치하지 않습니다.");
		}
	}

	// 내부(회원 탈퇴 - 랜덤 비밀번호 생성)
	private String generateRandomPassword() {
		int length = 12;
	    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=<>?";

	    Random random = new Random();
	    StringBuilder password = new StringBuilder(length);
	    for (int i = 0; i < length; i++) {
	        int randomIndex = random.nextInt(chars.length());
	        password.append(chars.charAt(randomIndex));
	    }
	    return password.toString();
    }
	
	// 내부(비밀번호 암호화)
	private void updatePassword(User user, String newPassword) {
	    try {
	        // 비밀번호 암호화
	        String encryptedPassword = passwordEncoder.encode(newPassword);
	        user.setPassword(encryptedPassword);
	    } catch (Exception e) {
	        // 암호화 중에 예외가 발생하면 로그에 기록
	        log.error("Error encrypting password: " + e.getMessage());
	        // 사용자에게 오류 메시지 표시
	        throw new RuntimeException("비밀번호를 업데이트하는 중에 오류가 발생했습니다.");
	    }
	}

	private String getCurrentUserid() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			return ((UserDetails)principal).getUsername();
		} else {
			return null;
		}
	}

}
