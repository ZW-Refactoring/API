<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    <div id="dailymissionList">
		<h3 style="color:#2E5A3C">${todayDate}의 랜덤 미션 (오늘 수행하면 포인트 2배 지급♣)</h3>
		<table id="dailyList">
			<tr>
				<th width="10%">순번</th>
				<th width="80%">이름</th>
				<th width="10%">포인트</th>
			</tr>
			<c:choose>
				<c:when test="${missions eq null or empty missions}">
					<tr>
						<td colspan="3"><b>데이터가 없습니다</b></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="mission" items="${missions}" varStatus="loop">
						<tr>
							<td><c:out value="${loop.index + 1}" /></td>
							<td id="missionName"><a href="/actDetail/${mission.actId}"><c:out value="${mission.actName}" /></a></td>
							<td id="point"><c:out value="${2 * mission.point}" /></td>
						</tr>
						<!-- --------------------------- -->
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
