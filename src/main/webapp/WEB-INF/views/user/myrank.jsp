<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ranking</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/myrank.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center">나의 순위: ${rank}등, 나의 포인트: ${score}</h2>
        <br>
        <h3 class="text-center">[전체 랭킹]</h3>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>등수</th>
                        <th>아이디</th>
                        <th>포인트</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${rankList eq null or empty rankList}">
                            <tr>
                                <td colspan="3"><b>데이터가 없습니다</b></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="rank" items="${rankList}" varStatus="loop">
                                <tr class="${rank.userid eq userid ? 'highlight-row' : ''}">
                                    <td>${rank.userRank}</td>
                                    <td>${rank.userid}</td>
                                    <td>${rank.userPoint}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        openRankWindow();
    </script>
</body>
</html>
