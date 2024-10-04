package com.zero.user.config;

import java.util.Map;
import java.util.UUID;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.zero.user.auth.PrincipalDetails;
import com.zero.user.dto.User;
import com.zero.user.oauth.provider.GoogleUserInfo;
import com.zero.user.oauth.provider.KakaoUserInfo;
import com.zero.user.oauth.provider.NaverUserInfo;
import com.zero.user.oauth.provider.OAuth2UserInfo;
import com.zero.user.service.UserService;

import lombok.RequiredArgsConstructor;
@Slf4j
@Service
@RequiredArgsConstructor
public class PrincipalOAuth2USerService extends DefaultOAuth2UserService {

	private final PasswordEncoder bCryptPasswordEncoder;

	private final UserService userService;
	
	// 구글로 부터 받은 userRequest 후처리되는 함수
	// 함수 종료시 @AuthenticationPrincipal 어노테이션이 만들어진다.
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		OAuth2User oauth2User = super.loadUser(userRequest);
		// 구글로그인 버튼 클릭 -> 구글로그인창 -> 로그인을 완료 -> code를 리턴(OAuth -> Client 라이브러리) -> AccessToken요청
		// userRequest 정보 -> loadUser함수 호출 -> 구글로부터 회원프로필 받아준다.
		
		//회원가입을 강제로 진행
		OAuth2UserInfo oAuth2UserInfo = null;
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		if (registrationId.equals("google")) {
			log.info("Google login request");
			oAuth2UserInfo = new GoogleUserInfo(oauth2User.getAttributes());
		} else if (registrationId.equals("naver")) {
			log.info("Naver login request");
			oAuth2UserInfo = new NaverUserInfo((Map) oauth2User.getAttributes().get("response"));
		} else if (registrationId.equals("kakao")) {
			log.info("Kakao login request");
			oAuth2UserInfo = new KakaoUserInfo(oauth2User.getAttributes());
		}
		String provider = oAuth2UserInfo.getProvider();
		String providerId = oAuth2UserInfo.getProviderId(); // facebook -> id, google -> sub
		String userid = provider+"_"+providerId;
        String uuid = UUID.randomUUID().toString().substring(0, 6);
		String password = bCryptPasswordEncoder.encode("asdf" + uuid);
		String email = oAuth2UserInfo.getEmail();
		String role = "ROLE_SOCIAL";
		User userEntity = userService.findByUsername(userid);

		if (userEntity == null) {
			System.out.println("로그인이 최초입니다.");
			userEntity = User.builder()
					.userid(userid)
					.password(password)
					.email(email)
					.role(role)
					.provider(provider)
					.providerId(providerId)
					.build();
			userService.insertUser(userEntity);
		} 
		
		return new PrincipalDetails(userEntity, oauth2User.getAttributes());
	}
}
