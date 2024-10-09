<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String score = request.getParameter("score");
int scoreValue = 0;
if (score != null) {
	scoreValue = Integer.parseInt(score);
}

// 이미지의 가로 위치와 클리핑 영역을 설정
%>

	<div class="review_score_img">
		<img class="start_img_gray" src="resource\images\star_gray.png" alt="이미지">
		<img class="start_img_color" src="resource\images\star_color.png" alt="이미지"
			data-score=<%=scoreValue%>
		>
		<p class="review_score_int"> <%=scoreValue%></p>
	</div>

</html>
