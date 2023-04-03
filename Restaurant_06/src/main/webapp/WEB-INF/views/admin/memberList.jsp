<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<div class="jumbotron"></div>
	<h2 align="center">회원 목록 (<span id="cntSpan">${mPage.totalElements}</span>)</h2>
	<table class="table table-hover mt-3">
		<thead>
			<tr align="center">
				<th width=10%>ID</th>
				<th width=10%>이름</th>
				<th width=15%>전화번호</th>
				<th width=40%>주소</th>
				<th width=12%>가입날짜</th>
				<th width=16%>권한</th>
				<th width=7%></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${mPage.content}" var="member">
			<c:choose>
				<c:when test="${member.role eq 'ROLE_ADMIN'}">
					<c:set var="str" value="관리자"/>
				</c:when>
				<c:when test="${member.role eq 'ROLE_OWNER'}">
					<c:set var="str" value="사업자"/>
				</c:when>
				<c:when test="${member.role eq 'ROLE_USER'}">
					<c:set var="str" value="일반회원"/>
				</c:when>
			</c:choose>
			<tr align="center">
				<td><a href = "/admin/memberView/${member.id}">${member.username}</a></td>
				<td>${member.nickname}</td>
				<td>${member.tel }</td>
				<td>${member.address }</td>
				<td><fmt:formatDate value="${member.regdate}" pattern="yyyy-MM-dd"/></td>
				<td>${str }</td>
				<td><input type="button" class="btn btn-outline-danger btn-sm" value="Delete" onclick="mdel('${member.id}','${str }')"></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<c:set value="${mPage }" var="pageImpl"/>
		<c:url value="/admin/memberList?" var="url">
		</c:url>
		<%@include file="../include/pagination.jsp" %>
</div>

<script>
	function mdel(id, str) {
		if(str=="관리자") {
			alert("관리자는 삭제할 수 없습니다")
			return
		}
		if(!confirm("정말 삭제하겟습니까?")) {
			return false;
		}
		$.ajax({
			type : "delete",
			url : "/admin/memberDelete/" + id
		})
		.done(function() {
			alert("삭제 성공")
			location.href = "/admin/memberList"	
		})
		.fail(function() {
			alert("삭제 실패")
		})
	}
</script>