<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/commit.css">

<title>관리자 신고 확인 페이지</title>
<style type="text/css">
body {
	margin: 50px;
}

/* 테이블 전체 스타일 */
table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 20px;
}

/* 테이블 헤더 스타일 */
th {
	background-color: #8AAB95;
	text-align: left;
	padding: 8px;
	text-align: center;
}

/* 테이블 셀 스타일 */
td {
	padding: 8px;
	text-align: center;
}

/* 짝수 행 배경색 스타일 */
tr:nth-child(even) {
	background-color: #f2f2f2;
}

/* 마우스를 올렸을 때 행 배경색 스타일 */
tr:hover {
	background-color: #ddd;
}

.waiting {
	color: red;
}
</style>
</head>
<body>
	<h2>신고 리스트</h2>
	<div>
		<table border="1">
			<tr>
				<th>신고 활동 번호</th>
				<th>신고자</th>
				<th>해당 유저</th>
				<th>신고 사유</th>
				<th>처리 상태</th>
			</tr>
			<c:forEach items="${reports}" var="report">
				<tr
					onclick="window.location='/admin/reportdetail?repId=${report.repId}'">
					<td>${report.stsId}</td>
					<td><c:choose>
							<c:when test="${fn:length(report.reporter) > 30}">
                        ${fn:substring(report.reporter, 0, 30)}...
                    </c:when>
							<c:otherwise>
                        ${report.reporter}
                    </c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${fn:length(report.userid) > 30}">
                        ${fn:substring(report.userid, 0, 30)}...
                    </c:when>
							<c:otherwise>
                        ${report.userid}
                    </c:otherwise>
						</c:choose></td>
					<td>${report.reason}</td>
					<td id="repResult">
						<form id="reportForm" method="get" action="/admin/reportform">
							<input type="hidden" name="repId" value="${report.repId}">
							<c:choose>
								<c:when test="${report.repResult == 0}">
									<span class="waiting">대기</span>
								</c:when>
								<c:otherwise>
                    변경 
                </c:otherwise>
							</c:choose>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>

</html>
