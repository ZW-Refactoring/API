<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="/resources/css/loginForm.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="loginWrap">
        <h2>로그인</h2>
        <form role="form" method="post" action="/user/login">
            <div class="loginInput">
                <input type="text" name="userId" class="form-control" placeholder="아이디 입력해주세요">
            </div>
            <div class="loginInput">
                <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호 입력">
            </div>
			<c:if test="${not empty loginErrorMsg}">
		       <p class="error text-center"><c:out value="${loginErrorMsg}" /></p>
		   </c:if>
            <button class="loginBtn">로그인</button>
        </form>

        <div class="or">또는</div>

        <div class="snsLogin">
            <a href="/oauth2/authorization/google"><img src="/resources/images/nav_google-icon.png" alt="구글"></a>
            <a href="/oauth2/authorization/naver"><img src="/resources/images/nav_naver-icon.png" alt="네이버"></a>
            <a href="/oauth2/authorization/kakao"><img src="/resources/images/nav_kakako-icon.png" alt="카카오"></a>
        </div>
        <div class="row justify-content-center mt-3">
            <div class="col-md-6">
                <p class="text-center">회원이 아니신가요? <a href="/user/join">여기</a>를 클릭하여 회원가입하세요.</p>
            </div>
        </div>
    </div>
</body>
</html>