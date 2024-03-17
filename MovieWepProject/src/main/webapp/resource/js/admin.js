function admin_F(pageType, doFun) {

	var errorMessages = "";

	var data = {
		"type" : pageType,
		"doFun" : doFun,
		"data_1" : getData(pageType, 0, doFun),
		"data_2" : getData(pageType, 1, doFun),
		"data_3" : getData(pageType, 2, doFun),
		"data_4" : getData(pageType, 3, doFun),
		"data_5" : getData(pageType, 4, doFun),
		"data_6" : getData(pageType, 5, doFun),
		"data_7" : getData(pageType, 6, doFun),
		"data_8" : getData(pageType, 7, doFun),
		"data_9" : getData(pageType, 8, doFun),
		"data_10" : getData(pageType, 9, doFun)
	};
	// alert();
	var result = -1;
	$.ajax({
		type : "POST",
		url : "adminServlet", // 서블릿 경로
		data : JSON.stringify(data), // JSON 형식으로 데이터 전송
		contentType : "application/json",
		async : false,
		success : function(response) {
			// 서버로부터의 응답 처리
			result = response.result;
			resultShow(pageType, doFun, result);
		}

	});
}

function resultShow(pageType, doFun, result) {
	// alert("resultShow" + pageType +","+doFun+","+result);
	var msg_1 = "";
	var msg_2 = "";
	var msg_3 = "";
	if (pageType == "user") {
		msg_1 = "회원정보가"
	} else if (pageType == "review") {
		msg_1 = "리뷰가"
	} else if (pageType == "cinema") {
		msg_1 = "영화관 정보가"
	} else {
		return;
	}
	if (doFun == "update") {
		msg_2 = "수정"
	} else if (doFun == "delete") {
		msg_2 = "삭제"
	} else if (doFun == "insert") {
		msg_2 = "추가"
	}

	if (result == 0) {
		msg_3 = "되었습니다."
	} else if (result == 1) {
		msg_3 = "되지 않았습니다."
	} else {
		alert("서버 통신중 문제가 발생했습니다." + result);
		return;
	}
	var mas = msg_1 + " 정상적으로 " + msg_2 + msg_3;
	alert(mas);
	if ((doFun == "delete" || doFun == "insert") && result == 0) {
		//alert("새로고침");
		location.reload();
	}
}

function getData(type, index, doFun) {
	var user = [ "userid", "userpw", "username", "birthday", "email",
			"userAddress", "Genre_1", "Genre_2", "Genre_3", "Genre_4" ];
	var review = [ "no", "DOCID", "reviewtitle", "userid", "score", "review",
			"registration_date" ];
	var cinema = [ "name", "address", "tel", "wep" ];
	var insertcinema = [ "insertname", "insertaddress", "inserttel",
			"insertwep" ];
	// name address tel wep
	if (type == "user") {
		if (index > user.length - 1) {
			return "";
		} else {
			return document.getElementById(user[index]).value;
		}
	} else if (type == "review") {
		if (index > review.length - 1) {
			return "";
		} else {
			return document.getElementById(review[index]).value;
		}
	} else if (type == "cinema") {
		if (index > cinema.length - 1) {
			return "";
		} else {
			if (doFun == "insert") {
				//alert("insertcinema : " + document.getElementById(insertcinema[index]).value);
				return document.getElementById(insertcinema[index]).value;
			} else {
				//alert("cinema : " + document.getElementById(cinema[index]).value);
				return document.getElementById(cinema[index]).value;
			}
		}
	} else {
		return "";
	}
}
