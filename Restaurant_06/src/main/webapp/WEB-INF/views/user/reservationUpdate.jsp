<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<div class="container">
	<div class="jumbotron"></div>
	<h2 align="center">${rsv.restaurant.name } 예약변경하기</h2>
	<div class="row" align="center">
		<div class="col-lg-6">					<!-- 썸네일 -->
			<img src="${rsv.restaurant.thumImage }" width=100%>
		</div>
		<div class="col-lg-6">					<!-- 달력 -->
			<div id="datepicker"></div>
  		</div>
  	</div>
  	<div class="mt-3" align="center">
  		<div class="card" style="width:100%">	<!-- 예약정보 -->
  			<div class="row" align="center">
  			<div class="col-lg-7">
				<div class="card-body" align="left">
					<div class="row">
					<div class="col-lg-5">
						<table class="table table-borderless">
							<tr><td><h1>Reservation</h1></td></tr>
							<tr><td><h3>${rsv.restaurant.name }</h3></td></tr>
							<tr><td><h6>${rsv.restaurant.tel }</h6></td></tr>
      					</table>
      				</div>
      				<div class="col-lg-7">
      					<table class="table table-borderless">
      						<tr>
      							<td>예약자</td>
      							<td width="60%"><input type="text" id="name" value="${rsv.user.nickname }" name="name" class="form-control" readonly="readonly"></td>
      						</tr>
      						<tr>
      							<td>예약자수</td>
      							<td><input type="text" id="peopleCnt" name="peopleCnt" class="form-control" value="${rsv.peopleCnt }"></td>
      						</tr>
      						<tr>
      							<td>예약날짜</td>
      							<td><input type="text" id="rsvDate" name="rsvDate" class="form-control" readonly="readonly"></td>
      						</tr>
      						<tr>
      							<td>예약시간</td>
      							<td><input type="text" id="rsvTime" name="rsvTime" class="form-control timepicker" readonly="readonly"></td>
      						</tr>
      					</table>
      					
      				</div>
      				</div>
    			</div>
  			</div>
  			<div class="col-lg-5">
  				<div class="card-body" align="left">
  					<table class="table table-borderless">
  						<tr>
  							<td>요구사항</td>
  							<td rowspan="7"><textarea class="form-control" rows="7" id="msg" name="msg">${rsv.msg }</textarea></td>
  						</tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
     				</table>
  					
     			</div>
     		</div>
     		</div>
     	</div>
  	</div>
  	<div align="center" class="mt-5">
		<button type="button" class="btn btn-info" id="btnRsvUpdate">예약변경</button>
		<button type="button" class="btn btn-danger" id="btnRsvCancel">예약취소</button>
	</div>
</div>


<script>
/* 예약변경 */
$("#btnRsvUpdate").click(function() {
	var dataParam = {
		"id" : ${rsv.id},
		"peopleCnt" : $("#peopleCnt").val(),
		"rsvDate" : $("#rsvDate").val(),
		"rsvTime" : $("#rsvTime").val(),
		"msg" : $("#msg").val()
	}
	$.ajax({
		type : "put",
		url : "/user/reservationUpdate",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(dataParam)
	})
	.done(function(resp) {
		if(resp=="success") {
			alert("예약 변경 되었습니다!")
			location.href="/user/reservationList/${rsv.user.id}"
		} 
	})
	.fail(function(e) {
		alert("오류 : " + e)
	})
})

/* 예약취소 */
$("#btnRsvCancel").click(function() {
	$.ajax({
		type : "delete",
		url : "/user/reservationCancel/${rsv.id}"
	})
	.done(function(resp) {
		alert("예약 취소 되었습니다")
		location.href="/user/reservationList/${rsv.user.id}"
	})
	.fail(function(e) {
		alert("오류 : " + e)
	})
})
/* 현재 date로 restaurant 정보와 비교*/
	var date = new Date();
	var nowTime = "";
	if(date.getHours() < 10) {
		nowTime += "0" + date.getHours()+ ":";
	}else {
		nowTime += date.getHours() + ":";
	}
	if(date.getMinutes() < 10){
		nowTime += "0" + date.getMinutes();
	}else {
		nowTime += date.getMinutes();
	}
	var openTime = "${rsv.restaurant.openTime}";
	var rsvTime = "${rsv.restaurant.rsvTime}";
	var defTime = openTime;  //식당 여는 시각을 기본값으로 줌.
	var configDate = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate(); //현재 날짜
	if(nowTime >= rsvTime){ //현재 시각이 예약 가능 시각 이후라면 예약 가능 날짜를 다음날로 미룸.
		configDate = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + (date.getDate() + 1);
	}
var setting = function(){
	var nowDateString = date.getFullYear() + "-";
	if(date.getMonth() + 1 < 10){
		nowDateString += "0" + (date.getMonth() + 1);
	} else {
		nowDateString += (date.getMonth() + 1) + "-";
	}
	if(date.getDate() < 10){
		nowDateString += "0" + date.getDate();
	}else {
		nowDateString += date.getDate();
	}
	if(nowDateString == $("#rsvDate").val() || $("#rsvDate").val() == ""){ //날짜에서 오늘 날짜를 골랐으면,
	if(nowTime < openTime){ //현재 시각이 오픈타임 이전이면
		defTime = openTime; //defTime을 현재 시각으로.
	}
	else { //현재 시각이 오픈타임 이후라면
		var hour = date.getHours();
		var min = parseInt(date.getMinutes() / 30);
		if(min){ //30분 이상이면 1시간 더하고 분은 0으로, 미만이면 분을 30으로.
			hour += 1;
			min = "00";
		} else {
			min = "30";
		}
		if(hour == 24) {
			hour = "00";
		}
		defTime = (hour + ":" + min);
	}
	} else {
		defTime = openTime;
	}
}
setting();
/* 설정 */
const config = {
	dateFormat: 'yy-mm-dd',
	showOn : "button",
	buttonText:"날짜 선택",
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dayNames: ['일','월','화','수','목','금','토'],
	dayNamesShort: ['일','월','화','수','목','금','토'],
	dayNamesMin: ['일','월','화','수','목','금','토'],
	yearSuffix: '년',
	altField : "#rsvDate",
	altFormat : "yy-mm-dd",
	minDate : 0,
	defaultDate : '<fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/>',
    onSelect : function(dateText,inst){
    	setting();
    	$("#rsvTime").val(defTime);
    	$(".timepicker").timepicker('option','minTime',defTime);
// 	    	$(".timepicker").timepicker('option','defaultTime',defTime);
    	$(".timepicker").timepicker('option','startTime',defTime);
    	}
}	
/* 캘린더 */
$(function() {
	$("#datepicker").datepicker(config);
});

$(document).ready(function(){
	$('input.timepicker').timepicker({});
});

$('.timepicker').timepicker({
	timeFormat: 'HH:mm',
	interval: 30,
	minTime: defTime,
	maxTime: '${rsv.restaurant.rsvTime}',
	defaultTime: '<fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/>',
	startTime: defTime,
	dynamic: false,
	dropdown: true,
	scrollbar: true
});
</script>