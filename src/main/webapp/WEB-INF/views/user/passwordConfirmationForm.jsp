<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정 비밀번호 확인</title>
<link rel="stylesheet" href="/resources/css/joinForm.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/joinForm.js"></script>
<!-- Bootstrap CSS 로드 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery 로드 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Bootstrap JavaScript 로드 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="joinWrap">
    <h2>비밀번호 확인</h2>
    <form action="<c:url value='/user/edit/password'/>" role="form" method="post">
        <div class="form-group">
            <label for="password">비밀번호 확인</label>
            <input type="password" id="password" name="password" class="form-control" required="required">
        </div>
        <div class="btnGroup">
            <button type="button" class="cancelBtn" onclick="location.href='/';">취소</button>
            <button type="submit" class="submitBtn">확인</button>
        </div>
    </form> 
    <c:if test="${param.error != null or not empty errorMessage}">
        <div>
            <p class="error">${param.error != null ? '비밀번호가 일치하지 않습니다.' : errorMessage}</p>
        </div>
    </c:if>
</div>     
</body>
</html>