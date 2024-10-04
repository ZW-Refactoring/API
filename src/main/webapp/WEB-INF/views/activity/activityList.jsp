<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/resources/js/activity.js"></script>
<link rel="stylesheet" href="/resources/css/actList.css">
<!-- 활동 카테고리 -->
<br>
<div id="container2" class="container2">

		<c:if test="${principal.username ne null}">
			<c:import url="/dailymission"></c:import>
		</c:if>


	<!-- 활동 카테고리 -->
	<div id="ctgrList">
		<ul id="category" class="category">
			<li><a href="javascript:selectCtgr('all')" class="ctgrNames">전체</a></li>
			<c:forEach var="category" items="${ctgrList}">

				<li><a
					href="javascript:selectCtgr('${category.act_ctgr_name}')">${category.act_ctgr_name}</a></li>
			</c:forEach>
		</ul>
	</div>

	<div id="act_wrap">
		<div id="activityList">
			<table id="list">
				<tr>
					<th>번호</th>
					<th>분류</th>
					<th>이름</th>
					<th>포인트</th>
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
								<td class="actNo"><c:out value="${act.actId}" /></td>
								<td class="actCategory"><c:out value="${act.actCategory}" /></td>
								<td class="actName"><a href="/actDetail/${act.actId }">
										<c:out value="${act.actName}" />
								</a></td>
								<td class="point"><c:out value="${act.point}" /></td>
							</tr>
							<!-- --------------------------- -->

						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>

		<br>
		<c:if test="${actNo ne null}">
			<div id=content>
				<div id="actContent">
					<input type="text" id="actno" value="${actNo}"> <input
						type="hidden" id="username" value="${principal.username}">
					<c:import
						url="classpath:static/activity_contents/actno${actNo }.html"
						charEncoding="UTF-8" />
					<c:choose>
						<c:when test="${userActList[actNo-1].state ne 1}">
							<button id="start" onclick="actStart()">시작하기</button>
						</c:when>
						<c:otherwise>
							<button id="ctfc" onclick="actCtfc()">인증하기</button>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when
							test="${userActList[actNo-1].bookmark eq 0 || userActList[actNo-1].bookmark eq null}">
							<button id="bookmark"
								onclick="addBookmark('${principal.username}')">즐겨찾기</button>
						</c:when>
						<c:otherwise>
							<button onclick="removeBookmark('${principal.username}')">즐겨찾기
								해제</button>
						</c:otherwise>
					</c:choose>
					<button id="sts" onclick="actSts()">결과보기</button>
				</div>
				<div id="statusCounts"></div>
				<div id="stsListContainer"></div>
			</div>
		</c:if>
	</div>
</div>