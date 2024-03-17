<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<div class="starDiv">
<%
String count = request.getParameter("no");
String score = request.getParameter("score");
String activate = request.getParameter("activate");
String disabled = (activate.equals("f"))? "disabled" : "";
%>
	<img id="star_gray_<%=count%>" class="review_star_score" src="resource\images\star_gray.png" alt="이미지">
	<img id="star_color_<%=count%>" class="review_star_score review_star_color" src="resource\images\star_color.png" alt="이미지">
	
	<input type="range" id="rangeInput_<%=count%>" name="star_color_<%=count%>" class="review_star_score review_rangeInput" min="0" max="10" value="<%=score%>" step="1" <%=disabled%>>
</div>

</html>
