<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<link rel="stylesheet" href="/css/mypage.css"/>
<div class="row">
<%@ include file="mypageLeftNav.jsp" %>
	<div class="col-8">
	<div class="jumbotron"></div>
	<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 즐겨찾기</h2>
  	<table class="table table-hover mt-3">
  		<thead align="center">
  			<tr>
  				<th width="30%">음식점</th>
  				<th width="10%">이름</th>
  				<th width="15%">전화번호</th>
  				<th width="20%">운영시간</th>
<!--   			<th>상세정보</th> -->
				<th width="15%">예약마감</th>
  				<th width="10%"></th>
  			</tr>
  		</thead>
   		<tbody align="center">
   			<c:forEach items="${favorites.content}" var="favorite">
    			<tr>
					<td><img src="${favorite.restaurant.thumImage }" width=100></td>
       				<td><a href="/restaurant/view/${favorite.restaurant.id }">${favorite.restaurant.name }</a></td>
        			<td>${favorite.restaurant.tel }</td>
        			<td>${favorite.restaurant.openTime } - ${favorite.restaurant.closeTime }</td>
        				
<%--         		<td>${favorite.restaurant.description }</td> --%>
					<td>${favorite.restaurant.rsvTime }</td>
        			<td><button type="button" class="btn btn-danger" onclick="dislike('${favorite.id}')"><i class="fa-solid fa-trash"></i></button></td>
      			</tr>
      		</c:forEach>
    	</tbody>
  	</table>

  	
  		<c:set value="${favorites }" var="pageImpl"/>
		<c:url value="/user/favorites/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.id}?" var="url">
		</c:url>

		<%@include file="../include/pagination.jsp" %>
 </div>
 <div class="col-2"></div>	
</div>

<script>
function dislike(id){
	$.ajax({
		type:"delete",
		url:"/user/dislike/"+id
	})
	.done(function(resp){
		location.href="/user/favorites/<sec:authentication property='principal.user.id'/>";
	})
	.fail(function(e){
		alert("좋아요 삭제 실패")
	})
}
</script>