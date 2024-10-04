<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
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
    // 중복확인 버튼 클릭 시 registerCheck() 함수 호출
    $('#duplicateCheckButton').on('click', function() {
        var userid = $("#userid").val();
        // 아이디 입력 확인
        if (!userid) {
            alert("아이디를 입력해주세요.");
            return;
        }
        // AJAX 요청
        $.ajax({
            url: "/user/registerCheck",
            type: "get",
            data: { "userid": userid },
            success: function(response) {
                if (response == 1 && userid.length >= 5 && userid.length <= 30) {
                    $("#checkMessage").html("사용할 수 있는 아이디입니다.");
                    $("#checkType").attr("class", "modal-content panel-success");
                } else {
                    $("#checkMessage").html("사용할 수 없는 아이디입니다. 아이디는 영문자와 숫자를 포함한 5자에서 30자 사이여야 합니다.");
                    $("#checkType").attr("class", "modal-content panel-warning");
                }
                $("#myModal").modal("show");
            },
            error: function() {
                alert("서버 요청 중 오류가 발생했습니다.");
            }
        });
    });
    
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

    // 가입 버튼 클릭 시 처리
    $('#join').on('click', function(e) {
        e.preventDefault(); // 이벤트 S기본 동작 방지
        // 중복 확인 결과가 성공인 경우에만 submit 실행
        if ($("#checkMessage").text() === "사용할 수 있는 아이디입니다.") {
            $('form[name="mf"]').submit();
        } else {
            alert("아이디 중복체크를 눌러주세요");
        }
    });
});
</script>
</head>
<body>
	<div class="joinWrap">
	    <h2>회원가입</h2>
	    <form name="mf" action="/user/join" role="form" method="post">
	        <div class="form-group">
			    <label for="userid">아이디</label>
			    <input type="text" id="userid" name="userid" class="form-control" placeholder="아이디를 입력해주세요" value="${user != null ? user.userid : ''}">
			    <button type="button" id="duplicateCheckButton" class="btn btn-primary btn-sm">중복확인</button>
			    <c:if test="${errors.hasFieldErrors('userid')}">
			        <p class="fieldError">${errors.getFieldError('userid').defaultMessage}</p>
			    </c:if>
			    <c:if test="${unErrors.hasFieldErrors('userid')}">
			        <p class="fieldError">${unErrors.getFieldError('userid').defaultMessage}</p>
			    </c:if>
			</div>
	        <div class="form-group">
	            <label for="email">이메일 주소</label>
	            <input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력해주세요" value="${user != null ? user.email : ''}">
	            <c:if test="${errors.hasFieldErrors('email')}">
			        <p class="fieldError">${errors.getFieldError('email').defaultMessage}</p>
			    </c:if>
			    
	        </div>
	        <div class="form-group">
		    <label for="password">비밀번호</label>
		    <input type="password" id="password" name="password" class="form-control" placeholder="영문자, 숫자, 특수기호를 포함하고, 8~20자 사이" value="${user != null ? user.password : ''}">
		    <c:if test="${errors.hasFieldErrors('password')}">
		        <p class="fieldError">${errors.getFieldError('password').defaultMessage}</p>
		    </c:if>
			</div>
			<div class="form-group">
			    <label for="passwordConfirm">비밀번호 확인</label>
			    <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control" placeholder="영문자, 숫자, 특수기호를 포함하고, 8~20자 사이" value="${user != null ? user.passwordConfirm : ''}">
		        <p id="passwordMatchError" class="fieldError"></p> <!-- 추가 -->    
			    <c:if test="${pwErrors.hasFieldErrors('passwordConfirm')}">
			        <p class="fieldError">${pwErrors.getFieldError('passwordConfirm').defaultMessage}</p>
			    </c:if>
			</div>
	        <div class="form-group">
	            <label for="phoneNum">휴대폰 번호</label>
	            <input type="tel" id="phoneNum" name="phoneNum" class="form-control" placeholder="01X-XXXX-XXXX" value="${user != null ? user.phoneNum : ''}">
	            <c:if test="${errors.hasFieldErrors('phoneNum')}">
    				<p class="fieldError">${errors.getFieldError('phoneNum').defaultMessage}</p>
				</c:if>
	        </div>
	        <div class="form-group">
	            <label for="birthday">생년월일</label>
	            <input type="date" id="birthday" name="birthday" class="form-control" placeholder="생년월일을 입력해주세요" value="${user != null ? user.birthday : ''}">
	        	<c:if test="${birthErrors.hasFieldErrors('birthday')}">
			        <p class="fieldError">${birthErrors.getFieldError('birthday').defaultMessage}</p>
			    </c:if>
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
	        
	        <div class="error-message">
			    <p>${errorMessage}</p>
			</div>
	
	        <div class="btnGroup">
	            <button type="button" class="cancelBtn" onclick="location.href='/'">취소</button>
	            <button id="join" type="submit" class="submitBtn">회원가입</button>
	        </div>
	
	    </form>
	<!-- 아이디 중복체크 -->    
	<div id="myModal" class="modal fade" role="dialog" >
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>	
	  </div>
	</div>     
</body>
</html>