<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<style>
#rating fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#rating fieldset legend{
    text-align: right;
}
#rating input[type=radio]{
    display: none;
}
#rating label{
    font-size: 2em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#rating label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rating label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rating input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}

</style>
<div class="jumbotron"></div>
<h2 align="center">후기</h2>
<div class="container">
	<form method="post" id = "myform" enctype="multipart/form-data">
	<input type="hidden" id="rid" name="rid" value="${rid }">
		<div class="row">
			<div class="col-lg-6">
				<table class="table table-borderless">
					<tr height="350px">
						<td style="vertical-align: bottom">
							<div class="form-group">
							<img src="/img/test.png" width="100%">
			  				<input type="file" class="form-control" onchange="readURL(this)" name="upload" id="upload" placeholder="사진을 올려주세요">
			  				</div>
			  			</td>
			  		</tr>
			  	</table>
			</div>
			<div class="col-lg-6">
				<table class="table table-borderless">
					<tr>
						<td>
							<span class="text-bold">별점을 선택해주세요</span>
							<div id="rating">
								<fieldset>
									<input type="radio" name="reviewStar" value="5" id="rate1" checked>
										<label for="rate1">⭐</label>
										<input type="radio" name="reviewStar" value="4" id="rate2">
										<label for="rate2">⭐</label>
										<input type="radio" name="reviewStar" value="3" id="rate3">
										<label for="rate3">⭐</label>
										<input type="radio" name="reviewStar" value="2" id="rate4">
										<label for="rate4">⭐</label>
										<input type="radio" name="reviewStar" value="1" id="rate5">
										<label for="rate5">⭐</label>
								</fieldset>
							</div>
							<div class="form-group">
								<textarea class="col-auto form-control" id="content" rows="10" name="content" placeholder = "리뷰를 작성해주세요"></textarea>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div align="center">
			<button type="button" class="btn btn-info" id="btnReview">후기 작성</button>
		</div>
	</form>
</div>	

<script>

$("#btnReview").click(function(){
	
	var form = $('#upload')[0].files[0];
	var formData = new FormData();
	
	var dataParam = {
			user : {
				id :<sec:authentication property="principal.user.id"/>
			},
			restaurant : {
				id : "${rid }"  //자기요소 바로 밑에 요소 가져옴 .value 그 값을 불러옴 ->아이디 식별이 안되니까
			}, 
			
			"rating" : $('input[name=reviewStar]:checked').val(),
			"content" :$("#content").val()
	}
	if(form == null){
		formData.append('file', new File(["empty"],"empty"));
	} else {
		formData.append('file',form);
	}
	formData.append('review',new Blob([JSON.stringify(dataParam)], {type :"application/json"}));
	
	
	$.ajax({
		type:"post",
		url : "/user/review",
		contentType: false,
		processData:false,
		enctype:'multipart/form-data',
		data : formData
		
	})
	.done(function(resp){
		alert("리뷰 작성 완료")
		location.href="/"	
	})
	.fail(function(e){
		alert("리뷰 작성 실패")
	})
	
})

	function readURL(input) {  //이미지 실시간 업로드
		if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      input. previousElementSibling.src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		} else {
			input. previousElementSibling.src = "";
		}
	}
</script>