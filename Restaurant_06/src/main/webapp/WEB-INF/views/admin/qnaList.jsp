<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file ="../include/header.jsp" %>

<div class="container">
	<div class="jumbotron"></div>
	<h2 align="center">Q&A목록(${count })</h2>
	<table class="table table-hover mt-3">
		<thead>
			<tr align="center">
				<th width=10%>번호</th>
				<th width=50%>제목</th>
				<th width=10%>작성자</th>
				<th width=20%>작성날짜</th>
				<th width=10%>답글여부</th>
			</tr>
		</thead>
	 	<tbody>		
			<c:forEach items="${qna.content}" var="qna">
				<tr align="center">
					<td>${qna.id}</td>
					<td><a href="/inquiry/qnaView/${qna.id}">${qna.title}</a></td>
					<td>${qna.user.nickname}</td>
					<td><fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd"/></td>
					<c:if test="${qna.reply eq 0 }">
					<td><i class="fa-solid fa-x"></i></td>
					</c:if>
					<c:if test="${qna.reply eq 1 }">
					<td><i class="fa-solid fa-o"></i></td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>	
	</table>
	<!-- Page -->
		<c:set value="${qna }" var="pageImpl"/>
		<c:url value="/inquiry/qnaList?" var="url">
		</c:url>
		<%@include file="../include/pagination.jsp" %>
		 
	<!-- Search -->	 
	<div class="d-flex justify-content-center mt-5 mr-auto">
		<div>
			<form class="form-inline" action="/inquiry/qnaList" method="get">
				<select name="field" class="form-control mr-sm-1">
					<option value="title">제목</option>
					<option value="nickname">작성자</option>
				</select>
				<input type="text" name="word" class="form-control" placeholder="search">
				<button class="btn btn-info">검색</button>
			</form>
		</div>
	</div>
</div>