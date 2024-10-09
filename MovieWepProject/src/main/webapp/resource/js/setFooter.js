$(document).ready(function() {
	//setFooterLocation();
	allHeight();
});
function setFooterLocation() {
	var htmlyHeight = Number($('html').css('height').split("p")[0]);
	var bodyHeight = Number($('body').css('height').split("p")[0]);

	var headerHeight = Number($('body').find('header').css('height').split("p")[0]);
	var mainHeight = Number($('body').find('body_main').css('height')
			.split("p")[0]);
	var footerHeight = Number($('body').find('footer').css('height').split("p")[0]);

	var blank = bodyHeight - (headerHeight + mainHeight + footerHeight);
	if (blank > 1) {
		console.log("bodyHeight : " + bodyHeight + "px");
		console.log("headerHeight : " + headerHeight + "px");
		console.log("mainHeight : " + mainHeight + "px");
		console.log("footerHeight : " + footerHeight + "px");
		console.log("높이 설정" + (mainHeight + blank) + "px");
		$('body').find('body_main').css('height', (mainHeight + blank) + "px");
		$('body').find('footer').css('position','absolute');
		$('body').find('footer').css('bottom','0');
	}else{
		console.log("높이 설정 안함");
	}

}

function allHeight() {
	var body = $('body')
	var main = $('main')
	var bodyHeight = body.outerHeight();
	var mainHeight = main.outerHeight();

	console.log("bodyHeight : " + bodyHeight);
	console.log("mainHeight : " + mainHeight);
	if(bodyHeight > mainHeight){
		$('body').find('footer').css('position','absolute');
		$('body').find('footer').css('bottom','0');
	}
}