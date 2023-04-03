<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
    
<link rel="stylesheet" href="/css/mypage.css"/>
<div class="row">
	<%@ include file="mypageLeftNav.jsp" %>
	<div class="col-8">
	<div class="jumbotron"></div>
	<h2 align="center">상세보기</h2>
	<div class="form-group">
		<label for="username">ID :</label>
		<input type="hidden" id="userid" value="${user.id }">
		<input type="text" id="username" name="username" class="form-control" value="${user.username }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="nickname">Nickname :</label>
		<input type="text" id="nickname" name="nickname" class="form-control" value="${user.nickname }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="password">PWD :</label> 
		<input type="password" id="pwd" name="pwd" class="form-control" value="${user.password }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="tel">Tel :</label>
		<input type="text" id="tel" name="tel" class="form-control" value="${user.tel }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="address">Address :</label>
		<input type="text" id="address" name="address" class="form-control" value="${user.address }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="role">Role :</label>
		<input type="text" id="role" name="role" class="form-control" value="${user.role }" readonly="readonly">
	</div>

	<div align="right">
		<button type="button" class="btn btn-info" id="btnUpdateForm">수정폼</button>
	</div>
	</div>
	<div class="col-2"></div>
</div>

 
<script>
$("#btnUpdateForm").click(function(){
	if(!confirm("수정폼으로 이동"))
		return false;
	location.href="/user/update/${id}"
});
</script>  