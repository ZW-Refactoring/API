package com.zero.user.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zero.activity.ActivityService;
import com.zero.activity.ActivityStateVO;
import com.zero.common.util.CommonUtil;
import com.zero.user.auth.PrincipalDetails;
import com.zero.user.dto.User;
import com.zero.user.dto.UserBookmarkVO;
import com.zero.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/user")
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	private final ActivityService aService;
	private final CommonUtil util;

	// 로그인 폼
	@GetMapping("/login")
	public String loginForm(Model model) {
//		model.addAttribute("loginErrorMsg", "아이디 또는 비밀번호를 확인해주세요");
		return "/user/loginForm";
	}

	// 로그인 에러
	@GetMapping("/login/error")
	public String loginError(Model model) {
		model.addAttribute("loginErrorMsg", "아이디 또는 비밀번호를 확인해주세요");
		return "/user/loginForm";
	}

	// 회원가입 폼
	@GetMapping("/join")
	public String joinForm(Model model) {
		model.addAttribute("user", new User());
		return "/user/joinForm";
	}

	// 회원가입
	@PostMapping("/join")
	public String join(@Validated @ModelAttribute("user") User user, BindingResult bindingResult, Model model) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("errors", bindingResult);
			return "/user/joinForm";
		}

		if (!userService.isUsernameUnique(user.getUserid())) {
			model.addAttribute("unErrors", bindingResult);
			bindingResult.rejectValue("userid", "userid.duplicate", "이미 사용 중인 아이디입니다.");
			return "/user/joinForm";
		}
		if (!user.getPassword().equals(user.getPasswordConfirm())) {
			model.addAttribute("pwErrors", bindingResult);
			bindingResult.rejectValue("passwordConfirm", "password.mismatch", "비밀번호가 일치하지 않습니다.");
			return "/user/joinForm";
		}
		// 생일 필드에 대한 유효성 검사
		Date today = new Date(); // 현재 날짜를 가져옴
		if (user.getBirthday() != null && user.getBirthday().after(today)) {
			model.addAttribute("birthErrors", bindingResult);
			bindingResult.rejectValue("birthday", "birthday.invalid", "생일은 오늘 날짜 이전이어야 합니다.");
			return "/user/joinForm";
		}
		try {
			userService.insertUser(user);
		} catch (RuntimeException e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "사용자 등록 중에 오류가 발생했습니다.");
	        return "/user/joinForm";
	    }
		return "/user/loginForm";
	}

	// 중복확인
	@GetMapping("/registerCheck")
	public @ResponseBody int registerCheck(@RequestParam("userid") String userid) {
		User user = userService.findByUsername(userid);
		if (user != null) {
			return 0; // 이미 존재하는 회원, 입력불가
		}
		return 1; // 사용가능한 아이디
	}
	
	@GetMapping("/edit/password")
    public String showPasswordConfirmationPage(RedirectAttributes redirectAttributes) {
	    if (userService.isSocialLoginUser()) {
	    	// 소셜 로그인 사용자일 경우 "error" 파라미터를 전달하여 리다이렉트
            redirectAttributes.addAttribute("error", "true");
	        return "redirect:/"; // 사용자가 리다이렉트될 홈페이지 경로
	    }
        return "user/passwordConfirmationForm";
    }

    @PostMapping("/edit/password")
    public String checkPassword(Authentication authentication, @RequestParam String password) {
        PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
        User user = userDetails.getUser();

        if (passwordEncoder.matches(password, user.getPassword())) {
            return "redirect:/user/edit";
        } else {
            return "redirect:/user/edit/password?error";
        }
    }

	// 회원수정 폼
	@GetMapping("/edit")
	public String editForm(Model model, Authentication authentication, RedirectAttributes redirectAttributes) {
		// 소셜 로그인 사용자인지 확인
	    if (userService.isSocialLoginUser()) {
	    	// 소셜 로그인 사용자일 경우 "error" 파라미터를 전달하여 리다이렉트
            redirectAttributes.addAttribute("error", "true");
	        return "redirect:/"; // 사용자가 리다이렉트될 홈페이지 경로
	    }
		String userid = authentication.getName();
		User user = userService.findByUsername(userid);
		model.addAttribute("user", user);
		return "/user/editForm";
	}

	// 회원수정
	@PostMapping("/edit")
	public String edit(@Validated @ModelAttribute("user") User user, BindingResult bindingResult, Model model,
	        HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
	    if (bindingResult.hasErrors()) {
	        model.addAttribute("errors", bindingResult);
	        return "/user/editForm";
	    }
	    
	    // 생일 필드에 대한 유효성 검사
	    Date today = new Date(); // 현재 날짜를 가져옴
	    if (user.getBirthday() != null && user.getBirthday().after(today)) {
	        model.addAttribute("birthErrors", bindingResult);
	        bindingResult.rejectValue("birthday", "birthday.invalid", "생일은 오늘 날짜 이전이어야 합니다.");
	        return "/user/editForm";
	    }
	    
	    // 주소 필드에 대한 유효성 검사
	    if (StringUtils.isNotEmpty(user.getZipCode()) || StringUtils.isNotEmpty(user.getStreetAddress()) || StringUtils.isNotEmpty(user.getDetailAddress())) {
	        if (StringUtils.isAnyEmpty(user.getZipCode(), user.getStreetAddress(), user.getDetailAddress())) {
	            // 주소 필드 중 하나 이상이 비어 있는 경우
	            model.addAttribute("addrErrors", bindingResult);
	            bindingResult.rejectValue("zipCode", "address.empty", "주소를 모두 입력해주세요.");
	            return "/user/editForm";
	        }
	    }
	    try {
	        userService.updateUser(user);
	    } catch (RuntimeException e) {
	        // RuntimeException 발생 시 사용자에게 오류 메시지를 표시하고 이전 페이지로 리다이렉트
	        model.addAttribute("errorMessage", "회원 정보를 업데이트하는 중에 오류가 발생했습니다.");
	        return "/user/editForm";
	    }

	    // 비밀번호가 비어 있지 않은 경우에만 로그아웃 후 리다이렉트
	    if (!user.getPassword().isEmpty()) {
	        // 비밀번호가 일치하지 않는 경우, 에러 메시지 표시 후 수정 폼으로 리다이렉트
	        if (!userService.passwordMatches(user.getPassword(), user.getPasswordConfirm())) {
	            model.addAttribute("pwErrors", bindingResult);
	            bindingResult.rejectValue("passwordConfirm", "password.mismatch", "비밀번호가 일치하지 않습니다.");
	            return "/user/editForm";
	        }
	        new SecurityContextLogoutHandler().logout(request, response, authentication);
	        return "redirect:/user/login";
	    }

	    // 비밀번호가 비어 있으면 수정 폼으로 리다이렉트
	    return "redirect:/user/editForm";
	}

	// 회원탈퇴 폼
	@GetMapping("/deactivate")
	public String deactivationForm(Model model, Authentication authentication, RedirectAttributes redirectAttributes) {
		// 소셜 로그인 사용자인지 확인
	    if (userService.isSocialLoginUser()) {
	    	// 소셜 로그인 사용자일 경우 "error" 파라미터를 전달하여 리다이렉트
            redirectAttributes.addAttribute("error", "true");
	        return "redirect:/"; // 사용자가 리다이렉트될 홈페이지 경로
	    }
	    
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		User user = userDetails.getUser();
		model.addAttribute("user", user);
		return "/user/deactivationForm";
	}

	// 회원탈퇴
	@PostMapping("/deactivate")
	public String deactivation(@RequestParam(value = "password", required = false) String password,
	        Authentication authentication, HttpServletRequest request, HttpServletResponse response, Model model) {
	    if (StringUtils.isEmpty(password)) {
	        return "redirect:/user/deactivate?error";
	    }
	    PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
	    User user = userDetails.getUser();

	    // 비밀번호 일치 여부 확인
	    try {
	        if (passwordEncoder.matches(password, user.getPassword())) {
	            // 비밀번호가 일치하면 회원 탈퇴 처리
	            userService.deactivateUser(password, user);
	            // 회원 탈퇴 후 로그아웃
	            new SecurityContextLogoutHandler().logout(request, response, authentication);
	            // 로그인 페이지로 리다이렉트
	            return "redirect:/user/login";
	        } else {
	            // 비밀번호가 일치하지 않으면 에러 메시지와 함께 탈퇴 페이지로 리다이렉트
	            return "redirect:/user/deactivate?error";
	        }
	    } catch (IllegalArgumentException e) {
	        // 회원 탈퇴 중에 발생한 예외 처리
	        model.addAttribute("errorMessage", "회원 탈퇴 중에 오류가 발생했습니다.");
	        return "user/deactivate";
	    }
	}

	@GetMapping("/mypage")
	public String mypage(Model m) {
		String username = util.getCurrentUsername();
		User user = userService.findByUsername(username);

		List<ActivityStateVO> userActList = aService.getUserActivity(username);
		List<String> stateList = aService.getStateAll();
		List<UserBookmarkVO> userBookmarkList = aService.getUserBookmarkList(username);
		
		m.addAttribute("userInfo", user);
		m.addAttribute("username",username);
		m.addAttribute("userActList", userActList);
		m.addAttribute("stateList", stateList);
		m.addAttribute("userBookmarkList", userBookmarkList);
		return "/user/mypage";
		
	}
	
	@PostMapping(value = "/selectstate", produces = { "application/json; charset=utf-8" })
	@ResponseBody
	public List<ActivityStateVO> selectCategory(@RequestParam("ctgr") String ctgr, Authentication authentication) {
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		
		List<ActivityStateVO> actList;

		if (ctgr.equals("all")) {
			actList = aService.getUserActivity(username);
		}

		else {
			actList = aService.getActivityState(username, ctgr);
		}
		log.info("actList={}",actList);
		return actList;
	}

	@PostMapping("/actCancle")
	public String actCancle(@RequestParam("cancleNo") String cancleNo, Authentication authentication) {
		if (authentication == null) {
			return "/user/loginForm";
		}
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		int n = aService.cancleActivity(Integer.parseInt(cancleNo), username);
		return "redirect:/user/mypage";
	}

}
