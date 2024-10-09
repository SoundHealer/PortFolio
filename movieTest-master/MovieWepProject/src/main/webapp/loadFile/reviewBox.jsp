<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String sessionId = request.getParameter("sessionId");
	String no = request.getParameter("no");
	String director = request.getParameter("director").trim();
	String title = request.getParameter("title").trim();
	String userid = request.getParameter("userid");
	String score = request.getParameter("score");
	String review = request.getParameter("review").trim();
	String date = request.getParameter("date");
	String isMyReview = (sessionId != null && !sessionId.equals("null") && !sessionId.trim().equals("")
			&& !sessionId.isEmpty() && sessionId.equals(userid)) ? "t" : "f";

	System.out.println(sessionId);
	System.out.println(no);
	System.out.println(director);
	System.out.println(title);
	System.out.println(userid);
	System.out.println(score);
	System.out.println(review);
	
	if (userid.equals("_")) {
	%>
	<div class="review_text-box" style="display: flex; align-items: center; justify-content: center;">
		<button id="login-btn" type="submit" class="btn btn-primary" style="font-size: 25px;"
			onclick="location.href='signin.jsp'">로그인</button>
	</div>
	<%
	} else {
	%>
	<div class="review_text-box">
		<input id="<%=no%>_no" type="hidden" value=<%=no%>>
		<input id="<%=no%>_title" type="hidden" value="<%=title%>">
		<input id="<%=no%>_director" type="hidden" value="<%=director%>">
		<input id="<%=no%>_userid" type="hidden" value="<%=userid%>">
		<a href="MovieDetailTest.jsp?title=<%=title%>&director=<%=director%>">
			<output></output>
			<label id="<%=no%>_movie_title" class="review_title"><%=title%></label>
		</a>
		<div>
			<div class="score">
				<jsp:include page="star.jsp">
					<jsp:param name="count" value="<%=no%>" />
					<jsp:param name="score" value="<%=score%>" />
					<jsp:param name="activate" value="<%=isMyReview%>" />
				</jsp:include>
			</div>
			<label id="<%=no%>_userid" class="userid"><%=userid%></label>
		</div>
		<textarea class="review" id="<%=no%>_review"><%=review%></textarea>
		<%
		if (isMyReview.equals("t")) {
		%>
		<input id="<%=no%>_de" class="trbtn_de" type="button" onclick="checkSignUpData()" value="삭제"
			style="background: red;">
		<input id="<%=no%>" class="trbtn" type="button" onclick="checkSignUpData()" value="저장">
		<%
		}
		}
		%>
	</div>
	<script type="text/javascript">
		function onSubmitBtn() {
			//var title = document.getElementById("movie_title");
			var no = event.target.id;
			var number = "번호: " + document.getElementById(no + "_no").value
			var title = "제목: " + document.getElementById(no + "_title").value
			var director = "감독: "
					+ document.getElementById(no + "_director").value
			var review = "리뷰: " + document.getElementById(no + "_review").value
			var score = "점수: "
					+ document.getElementById("rangeInput_" + no).value
			//alert(title)
			alert(number + "\n" + title + "\n" + director + "\n" + review
					+ "\n" + score);
		}

		function checkSignUpData() {

			var no = event.target.id;
			//const str = 'Hello, World, Javascript';
			var fun = "update";

			//alert(no.endsWith('de'));

			if (no.endsWith('de')) {
				no = no.split("_")[0];
				fun = "del";
			}

			//alert("아이디 : " + no);
			var number = document.getElementById(no + "_no").value

			//alert(number);

			var title = document.getElementById(no + "_title").value
			//alert(title);
			var director = document.getElementById(no + "_director").value
			//alert(director);
			var review = document.getElementById(no + "_review").value
			//alert(review);
			var score = document.getElementById("rangeInput_" + no).value
			//alert("점수 : " + score);

			var jsid = document.getElementById(no + "_userid").value


			var errorMessages = "";
			var data = {
				"fun" : fun,
				"number" : number,
				"title" : title,
				"userid" : jsid,
				"director" : director,
				"review" : review,
				"score" : score
			};

			//alert(data);
			var result = -1;
			$.ajax({
				type : "POST",
				url : "ReviewUpdate", // 서블릿 경로
				data : JSON.stringify(data), // JSON 형식으로 데이터 전송
				contentType : "application/json",
				async : false,
				success : function(response) {
					// 서버로부터의 응답 처리
					result = response.message;

					//alert(response.message + ":" + (result == 1)); // 서버의 응답 메시지 출력
				}
			});
			if (fun == "update") {
				if (result == 0) {
					alert("리뷰 저장");
				} else if (result == 1) {
					alert("리뷰 저장 실패");
					return false;
				} else {
					alert("리뷰 저장 에러.");
					return false;
				}
			} else {
				if (result == 0) {
					alert("리뷰 삭제");
				} else if (result == 1) {
					alert("리뷰가 없음");
					return false;
				} else {
					alert("리뷰 삭제 에러.");
					return false;
				}
			}
			// DB등록
			location.reload();
			return true; // 유효성 검사 통과
		}
	</script>
</body>
</html>