<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="DB.DAO.*,DB.Data.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/css/styles1.css" type="text/css">
<script src="resource/js/signin.js"></script>
<script src="resource/js/signup.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%
String parm_type = request.getParameter("type");
parm_type = parm_type.equals("load") ? "load" : "insert";

Object sessionObj = session.getAttribute("userId");
String sessionId = sessionObj == null ? "" : (String) sessionObj;

DAO_UserDB userDB = new DAO_UserDB();

Data_User userData = userDB.loadUserData(sessionId);

String pram_userName = userDB.setData(parm_type, userData.getName());

String pram_userId = userDB.setData(parm_type, userData.getId());
String pram_userPw = userDB.setData(parm_type, userData.getPw());

String pram_email = userDB.setData(parm_type, userData.getEmail());
String[] email = {"", ""};
if (!pram_email.equals("")) {
	email = pram_email.split("@");
}
String pram_birthDay = userDB.setData(parm_type, userData.getBirthday().toString());

String pram_adress = userDB.setData(parm_type, userData.getAddress());

String pram_genre_1 = userDB.setData(parm_type, userData.getGenre_1());
String pram_genre_2 = userDB.setData(parm_type, userData.getGenre_2());
String pram_genre_3 = userDB.setData(parm_type, userData.getGenre_3());
String pram_genre_4 = userDB.setData(parm_type, userData.getGenre_4());
%>
<script type="text/javascript">
	var parm_type = '<%=parm_type%>';

	function sample4_execDaumPostcode() {
		new daum.Postcode( {
				oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				document.getElementById("userAddress").value = data.roadAddress;
			}
		}).open();
	}

</script>
<datalist id="email_List">
	<option value="직접입력" />
	<option value="naver.com" />
	<option value="gmail.com" />
	<option value="daum.net" />
	<option value="hanmail.net" />
	<option value="hotmail.com" />
	<option value="korea.com" />
	<option value="yahoo.com" />
	<option value="nate.com" />
</datalist>
<datalist id="genre_List">
</datalist>
<div class="myInfoBox-60">
	<h1 id="noMargin">내 정보</h1>
	<form id="userInfoForm" name="userInfoForm" method="post" action="main.jsp"
		onsubmit="return checkUserInfoLoad()"
	>
		<!-- userInfoEdit() -->
		<!--request.getRequestURI()I() %> -->
		<!-- 
			pram_userName
			pram_userId
			pram_email
			pram_birthDay
			pram_adress
			pram_genre_1
			 -->
		<div class="mar-tb-10">
			<!-- 이름 userName -->
			<label for="userName">이름</label>
			<input type="text" id="userName" name="userName" class="form-control" value="<%=pram_userName%>"
				required
			>
		</div>
		<div class="mar-tb-10">
			<!-- 아이디 userId -->
			<label>아이디</label>
			<input type="text" id="userId" name="userId" class="form-control" value="<%=pram_userId%>"
				required
			<%=parm_type.equals("load") ? "disabled='disabled'" : ""%>'
			>
		</div>
		<div class="password">
			<div class="mar-tb-10">
				<label>패스워드</label>
				<input type="password" id="userPw" name="userPw" class="form-control" value="<%=pram_userPw%>">
			</div>
			<div class="mar-tb-10">
				<label>패스워드 확인</label>
				<input type="password" id="checkPassword" name="checkPassword" class="form-control"
					value="<%=pram_userPw%>"
				><span id="passwordGuide" style="color: red; display: none;"> </span>
			</div>
		</div>
		<div class="mar-tb-10">
			<!-- 이메일 userEmail_1 userEmail_2 -->
			<label>이메일</label>
			<br>
			<div class="input-group">
				<input id="userEmail_1" type="text" class="form-control" placeholder="Username"
					aria-label="Username" value="<%=email[0]%>" required
				>
				<span class="input-group-text">@</span>
				<input id="userEmail_2" type="text" class="form-control" list="email_List"
					placeholder="email 선택" aria-label="email 선택" value="<%=email[1]%>" required
				>
			</div>
		</div>
		<div class="input-group">
			<!-- 생일 birthDay -->
			<label for="birthDay">생년월일</label>
			<br>
			<jsp:include page="selectDate.jsp">
				<jsp:param name="param_date" value="<%=pram_birthDay%>" />
			</jsp:include>
		</div>
		<div class="input-group mar-tb-10">
			<!-- 주소 userAddress -->
			<label>주소</label>
			<div class="input-group mar-bot-10">
				<textarea type="text" id="userAddress" class="form-control" placeholder="거주지 입력"
					disabled="disabled"
				><%=pram_adress%></textarea>
				<button class="btn btn-outline-secondary" type="button" onclick="sample4_execDaumPostcode()">주소
					검색</button>
			</div>
		</div>
		<div class="mar-tb-10">
			<!-- 장르 Genre_1 Genre_2 Genre_3 Genre_4 -->
			<label>선호 장르</label>
			<div class="input-group">
				<input type="text" id="Genre_1" class="genreList form-control" list="genre_List"
					placeholder="선호 장르 선택" value="<%=pram_genre_1%>"
				>
				<input type="text" id="Genre_2" class="genreList form-control" list="genre_List"
					placeholder="선호 장르 선택" value="<%=pram_genre_2%>"
				>
			</div>
			<div class="input-group">
				<input type="text" id="Genre_3" class="genreList form-control" list="genre_List"
					placeholder="선호 장르 선택" value="<%=pram_genre_3%>"
				>
				<input type="text" id="Genre_4" class="genreList form-control" list="genre_List"
					placeholder="선호 장르 선택" value="<%=pram_genre_4%>"
				>
			</div>
		</div>
		<div style="display: flex; width: 100%; flex-direction: row-reverse;">
			<button id="login-btn" type="submit" onsubmit="checkUserInfoLoad" class="btn btn-primary"
				style="margin: 10px auto; margin-right: 0px;">
				<h5>저장</h5>
			</button>
		</div>
	</form>
