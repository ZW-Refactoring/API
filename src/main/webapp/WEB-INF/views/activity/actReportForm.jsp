<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
$(document).ready(function () {
	
	document.getElementById("reportForm").addEventListener("submit", function (event) {

		event.preventDefault();
	
		var formData = new FormData(this);
		
		fetch("/activity/actReport", {
            method: "POST",
            body: formData
        })
        .then(function(response){
            return response.text();
        })
        .then(function(data){
        alert(data);
        window.opener.location.reload();
        window.close();
        })
        .catch(function(error) {
            console.error("Error:", error);
        });
	});	
});
</script>

<style>
#header, #footer {
	display: none;
}

#wrap {
	width: 500px; height : 500px;
	overflow: scroll;
	height: 500px;
}
</style>

<form id="reportForm" action="/activity/actReport" method="post">
	<input id="stsId" name="stsId" value="${param.stsId}"><br>
	<strong>아이디:</strong>${data.userid}<br> <strong>시작:</strong>
	${data.startDate}<br> <strong>인증:</strong> ${data.endDate}<br>
	<strong>이미지 : </strong> <img
		src="/resources/upload/${data.ctfcFilename}" width="200"><br>
	<strong>신고사유 </strong>: 
	<select id = "reason" name = "reason" >
		<option value="">신고 사유 선택</option>
		<option value="관련없는사진">관련없는 사진</option>
		<option value="사진재사용">사진 반복 사용</option>
		<option value="이미지도용">이미지 도용</option>
		<option value="기타">기타</option>
	</select><br>

	<button type="submit">신고하기</button>
</form>
