<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/d547fb2b9c.js"
	crossorigin="anonymous"></script>
<!--FontAwesome-->
<link rel="stylesheet" href="/resources/css/board.css">
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$("#regBtn").click(function() {
							location.href = "/board/register";
						});
						//페이지 번호 클릭시 이동 하기
						var pageFrm = $("#pageFrm");
						$(".paginate_button a").on("click", function(e) {
							e.preventDefault(); // a tag의 기능을 막는 부분
							var page = $(this).attr("href"); // 페이지번호
							pageFrm.find("#page").val(page);
							pageFrm.submit(); // /sp08/board/list
						});
						// 상세보기 클릭시 이동 하기
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault(); // a tag의 기능을 막는 부분
											var boardId = $(this).attr("href");
											var tag = "<input type='hidden' name='boardId' value='"+boardId+"'/>";
											pageFrm.append(tag);
											pageFrm
													.attr("action",
															"/board/get");
											pageFrm.submit();
										});

					});
	function goMsg() {
		alert("삭제된 게시물입니다.");
	}
</script>

<div class="container">
	<h2>뉴스 게시판</h2>
	<div class="panel panel-default">
		<div class="panel-body">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<c:forEach var="board" items="${list}">
					<tr>
						<td>${board.boardId}</td>
						<td><c:choose>
								<c:when test="${board.boardAvailable==1}">
									<a class="move" href="${board.boardId}"><c:out
											value='${board.boardTitle}' /></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:goMsg()">삭제된 게시물입니다.</a>
								</c:otherwise>
							</c:choose></td>
						<td>${board.boardAuthor}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.boardDate}" /></td>
					</tr>
				</c:forEach>
			</table>
			<!-- 페이징 START -->
			<div style="text-align: center">
				<ul class="pagination">
					<!-- 이전처리 -->
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous"><a
							href="${pageMaker.startPage-1}">◀</a></li>
					</c:if>
					<!-- 페이지번호 처리 -->
					<c:forEach var="pageNum" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li
							class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''}"><a
							href="${pageNum}">${pageNum}</a></li>
					</c:forEach>
					<!-- 다음처리 -->
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage+1}">▶</a></li>
					</c:if>
				</ul>
			</div>
			<!-- END -->
			<!-- 검색메뉴 -->
			<div style="text-align: center;">
				<form class="form-inline" action="/board/list" method="post">
					<div class="form-group">
						<select name="type" class="form-control">
							<option value="boardAuthor"
								${pageMaker.cri.type=='boardAuthor' ? 'selected' : ''}>작성자</option>
							<option value="boardTitle"
								${pageMaker.cri.type=='boardTitle' ? 'selected' : ''}>제목</option>
							<option value="boardDescription"
								${pageMaker.cri.type=='boardDescription' ? 'selected' : ''}>내용</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="keyword"
							value="${pageMaker.cri.keyword}">
					</div>
					<button type="submit" class="btn btn-success">검색</button>
				</form>
			</div>
			<form id="pageFrm" action="/board/list" method="get">
				<input type="hidden" id="page" name="page"
					value="${pageMaker.cri.page}" /> <input type="hidden"
					name="perPageNum" value="${pageMaker.cri.perPageNum}" />
			</form>
		</div>
	</div>
</div>

