<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>동적 데이터리스트</title>
</head>
<body>
	<input type="text" class="emailList" list="email_List" id="email_1">
	<input type="text" class="dataList" list="genre_List" id="email_2">
	<br><br><br>
	<input type="text" class="dataList" list="genre_List" id="genre_1">
	<input type="text" class="dataList" list="genre_List" id="genre_2">
	
	<button onclick="addOption()">추가</button>
	<button onclick="removeOption()">삭제</button>
	
	<datalist id="email_List"></datalist>
	<datalist id="genre_List"></datalist>
	<script>
		// 배열을 생성하고 초기 데이터 리스트를 설정
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
			$(".dataList").on("focus", function() {
				var $this = $(this);
				var allElements = $(".dataList").not($this); // 현재 포커스된 요소를 제외한 다른 요소들
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
		});
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
		
	</script>
</body>
</html>
