package com.zero.user.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User {
	@NotBlank
	@Pattern(regexp="(?=.*[0-9a-zA-Z])(?=\\S+$).{5,30}", message = "아이디는 영문자와 숫자를 포함한 5자에서 30자 사이여야 합니다.")

	private String userid;

	@NotEmpty
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z])(?=.*\\W)^\\S{8,20}$", message = "비밀번호는 영문자, 숫자, 특수기호를 각각 최소 1개 이상 포함하고, 8자에서 20자 사이여야 합니다.")
	private String password;
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z])(?=.*\\W)^\\S{8,20}$", message = "비밀번호는 영문자, 숫자, 특수기호를 각각 최소 1개 이상 포함하고, 8자에서 20자 사이여야 합니다.")
	private String passwordConfirm;
    @Pattern(regexp = "^(01[1|6|7|8|9|0])-(\\d{3,4})-(\\d{4})$", message = "01x-xxxx-xxxx의 형식으로 작성해주세요")
    private String phoneNum;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	private String zipCode;				// 우편 번호
    private String streetAddress;		// 지번 주소
    private String detailAddress;		// 상세 주소
    private int userPoint;
    private int userStatus;
	@NotBlank
	@Pattern(regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", message = "올바른 이메일 주소 형식이 아닙니다.")
	private String email;
	private String role; //ROLE_USER, ROLE_ADMIN
	
	private String provider; //google
	private String providerId; //100147452791710881214
	private Timestamp createDate;
	private Timestamp deactivateDate;
	
	public String getAddr() {
		return "["+zipCode+"] "+streetAddress+" "+detailAddress;
	}
	
	@Builder
	public User(String userid, String password, String email, String role, String provider,
			String phoneNum, Date birthday, String zipCode, String streetAddress, String detailAddress, int userPoint, int userStatus,
			String providerId, Timestamp createDate) {
		this.userid = userid;
		this.password = password;
		this.email = email;
		this.role = role;
		this.provider = provider;
		this.phoneNum = phoneNum;
		this.birthday = birthday;
		this.zipCode = zipCode;
		this.streetAddress = streetAddress;
		this.detailAddress = detailAddress;

		this.userPoint = userPoint;
		this.userStatus = userStatus;
 
		this.providerId = providerId;
		this.createDate = createDate;
	}
	
	
	
}
