
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
.text-box {
	position: relative;
	height: 150px;
	border: 1px solid #ccc;
	padding: 10px;
	min-width: 500px;
	margin-top: 10px;
}

.title {
	position: absolute;
	top: 10px;
	left: 10px;
	font-weight: bold;
}

.userid {
	position: absolute;
	top: 30px;
	left: 60px;
}

.score {
	position: absolute;
	top: 30px;
	left: 15px;
}

.review {
	position: absolute;
	top: 55px;
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

.top-right-button:hover {
	background-color: #0055CC;
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
			System.out.println("세션값" + userid);
		} else {
			userid = "_";
		}
		ArrayList<Data_Review> reviewList = null;
		if (movieTitle != null && dName != null) {
			reviewList = cinemaAccess.getReviewList(userid, movieTitle, dName);
		} else {
			reviewList = cinemaAccess.getReviewList(userid);
		}
		if (reviewList != null) {
			System.out.println("사이즈" + reviewList.size());

			if (reviewList.size() == 0) {
		%>
		<div class="text-box">
			<input type="hidden" id="no" value=<%=-1%>>
			<a href="MovieDetailTest.jsp?title=<%=movieTitle%>&director=<%=dName%>">
				<label class="title"><%=movieTitle%></label>
			</a>
			<label class="userid"><%=userid%></label>
			<label class="score">
				0 / 5
			</label>
			<textarea class="review" id="review"> <%=movieTitle%> </textarea>
			<input class="trbtn" type="submit" value="저장">
			<%

			%>
		</div>
		<%
		}
		boolean myReview = true;
		for (int i = 0; i < reviewList.size(); i++) {
		Data_Review review = reviewList.get(i);
		%>
		<div class="text-box">
			<input type="hidden" id="no" value=<%=review.getNo()%>>
			<a href="MovieDetailTest.jsp?title=<%=review.getTitle()%>&director=<%=review.getDirector()%>">
				<label class="title"><%=review.getTitle()%></label>
			</a>
			<label class="userid"><%=review.getUserid()%></label>
			<label class="score"><%=review.getScore()%>
				/ 5
			</label>
			<%
			if (review.getUserid().equals(userid)) {
				System.out.println("내 리뷰 있음");
				myReview = false;
			%>
			<textarea class="review" id="review"> <%=review.getReview()%> <%="\n"%> <%=movieTitle%> </textarea>
			<input class="trbtn" type="submit" value="저장">
			<%
			} else {
			if (myReview) {
				i = 0;
				myReview = false;
				System.out.println("내 리뷰 없음");
			%>
			<textarea class="review" id="review"> <%=review.getReview()%> <%="\n"%> <%=movieTitle%> </textarea>
			<input class="trbtn" type="submit" value="저장">
			<%
			}
			%>
			<textarea class="review" id="review" disabled style="background-color: white;"> <%=review.getReview()%> <%="\n"%> <%=movieTitle%> </textarea>
			<%
			}
			%>
		</div>
		<%
		}
		} else {
		%>
		<div class="text-box">list=null</div>
		<%
		}
		%>
	</div>
</body>
</html>