
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<%
request.setCharacterEncoding("UTF-8");
%>
<style>
.review_title {
	position: absolute;
	top: 5px;
	left: 10px;
	font-weight: bold;
	font-size: 20px;
}

.userid {
    font-weight: 500;
	position: absolute;
	top: 30px;
	left: 130px;
	font-size: 16px;
}

.score {
	position: absolute;
	top: 35px;
	left: 15px;
}

.scoreInt {
	position: absolute;
	left: 110px;
}

.review {
	position: absolute;
	top: 65px;
	left: 10px;
	right: 10px;
	bottom: 10px;
	padding: 5px;
	resize: none;
}

.trbtn {
	position: absolute;
	top: 10px;
	right: 10px;
	padding: 5px 10px;
	background-color: #0077FF;
	color: #fff;
	border: none;
	cursor: pointer;
}

.trbtn_de {
	
	position : absolute;
	top: 10px;
	right: 80px;
	padding: 5px 10px;
	background-color: #0077FF;
	color: #fff;
	border: none;
	cursor: pointer;
	position: absolute;
}

.review_text-box {
	position: relative;
	height: 150px;
	border: 1px solid #ccc;
	padding: 10px;
	min-width: 500px;
	margin-top: 10px;
}

.review_star_color {
	clip: rect(0, 0, 0, 0);
}

.review_star_score {
	position: absolute;
	width: 100px;
}

.review_rangeInput {
	opacity: 0;
}

.review_starDiv {
	opacity: 1;
}
</style>
</head>
<body>
	<div class="loopDivTest">
		<%
		DAO_ReviewDB cinemaAccess = new DAO_ReviewDB();
		Object useridObj = session.getAttribute("userId");
		String movieTitle = request.getParameter("title");
		String dName = request.getParameter("director");
		System.out.println(movieTitle == null);
		System.out.println(dName == null);

		String userid = "";
		if (useridObj != null) {
			userid = useridObj.toString();

		} else {
			userid = "_";
		}
		System.out.println("이름" + userid);
		ArrayList<Data_Review> reviewList = null;
		if (movieTitle != null && dName != null) {
			reviewList = cinemaAccess.getReviewList(userid, movieTitle, dName);
		} else {
			reviewList = cinemaAccess.getReviewList(userid);
		}
		System.out.println("반환 크기 : " + reviewList.size());
		if (reviewList != null && reviewList.size() > 0) {

			if (!reviewList.get(0).getUserid().equals(userid)) {
		%>
		<div class="review_data">
			<jsp:include page="reviewBox.jsp">
				<jsp:param name="sessionId" value="<%=userid%>" />
				<jsp:param name="no" value="-1" />
				<jsp:param name="director" value="<%=dName%>" />
				<jsp:param name="title" value="<%=movieTitle%>" />
				<jsp:param name="userid" value="<%=userid%>" />
				<jsp:param name="score" value="0" />
				<jsp:param name="review" value="" />
				<jsp:param name="date" value="<%=LocalDate.now()%>" />
			</jsp:include>
		</div>
		<%
		}

		for (Data_Review review : reviewList) {
		%>
		<div class="review_data">
			<jsp:include page="reviewBox.jsp">
				<jsp:param name="sessionId" value="<%=userid%>" />
				<jsp:param name="no" value="<%=review.getNo()%>" />
				<jsp:param name="director" value="<%=review.getDirector()%>" />
				<jsp:param name="title" value="<%=review.getTitle()%>" />
				<jsp:param name="userid" value="<%=review.getUserid()%>" />
				<jsp:param name="score" value="<%=review.getScore()%>" />
				<jsp:param name="review" value="<%=review.getReview()%>" />
				<jsp:param name="date" value="<%=review.getDate()%>" />
			</jsp:include>
		</div>
		<%
		}

		} else {
		//System.out.println("오브젝트" + useridObj==null);
		%>
		<div class="review_data">
			<jsp:include page="reviewBox.jsp">
				<jsp:param name="sessionId" value="<%=userid%>" />
				<jsp:param name="no" value="-1" />
				<jsp:param name="director" value="<%=dName%>" />
				<jsp:param name="title" value="<%=movieTitle%>" />
				<jsp:param name="userid" value="<%=userid%>" />
				<jsp:param name="score" value="0" />
				<jsp:param name="review" value="" />
				<jsp:param name="date" value="<%=LocalDate.now()%>" />
			</jsp:include>
		</div>
		<%
		}
		%>
	</div>
	<script>

		var rangeInputs = document.querySelectorAll(".review_star_score.review_rangeInput");

	    rangeInputs.forEach(function(input) {
	    	scoreSetting(input);
	    	<%if (userid != null && !userid.equals("null") && !userid.trim().equals("") && !userid.isEmpty()
		&& userid.equals(userid)) {%>
	    	//alert(input.id + " : 활성화");
	    	//document.getElementById(input.id).disabled = false;
			<%} else {%>
			//alert(input.id + " : 비활성화");
			//document.getElementById(input.id).disabled = false;
			<%}%>
	        input.addEventListener("input", setStar)
		});
	    
		function setStar(){
			var rangeValue = document.getElementById(event.target.id).value;
			
			var image = document.getElementById(event.target.name);
			var result = calculateWidthFromPercentage(rangeValue,image);

			var clipValue = "rect(0, " + result.width + ", " + result.height + ", 0)";
			
			image.style.clip = clipValue;
		}
		function scoreSetting(element){
	    	var rangeValue = document.getElementById(element.id).value;
			var image = document.getElementById(element.name);
			var result = calculateWidthFromPercentage(rangeValue,image);
			var clipValue = "rect(0, " + result.width + ", " + result.height + ", 0)";
			
			image.style.clip = clipValue;
		}
		
		function calculateWidthFromPercentage(value,img) {
			
			var height = parseInt(getComputedStyle(img).height) + "px";
			var currentWidth = parseFloat(getComputedStyle(img).width);

			var width = parseInt(currentWidth * (value / 10)) + "px";

			return {width, height};
		}
		window.onload = function(){
			//setStar();
		}

	</script>
</body>
</html>