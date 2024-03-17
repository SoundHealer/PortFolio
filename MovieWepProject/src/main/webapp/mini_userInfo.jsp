<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script src="resource/js/signin.js"></script>
<style>
.mini-login-container {

	padding: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-wrap: wrap;
}
</style>
<%
// 세션에서 값을 가져옵니다.
String userId = (String) session.getAttribute("userId");
%>
<div class="mini-login-container" id="login">
	<%
	if (userId != null) {//로그인상태
	%>
	<div id="info">
		<label>
			ID :
			<%=userId%>
		</label>
	</div>
	<div id="logoutBtn">
	<input type="button" value="로그아웃" onclick="trySignOut('<%=userId%>')">
	</div>
	<%
	} else {//로그아웃상태
	%>
	<form id="signinForm" name="signinForm" method="post" action="main.jsp"
		onsubmit="return trySignIn()">
		<div style="display: flex;">
			<div class="mini-login-text-box">
				<input type="text" id="userId" name="userId" placeholder="ID"
					style="width: 100%; margin: auto;">
				<input type="password" id="userPw" name="userPw" placeholder="Password" style="width: 100%">
			</div>
			<button id="login-btn" type="submit" class="btn btn-primary"
				style="width: 60px; height: 60px; font-size: 15px;">Login</button>
		</div>
	</form>
	<div class="col-sm login-help-text" style="margin-top: 10px;">
		<a href="signup.jsp" class="">회원가입</a>
		/
		<a href="#" class="">비밀번호 찾기</a>
	</div>
	<%
	}
	%>
</div>
