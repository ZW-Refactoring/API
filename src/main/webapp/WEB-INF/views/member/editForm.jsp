<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정 페이지</title>
    <link rel="stylesheet" href="/resources/css/joinForm.css">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript" src="/resources/js/joinForm.js"></script>
    <!-- Bootstrap CSS 로드 -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery 로드 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- Bootstrap JavaScript 로드 -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
	    // 비밀번호 일치 여부 검사
	    $('#passwordConfirm').on('keyup', function() {
	        var password = $('#password').val();
	        var confirmPassword = $(this).val();

	        if (password !== confirmPassword) {
	            $('#passwordMatchError').text('비밀번호가 일치하지 않습니다.');
	        } else {
	            $('#passwordMatchError').text('');
	        }
	    });
	});
	</script>
    
</head>
<body>
	<div class="joinWrap">
	    <h2>회원수정</h2>
	    <form action="/edit" role="form" method="post">
	        <div class="form-group">
			    <label for="username">아이디</label>
			    <input type="text" id="username" name="username" class="form-control" value="${user != null ? user.username : ''}" readonly="readonly">
			</div>
	        <div class="form-group">
	            <label for="email">이메일 주소</label>
	            <input type="email" id="email" name="email" class="form-control" value="${user != null ? user.email : ''}">
	            <c:if test="${errors.hasFieldErrors('email')}">
			        <p class="fieldError">${errors.getFieldError('email').defaultMessage}</p>
			    </c:if>
	        </div>
	        <div class="form-group">
			    <label for="password">비밀번호</label>
			    <input type="password" id="password" name="password" class="form-control" value="${user != null ? user.password : ''}">
			    <c:if test="${errors.hasFieldErrors('password')}">
			        <p class="fieldError">${errors.getFieldError('password').defaultMessage}</p>
			    </c:if>
			</div>
			<div class="form-group">
			    <label for="passwordConfirm">비밀번호 확인</label>
			    <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control" value="${user != null ? user.passwordConfirm : ''}">
			    <c:if test="${pwErrors.hasFieldErrors('passwordConfirm')}">
			        <p class="fieldError">${pwErrors.getFieldError('passwordConfirm').defaultMessage}</p>
			    </c:if>
			</div>
	        <div class="form-group">
	            <label for="phoneNum">휴대폰 번호</label>
	            <input type="tel" id="phonNum" name="phoneNum" class="form-control" placeholder="01X-XXXX-XXXX" value="${user != null ? user.phoneNum : ''}">
	            <c:if test="${errors.hasFieldErrors('phoneNum')}">
    				<p class="fieldError">${errors.getFieldError('phoneNum').defaultMessage}</p>
				</c:if>
	        </div>
	        <div class="form-group">
	            <label for="birthday">생년월일</label>
	            <input type="date" id="birthday" name="birthday" class="form-control" value="${user != null ? user.birthday : ''}">
	        </div>
	        <div class="form-group">
	            <label for="zipCode">주소</label> <br>
	            <input class="form-control address" placeholder="우편번호" name="zipCode" id="zipCode" type="text" readonly="readonly">
	            <button type="button" class="searchBtn" onclick="execPostCode();"><i class="fa fa-search"></i>찾기</button>
	            <button type="button" class="searchBtn" onclick="deleteAddress()">삭제</button>
	        </div>
	        <div class="form-group">
	            <input class="form-control address" placeholder="도로명 주소" name="streetAddress"
	                   id="streetAddress" type="text" readonly="readonly"/>
	        </div>
	        <div class="form-group">
	            <input class="form-control address" placeholder="상세주소" name="detailAddress" id="detailAddress" type="text"/>
	        </div>
	
	        <div class="btnGroup">
	            <button type="button" class="cancelBtn" onclick="location.href='/'">취소</button>
	            <button type="submit" class="submitBtn">회원수정</button>
	        </div>
	    </form> 
	</div>     
</body>
</html>