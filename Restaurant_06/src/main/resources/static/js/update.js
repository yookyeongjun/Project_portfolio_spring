






$("#btnReservation").click(function() {
	location.href="reservation"
})
var show = function(divId){
	document.getElementById("menuResult").style.display = "none";
	document.getElementById("descriptionResult").style.display = "none";
	document.getElementById("commentResult").style.display = "none";
	document.getElementById(divId).style.display = "block";
}
