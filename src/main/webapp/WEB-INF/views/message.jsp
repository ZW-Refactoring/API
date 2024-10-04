<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	<c:if test="${mode eq null or mode eq ''}">
		alert('${msg}');
		location.href = '${loc}';
	</c:if>
	<c:if test="${mode eq 'popup'}">
		alert('${msg}');
		window.close();
		opener.location.reload();
	</c:if>
</script>