<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>

<style>
.review_image{
	width: 100%
}
	
#myform fieldset{
    display: inline-block;
    direction: ltr;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform .empty{
    font-size: 1em;
     color: transparent; 
     text-shadow: 0 0 0 #f0f0f0; 
}

#myform .full{
    font-size: 1em;
     text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

</style>

<link rel="stylesheet" href="/css/mypage.css"/>

<div class="row">
<%@ include file="mypageLeftNav.jsp" %>
	<div class=col-8>
		<div class="jumbotron"></div>
		<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 후기</h2>
			<div class="review_list">
				<table class="table table-hover mt-3">
					<tr align="center">
						<th width="30%">사진</th>
						<th width="10%">작성자</th>
						<th width="10%">음식점</th>
						<th width="25%">리뷰</th>
						<th width="20%">평점</th>
						<th width="5%"></th>
					</tr>
					<c:forEach items="${uPage.content }" var = "review">
					<tr align="center">
						<td>
							<div class="review_image">
							<img class="img-fluid" src="${review.thumImage }">
							</div>
						</td>
						<td>${review.user.nickname }</td>
						<td><a href="/restaurant/view/${review.restaurant.id }">${review.restaurant.name }</a></td>
						<td>${review.content }</td>
						<td>
							<div id="myform">
							<fieldset>
								<c:forEach begin="1" end="${review.rating}" step="1">
								<label for="rate1" class="full">⭐</label>
								</c:forEach>
								<c:forEach begin="${review.rating+1 }" end="5" step="1">
								<label for="rate1" class="empty">⭐</label>
								</c:forEach>
							</fieldset>
							</div>
						</td>
						<td><button type="button" class="btn btn-danger" onclick="reviewDelete('${review.id}')"><i class="fa-solid fa-trash"></i></button></td>
					</tr>
					</c:forEach>
				</table>
			</div>
	  	<c:set value="${uPage }" var="pageImpl"/>
		<c:url value="/user/userReview/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.id}?" var="url">
		</c:url>
		<%@include file="../include/pagination.jsp" %>
	</div>
	<div class="col-2"></div>	
</div>
  	
<script>
var reviewDelete = function(id){
	if(!confirm("리뷰를 삭제하시면 재작성이 불가합니다. 삭제하시겠습니까?")){
		return false;
	}
	$.ajax({
		type:"delete",
		url:"/user/reviewDelete/" + id,
		success:function(resp){
			if(resp=="success"){
				alert("삭제되었습니다")
				location.href="/user/userReview/<sec:authentication property='principal.user.id'/>"
			}
		},
		error:function(e){
			alert("내부 문제로 인해 리뷰 삭제가 불가능합니다")
		}
	})
}
</script>