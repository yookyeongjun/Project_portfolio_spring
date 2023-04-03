<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<div class="jumbotron"></div>
	<h2 align="center">음식점 등록</h2>
	<div class="form-group">
		<label for="name">음식점이름 :</label>
		<input type="text" id="name" name="name" class="form-control" placeholder="Enter Restaurant Name">
	</div>
	<div class="form-group">
		<label for="businessNum">사업자 등록 번호 :</label>
		<input type="text" id="businessNum" name="businessNum" class="form-control" placeholder="Enter Business Number">
	</div>
	<div class="form-group">
		<label for="address">주소 :</label> 
		<input type="text" id="address" name="address" class="form-control" placeholder="Enter Address">
	</div>
	<div class="form-group">
		<label for="tel">전화번호 :</label> 
		<input type="text" id="tel" name="tel" class="form-control" placeholder="Enter Tel">
	</div>
	<div class="form-group">
		<label for="url">홈페이지 :</label> 
		<input type="text" id="url" name="url" class="form-control" value="http://">
	</div>

	<div align="center">
		<button type="button" class="btn btn-info" id="btnRegister">Register</button>
	</div>
</div>

<script>
$("#btnRegister").click(function() {
	if($("#name").val()=="") {
		alert("음식점 이름을 입력하세요")
		return false;
	}
	if($("#businessNum").val()=="") {
		alert("사업자 등록번호를 입력하세요")
		return false;
	}
	if($("#address").val()=="") {
		alert("주소를 입력하세요")
		return false;
	}
	if($("#tel").val()=="") {
		alert("전화번호를 입력하세요")
		return false;
	}
	var dataParam = {
		"name" : $("#name").val(),
		"businessNum" : $("#businessNum").val(),
		"address" : $("#address").val(),
		"tel" : $("#tel").val(),
		"url" : $("#url").val()
	}
	$.ajax({
		type : "post",
		url : "/owner/register",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(dataParam)
	})
	.done(function(resp) {
		alert("등록 성공")
		location.href="/owner/update/" + resp;
	})
	.fail(function() {
		alert("error")
	})
})
</script>
