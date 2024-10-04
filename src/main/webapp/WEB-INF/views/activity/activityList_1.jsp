<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>제로활동리스트</title>
<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	
<script src="/resources/js/activity.js"></script>
</head>
<body>
<!-- 활동 카테고리 -->
	<div>
		<ul class="category">
			<li><a href="javascript:selectCtgr('all')">전체</a></li>
			<c:forEach var="category" items="${ctgrList}">
				<li><a href="javascript:selectCtgr('${category.actCtgrName}')">${category.actCtgrName}</a></li>
			</c:forEach>
		</ul>
	</div>
	
	<div id = "actList">
	test
	</div>
	
	<div id="activityList">
	<table>
		<tr>
			<th width="10%">번호</th>
			<th width="20%">분류</th>
			<th width="30%">이름</th>
			<th width="20%">등록일</th>
			<th width="10%">난이도</th>
			<th width="10%">포인트</th>
		</tr>
		<c:choose>
			<c:when test="${actList eq null or empty actList}">
				<tr>
					<td colspan="6"><b>데이터가 없습니다</b></td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="act" items="${actList}">
					<tr>
						<td id="actNo"><c:out value="${act.actNo}" /></td>
						<td id="actCategory"><c:out value="${act.actCategory}" /></td>
						<td id="actName"><a href="#"><c:out value="${act.actName}" /></a></td>
						<td id="edate"><c:out value="${act.edate}" /></td>
						<td id="difficulty"><c:out value="${act.difficulty}" /></td>
						<td id="point"><c:out value="${act.point}" /></td>
					</tr>
					<!-- --------------------------- -->
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
</body>
</html>