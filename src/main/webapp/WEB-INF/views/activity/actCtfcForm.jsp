<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="/resources/js/activity.js"></script>
    
<style>
	#header, #footer{
	display:none;
	}
</style>

<form id="Ctfc_Form" action="" method="post" enctype="multipart/form-data">
인증을 해봅시다.<br>
사진 업로드<br>
<input id="actNo" name ="actNo" value="${param.actno}"><br>
<input type="file" id="imgFile" name="imgFile" accept=".jpg, .png" required>
<button type="submit">인증하기</button>
</form>
