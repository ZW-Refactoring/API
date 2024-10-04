<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
    	$("button").on("click", function(e){
    		var formData=$("#frm");
    		var btn=$(this).data("btn"); // data-btn="list"
    		if(btn=='modify'){
    			formData.attr("action", "/board/modify");
    		}else if(btn=='remove'){
    			formData.find("#boardTitle").remove();
    			formData.find("#boardDescription").remove();
    			formData.find("#boardAuthor").remove();
    			formData.attr("action", "/board/remove");
    			formData.attr("method", "get")
    		}else if(btn=='list'){
    			formData.find("#boardId").remove();
    			formData.find("#boardTitle").remove();
    			formData.find("#boardDescription").remove();
    			formData.find("#boardAuthor").remove();
    			formData.attr("action", "/board/list");
    			formData.attr("method", "get")
    		}
    		formData.submit();    		
    	});    	
    });
  </script>

<div class="container">
  <h2>뉴스게시판 수정</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body">      
     <form id="frm" method="post">
      <table class="table table-bordered">
         <tr>
          <td>번호</td>
          <td><input type="text" class="form-control" name="boardId" readonly="readonly" value="${vo.boardId}"/></td>
         </tr>
         <tr>
          <td>제목</td>
          <td><input type="text" class="form-control" name="boardTitle" value="<c:out value='${vo.boardTitle}'/>"/></td>
         </tr>
         <tr>
          <td>내용</td>
          <td><textarea rows="10" class="form-control" name="boardDescription"><c:out value='${vo.boardDescription}'/></textarea> </td>
         </tr>
         <tr>
          <td>작성자</td>
          <td><input type="text" class="form-control" name="boardAuthor" readonly="readonly" value="${vo.boardAuthor}"/></td>
         </tr>
         <tr>
           <td colspan="2" style="text-align: center;">
               <button type="button" data-btn="modify" class="btn btn-sm btn-primary">수정</button>
               <button type="button" data-btn="remove" class="btn btn-sm btn-warning">삭제</button>
               <button type="button" data-btn="list" class="btn btn-sm btn-info">목록</button>
           </td>
         </tr>
      </table>
          <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
          <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
          <input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
          <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
      </form>
    </div>
  </div>
</div>

