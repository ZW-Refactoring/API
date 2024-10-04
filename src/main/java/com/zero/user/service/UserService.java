package com.zero.user.service;

import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import com.zero.user.dto.User;

public interface UserService {
		
    void insertUser(User user);
    
    User findByUsername(String userid);

    void updateUser(User user);
	
	boolean isUsernameUnique(String userid);
	
	boolean passwordMatches(String password, String passwordConfirm);
	
	boolean isSocialLoginUser();
	
	void deactivateUser(String password, User user);

}
