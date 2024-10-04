<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/get.css">
    <script type="text/javascript">
        $(document).ready(function(){
            $("button").on("click", function(e){
                var formData=$("#frm");
                var btn=$(this).data("btn"); // data-btn="list"
                if(btn=='modify'){
                    formData.attr("action", "/board/modify");
                }else if(btn=='list'){
                    formData.find("#boardId").remove();
                    formData.attr("action", "/board/list");
                }
                formData.submit();
            });
        });
    </script>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">뉴스게시판</div>
        <div class="panel-body">
            <table class="table table-bordered">
                <tr>
                    <td>번호</td>
                    <td><input type="text" class="form-control" name="boardId" value="${vo.boardId}" disabled/></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" class="form-control" name="boardTitle" value="${vo.boardTitle}" disabled/></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea rows="10" class="form-control" name="boardDescription" disabled>${vo.boardDescription}</textarea>
                        <a href="${vo.boardLink}">Copyright (c) www.econew.co.kr All rights reserved</a>
                    </td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td><input type="text" class="form-control" name="boardAuthor" value="${vo.boardAuthor}" disabled/></td>
                </tr>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <button data-btn="modify" class="btn btn-sm btn-success">수정</button>
                            <button data-btn="list" class="btn btn-sm btn-info">목록</button>
                        </td>
                    </tr>
                </sec:authorize>
                <sec:authorize access="!hasRole('ROLE_ADMIN')">
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <button data-btn="list" class="btn btn-sm btn-info">목록</button>
                        </td>
                    </tr>
                </sec:authorize>
            </table>
            <sec:authorize access="isAuthenticated()">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div id="comment-form" class="row">
                            <div class="col-md-6">
                                <input type="text" id="commentContents" class="form-control" placeholder="내용">
                            </div>
                            <div class="col-md-6">
                                <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">댓글작성</button>
                            </div>
                        </div>
                    </div>
                </div>
            </sec:authorize>
            <sec:authorize access="!isAuthenticated()">
                <div class="alert alert-warning" role="alert">
                    댓글을 작성하려면 <a href="/user/login" class="alert-link">로그인</a> 해주세요.
                </div>
            </sec:authorize>
        </div>
    </div>


            <div class="panel panel-default">
                <div class="panel-body">
                    <div id="comment-list" class="row">
                        <div class="col-md-12">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>댓글번호</th>
                                    <th>작성자</th>
                                    <th>내용</th>
                                    <th>작성시간</th>
                                    <th>삭제</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${commentList}" var="comment">
                                    <tr>
                                        <td>${comment.commentId}</td>
                                        <td>${comment.userid}</td>
                                        <td>${comment.commentContent}</td>
                                        <td>${comment.commentCreatedDate}</td>
                                        <sec:authorize access="isAuthenticated()">
                                            <td><button class="btn btn-danger" onclick="deleteComment(${comment.commentId})">삭제</button></td> <!-- 삭제 버튼 추가 -->
                                        </sec:authorize>
                                        <sec:authorize access="!isAuthenticated()">
                                            <td><button class="btn btn-danger" disabled>삭제</button></td>
                                        </sec:authorize>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

            <form id="frm" method="get">
                <input type="hidden" id="boardId" name="boardId" value="${vo.boardId}"/>
                <input type="hidden" name="page" value="${cri.page}"/>
                <input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
                <input type="hidden" name="type" value="${cri.type}"/>
                <input type="hidden" name="keyword" value="${cri.keyword}"/>
            </form>
        </div>
    </div>
</div>

<script>
    const commentWrite = () => {
        const contents = document.getElementById("commentContents").value;
        const board = '${vo.boardId}';

        $.ajax({
            type: "post",
            url: "/comment",
            data: {
                commentContent: contents,
                boardId: board
            },
            dataType: "json",
            success: function(commentList) {
                alert(commentList);
                console.log("작성성공");
                console.log(commentList);
                let output = "<table>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for(let i in commentList){
                    output += "<tr>";
                    output += "<td>"+commentList[i].commentId+"</td>";
                    output += "<td>"+commentList[i].userid+"</td>";
                    output += "<td>"+commentList[i].commentContent+"</td>";
                    output += "<td>"+commentList[i].commentCreatedDate+"</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('comment-list').innerHTML = output;
                document.getElementById('commentWriter').value='';
                document.getElementById('commentContents').value='';
            },
            error: function() {
                var errorMessage = xhr.status + ': ' + xhr.statusText;
                alert("error");
                console.log('AJAX Error - ' + errorMessage);
                console.log('Error Details - ' + error);
            }
        });
    }

    function deleteComment(commentId) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                type: 'DELETE',
                url: '/comment/'+commentId,
                success: function(response) {
                    // 삭제 성공 시 해당 댓글 행을 테이블에서 제거합니다.
                    if (response === "success") {
                        alert("댓글이 삭제되었습니다.");
                        $('#comment-' + commentId).remove();
                        location.reload(true);
                    } else {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("서버와의 통신 중 오류가 발생했습니다.");
                }
            });
        }
    }
</script>
