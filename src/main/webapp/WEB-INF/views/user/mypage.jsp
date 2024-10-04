<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- websocket 라이브러리 추가 CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script defer src="/resources/js/mypage.js"></script>
<script defer src="/resources/js/mypage_ws.js"></script>
<link rel="stylesheet" href="/resources/css/mypage.css">

<div id="container2" class="container2">

    <h1 class="text-center"><span id="myid">${username}</span>님의 활동</h1>
    <br>
    <div id="stateList">
        <ul id="category" class="category">
            <li><a href="javascript:selectCtgr('all')" class="ctgrNames">전체</a></li>
            <c:forEach var="state" items="${stateList}">
                <li><a href="javascript:selectCtgr('${state.state_name}')" class="ctgrNames">${state.state_name}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div id="actList">
        <table id="list" border="1">
            <tr>
                <th>활동번호</th>
                <th>이름</th>
                <th>활동상태</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>인증 유효시간</th>
                <th>취소</th>
            </tr>
            <c:choose>
                <c:when test="${userActList eq null or empty userActList}">
                    <tr>
                        <td colspan="7"><b>아직 시작한 활동이 없습니다.</b></td>
                        <td colspan="7">제로웨이스트 활동을 시작해보세요!<a href="/actList">활동하러 가기</a></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="act" items="${userActList}">
                        <tr>
                            <td class="actNo"><c:out value="${act.actId}" /></td>
                            <td class="actName"><a href="/actDetail/${act.actId}"><c:out value="${act.actName}" /></a></td>
                            <td class="actState"><c:out value="${act.stateName}" /></td>
                            <td class="sdate"><fmt:formatDate value="${act.startDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td class="edate"><fmt:formatDate value="${act.endDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td id="tl${act.actId}_${act.state}" class="timeLeft" data-act-id="${act.actId}" data-act-state="${act.state}" style="color:green">${act.timeLeft}</td>
                            <td class="cancle"><c:if test="${act.state eq 1}">
                                    <button id="btnCancle" onclick="goCancle(${act.actId})">취소</button>
                                </c:if></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
        <form name="cancleForm" id="cancleForm" method="post" action="/user/actCancle">
            <input id="cancleNo" name="cancleNo" type="hidden">
        </form>
    </div>
    	<button type="button" onclick="location.href='/user/edit/password' ">회원 정보 수정</button>
    <br><br>
    <div id="favList">
        <h1 class="text-center">${username}님의 즐겨찾기</h1>
        <br>
        <table border="1">
            <tr>
                <th>활동번호</th>
                <th>이름</th>
                <th>즐겨찾기 해제</th>
            </tr>
            <c:choose>
                <c:when test="${userBookmarkList eq null or empty userBookmarkList}">
                    <tr>
                        <td colspan="3"><b>즐겨찾기한 활동이 없습니다.</b></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="bm" items="${userBookmarkList}">
                        <tr>
                            <td class="actId"><c:out value="${bm.actId}" /></td>
                            <td class="actName">
                                <a href="/actDetail/${bm.actId}"><c:out value="${bm.actName}" /></a>
                            </td>
                            <td class="cancle" style="text-align: center;">
                                <button id="btnCancle" onclick="removeBookmark('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.userid}', ${bm.actId})">해제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </div>
</div>
