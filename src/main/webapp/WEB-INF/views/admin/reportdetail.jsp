<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/commit.css">
<style type="text/css">
body {
    margin: 50px;
    background-color: #f5f5f5;
}

h2 {
    color: #333;
}

.container {
    width: 80%;
    margin: auto;
}

.post {
    border: 1px solid #ccc;
    background-color: #fff;
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 5px;
}

.post h3 {
    margin-top: 0;
}

.post p {
    margin-bottom: 0;
}

.actions {
    text-align: center;
}

.actions a {
    display: inline-block;
    padding: 6px 12px;
    background-color: #007bff;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.actions a:hover {
    background-color: #0056b3;
}
</style>
<script>

</script>
<title>신고 상세 정보</title>
</head>
<body>
    <div class="container">
        <h2>신고 상세 정보</h2>
        <div class="post">
            <h3>신고 활동 번호: ${report.repId}</h3>
            <p><strong>신고자:</strong> ${report.reporter}</p>
            <p><strong>사용자 아이디:</strong> ${report.userid}</p>
            <p><strong>신고 사유:</strong> ${report.reason}</p>
            <p><strong>신고 일자:</strong> ${report.sdate}</p>
            <p><strong>처리 일자:</strong> ${report.edate}</p>
            <p><strong>활동 상태:</strong>
                <c:choose>
                    <c:when test="${report.state == -1}">
                        취소
                    </c:when>
                    <c:when test="${report.state == 1}">
                        시작
                    </c:when>
                    <c:when test="${report.state == 2}">
                        완료
                    </c:when>
                    <c:when test="${report.state == 3}">
                        대기
                    </c:when>
                    <c:when test="${report.state == 4}">
                        반려
                    </c:when>
                    <c:otherwise>
                        불명
                    </c:otherwise>
                </c:choose>
            </p>
           <p><strong>증빙 파일:</strong> 
    <img src="/resources/upload/${report.ctfcFilename}" alt="증빙 파일" width="200">
</p>
            <div class="actions">
                <form id="reportForm" method="post" action="/admin/reportdetail/saveReportResult">
                    <input type="hidden" name="repId" value="${report.repId}">
                    <input type="hidden" name="repResult" value="1">
                    <input type="hidden" name="stateId" value="${report.stateId}">
                    <!-- 신고 상태의 식별자 -->
                    <select name="state">
                    	<option value="">수정</option>
                        <option value="-1">취소</option>
                        <option value="1">시작</option>
                        <option value="2">완료</option>
                        <option value="3">대기</option>
                        <option value="4">반려</option>
                        
                    </select>
                    <button type="submit">저장</button>
                </form>
            </div>
        </div>
        <a href="/reportform" class="actions">뒤로 가기</a>
    </div>
</body>
</html>
