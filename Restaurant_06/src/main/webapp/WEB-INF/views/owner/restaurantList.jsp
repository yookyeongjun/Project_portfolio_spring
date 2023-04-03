<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<div class="container">
	<div class="jumbotron"></div>
	<h2 align="center">내 식당 관리</h2>
	<div align="right">
		<a href="/owner/register"><i class="fa-solid fa-pen-to-square fa-2x" style="padding-right: 12px"></i><br>식당추가</a>
	</div>
	<div class="table-responsive">
	    <table class="table table-hover mt-3">
	      <thead>
	        <tr align="center">
	          <th width="5%">#</th>
	          <th width="15%">대표 사진</th>
	          <th width="10%">식당명</th>
	          <th width="15%">주소</th>
	          <th width="15%">전화번호</th>
	          <th width="15%">게시여부</th>
	          <th width="15%">정보수정</th>
	          <th width="10%"></th>
	        </tr>
	      </thead>
	      <tbody>
	      <c:forEach items="${restaurantList }" var="restaurant" varStatus="st">
	     	<tr align="center">
		        <td>${st.count }</td>
		        <td><img class="thumImg" src="${restaurant.thumImage }"/></td>
		        <td><a href="/restaurant/view/${restaurant.id }">${restaurant.name }</a></td>
		        <td>${restaurant.address }</td>
		        <td>${restaurant.tel }</td>
	          	<td>
	          		<button type="button" class="btn btn-info" onclick="enable(this,1)" data-id="${restaurant.id }">
						<i class="fa-solid fa-eye"></i></button>
	          		<button type="button" class="btn btn-secondary" onclick="enable(this,0)" data-id="${restaurant.id }">
						<i class="fa-solid fa-eye-slash"></i></button>
	          	</td>
	          	<td>
	          		<button type="button" class="btn btn-info"onclick="location.href='/owner/update/${restaurant.id}'">정보수정</button>
	          	</td>
	          	<td>
	          		<button type="button" class="btn btn-danger" onclick="rClose('${restaurant.id}')">폐업</button>
	          	</td>
	        </tr>
	      </c:forEach>
	      </tbody>
	    </table>
	  </div>
</div>
<script>
var enable = function(btn,enabled){
	$.ajax({
		type : "PUT",
		url : "/owner/setEnable",
		data : {
			"id" : btn.dataset.id,
			"enabled" : enabled
		}
// 		contentType : "application/json;charset=utf-8"
	})
	.done(function(resp){
		if(enabled == 1){
			alert("개시했습니다.")
		} else{
			alert("개시하지 않습니다.")
		}
	})
	.fail(function(e){
		alert("Error : " + e);
	})
} 

var rClose = function (id){
	if(!confirm("정말 삭제하시겠습니까?")) {
		return false;
	}
	$.ajax({
		type:"delete",
		url:"/owner/close/"+id
	})
	.done(function(resp){
		location.href="/owner/restaurantList/<sec:authentication property="principal.user.id"/>";
	})
	.fail(function(e){
		alert("가게 삭제 실패")
	})
}

</script>
<%@ include file="../include/footer.jsp"%>