</div>
<script type="text/javascript">
	
	var email = [];
	email.push("직접입력");
	email.push("naver.com");
	email.push("gmail.com");
	email.push("kakao.com");
	email.push("hanmail.net");
	email.push("daum.net");
	email.push("hotmail.com");
	email.push("korea.com");
	email.push("yahoo.com");
	email.push("nate.com");

	var genre = [];
	genre.push("드라마");
	genre.push("첩보");
	genre.push("옴니버스");
	genre.push("뮤직");
	genre.push("동성애");
	genre.push("로드무비");
	genre.push("아동");
	genre.push("하이틴(고교)");
	genre.push("전기");
	genre.push("청춘영화");
	genre.push("재난");
	genre.push("문예");
	genre.push("연쇄극");
	genre.push("신파");
	genre.push("활극");
	genre.push("반공/분단");
	genre.push("군사");
	genre.push("계몽");
	genre.push("사회물(경향)");
	genre.push("스포츠");
	genre.push("합작(번안물)");
	genre.push("종교");
	genre.push("무협");
	genre.push("미스터리");
	genre.push("SF");
	genre.push("코메디");
	genre.push("느와르");
	genre.push("액션");
	genre.push("범죄");
	genre.push("어드벤처");
	genre.push("가족");
	genre.push("에로");
	genre.push("멜로/로맨스");
	genre.push("공포");
	genre.push("뮤지컬");
	genre.push("시대극/사극");
	genre.push("실험");
	genre.push("스릴러");
	genre.push("서부");
	genre.push("전쟁");
	genre.push("갱스터");
	genre.push("판타지");
	genre.push("해양액션");

	
	$(document).ready(function() {
		$(".genreList").on("focus", function() {
			var $this = $(this);
			var allElements = $(".genreList").not($this); // 현재 포커스된 요소를 제외한 다른 요소들
			var list_1 = genre;
			var list_2 = [];
			allElements.each(function() {
				var otherValue = $(this).val();
				var listName = $(this).attr('list');
				list_2.push(otherValue);
				
				var difference = list_1.filter(otherValue => !list_2.includes(otherValue));
				
				//console.log(difference);

				updateDataList(listName,difference);
			});
			
		});
		/*
		$("#login-btn").on("click", function() {
			//alert("");
			//console.log("값 출력 전");
			//console.log($("#year").val());
			//console.log("값 출력 후");
			var year = $("#year").val();
			var month = $("#month").val();
			var day = $("#day").val();
		});*/
	});
	
	function checkUserInfoLoad(){
		//alert("checkUserInfoLoad");
		console.log("checkUserInfoLoad");
		var year = $("#year").val();
		var month = $("#month").val();
		var day = $("#day").val();
		//alert(year +"-"+ month +"-"+ day);
		//return false;
		if(parm_type == 'load' || parm_type == "load"){
			//alert("userInfoEdit_F");
			return userInfoEdit_F(year,month,day);
		} else {
			//alert("checkSignUpDataJsFile");
			return checkSignUpDataJsFile(year,month,day);
		}
		
	}
	
	function updateDataList(dataListName,arr) {
		console.log(dataListName);
		var dataList = document.getElementById(dataListName);
		dataList.innerHTML = "";
		
		arr.forEach(function(option) {
			var optionElement = document.createElement("option");
			optionElement.value = option;
			dataList.appendChild(optionElement);
		});
	}
	
	document.getElementById('userPw').addEventListener('input',
			checkPassword_f);
	document.getElementById('checkPassword').addEventListener('input',
			checkPassword_f);
	</script>
</html>