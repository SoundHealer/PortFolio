<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.DAO.*"%>
<%@ page import="DB.Data.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- jQuery 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<script src="resource/js/signup.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="resource/css/styles1.css">

<script src="resource/js/admin.js"></script>

<!-- 기존 CSS 스타일 시트 링크 -->
<script type="text/javascript">
		
		var userId = '<%=session.getAttribute("userId")%>';
	if (userId != 'admin') {
		alert("잘못된 접근입니다.");
		location.href = "main.jsp";
	}
</script>
<style>
.table-container {
	width: 100%; /* 원하는 너비로 컨테이너 너비 설정 */
	height: 500px;
	overflow-y: auto;
	overflow-x: auto;
}

.table-container thead {
	position: sticky;
	top: 0; /* 머리글을 상단에 고정 */
	background-color: #f5f5f5; /* 머리글 배경색 설정 */
}

.mar-10 {
	margin: 10px;
}

table {
	width: 100%; /* 테이블의 너비를 100%로 설정 */
	border-collapse: collapse; /* 셀 테두리를 겹치도록 설정 */
}

thead {
	background-color: #f5f5f5; /* 헤더의 배경색 설정 (원하는 색상으로 변경 가능) */
}

th {
	text-align: left; /* 필요에 따라 헤더 셀의 텍스트 정렬을 조정합니다 */
	padding: 10px; /* 필요한 경우 헤더 셀에 패딩 추가 */
}

tbody {
	background-color: #ffffff; /* 본문의 배경색 설정 (원하는 색상으로 변경 가능) */
}

td {
	text-align: left; /* 필요에 따라 데이터 셀의 텍스트 정렬을 조정합니다 */
	padding: 10px; /* 필요한 경우 데이터 셀에 패딩 추가 */
}

.body_main {
	display: flex;
	justify-content: center; /* 가로 중앙 정렬을 위한 스타일 */
	align-items: center; /* 세로 중앙 정렬을 위한 스타일 */
	width: 90%; /* 화면 가로 너비를 80%로 설정 */
	margin: 10px auto;
	flex-wrap: wrap;
}

.title {
	margin: 10px 5% 10px 5%;
}
</style>
</head>
<body>
	<datalist id="genre">
		<option value="드라마" />
		<option value="첩보" />
		<option value="옴니버스" />
		<option value="뮤직" />
		<option value="동성애" />
		<option value="로드무비" />
		<option value="아동" />
		<option value="하이틴(고교)" />
		<option value="전기" />
		<option value="청춘영화" />
		<option value="재난" />
		<option value="문예" />
		<option value="연쇄극" />
		<option value="신파" />
		<option value="활극" />
		<option value="반공/분단" />
		<option value="군사" />
		<option value="계몽" />
		<option value="사회물(경향)" />
		<option value="스포츠" />
		<option value="합작(번안물)" />
		<option value="종교" />
		<option value="무협" />
		<option value="미스터리" />
		<option value="SF" />
		<option value="코메디" />
		<option value="느와르" />
		<option value="액션" />
		<option value="범죄" />
		<option value="어드벤처" />
		<option value="가족" />
		<option value="에로" />
		<option value="멜로/로맨스" />
		<option value="공포" />
		<option value="뮤지컬" />
		<option value="시대극/사극" />
		<option value="실험" />
		<option value="스릴러" />
		<option value="서부" />
		<option value="전쟁" />
		<option value="갱스터" />
		<option value="판타지" />
		<option value="해양액션" />
	</datalist>
	<!-- 모달 창 정의 -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="staticBackdropLabel"
		aria-hidden="false"
	>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">데이터 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="font-size: 8px;">
					<!-- 모달 내부에 수정할 데이터를 표시하고 입력 상자를 추가합니다 -->
					<div class="input-group mb-3">
						<span class="input-group-text my-span">아이디</span>
						<input type="text" id="userid" class="form-control" disabled="disabled">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">패스워드</span>
						<input type="text" id="userpw" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">이름</span>
						<input type="text" id="username" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">생년월일</span>
						<input type="text" id="birthday" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">이메일</span>
						<input type="email" id="email" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">거주지</span>
						<textarea id="userAddress" name="userAddress" class="form-control" aria-label="With textarea"
							disabled="disabled" style="background-color: #EEEEEE"
						></textarea>
						<button class="btn btn-outline-primary" type="button" id="addressSerchBtn">조회</button>
					</div>
					<div class="input-group mb-3">
						<label class="input-group-text" for="inputGroupSelect01">선호 장르</label>
						<div class="input-group">
							<input class="form-control" type="text" id="Genre_1" name="Genre_1" list="genre"
								placeholder="선로 장르 선택"
							>
							<input class="form-control" type="text" id="Genre_2" name="Genre_2" list="genre"
								placeholder="선로 장르 선택"
							>
						</div>
						<div class="input-group">
							<input class="form-control" type="text" id="Genre_3" name="Genre_3" list="genre"
								placeholder="선로 장르 선택"
							>
							<input class="form-control" type="text" id="Genre_4" name="Genre_4" list="genre"
								placeholder="선로 장르 선택"
							>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger deletebtn" data-bs-dismiss="modal">삭제</button>
					<button type="button" class="btn btn-primary save-button">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 로고 이미지 -->
	<header>
		<div id="top">
			<!-- 다운후 변경 -->
			<jsp:include page="loadFile/top.jsp" />
			<jsp:include page="loadFile/menuBar.jsp" />
		</div>
	</header>
	
	<body_main>
	<%
	DAO_UserDB userData = new DAO_UserDB();
	ArrayList<Data_User> userList = userData.loadUserDataList();
	int count = 0;
	for (Data_User data : userList) {
		if (!data.getId().equals("admin"))
			count++;
	}
	%>
	<div class="title">
		<h1>회원 관리</h1>
		<h3>
			전체 회원수 :
			<%=count%>명
		</h3>

		<div class="input-group mb-3" style="width: 100%;">
			<span class="input-group-text" id="inputGroup-sizing-default">리뷰 검색</span>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="filteruserid" placeholder="find">
				<label for="floatingInput">아이디</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findusername" placeholder="find">
				<label for="floatingInput">이름</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findemail" placeholder="find">
				<label for="floatingInput">이메일</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findgener" placeholder="find">
				<label for="floatingInput">선호장르</label>
			</div>
			<button type="button" id="filterResetBtn" class="btn btn-primary">검색 초기화</button>
		</div>
		<span id="findResult">
			검색결과 : <%=count%>개
		</span>
	</div>
	<div class="body_main">
		<div class="table-container">
			<table id="userInfoTable" class="table table-responsive table-hover">
				<thead>
					<tr>
						<th class="">아이디</th>
						<th class="">비밀번호</th>
						<th class="">이름</th>
						<th class="">생년월일</th>
						<th class="">이메일</th>
						<th class="">거주지</th>
						<th class="">선호장르1</th>
						<th class="">선호장르2</th>
						<th class="">선호장르3</th>
						<th class="">선호장르4</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Data_User data : userList) {
						if (!data.getId().equals("admin")) {
					%>
					<tr>
						<td><%=data.getId()%></td>
						<td><%=data.getPw()%></td>
						<td><%=data.getName()%></td>
						<td><%=data.getBirthday()%></td>
						<td><%=data.getEmail()%></td>
						<td><%=data.getAddress()%></td>
						<td><%=data.getGenre_1()%></td>
						<td><%=data.getGenre_2()%></td>
						<td><%=data.getGenre_3()%></td>
						<td><%=data.getGenre_4()%></td>
					</tr>
					<%
					count++;
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	</body_main>
	<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
	<script type="text/javascript">
	$(document).ready(function() {
	    var modal = $('#myModal');
	    var filterInputs = $('.filterText');
		var findtitleInput = $('#filteruserid');
		var finduseridInput = $('#findusername');
		var findscoreInput = $('#findemail');
		var findreviewInput = $('#findgener');
		
	    var count = 0;
		filterInputs.each(function() {
		    $(this).on('input', function() {
		        // 각 필터 입력 상자의 값을 가져옴
		        //filteruserid findusername findemail findgener
		        var findtitleText = findtitleInput.val().toLowerCase();
		        var finduseridText = finduseridInput.val().toLowerCase();
		        var findscoreText = findscoreInput.val().toLowerCase();
		        var findreviewText = findreviewInput.val().toLowerCase();
		        count = 0;
		        $('.table tbody tr').each(function() {
		            var rowData_1 = $(this).find('td').eq(0).text().toLowerCase(); // 첫 번째 열 값
		            var rowData_2 = $(this).find('td').eq(2).text().toLowerCase(); // 두 번째 열 값
		            var rowData_3 = $(this).find('td').eq(4).text().toLowerCase(); // 세 번째 열 값
		            var rowData_4_1 = $(this).find('td').eq(6).text().toLowerCase(); // 네 번째 열 값
		            var rowData_4_2 = $(this).find('td').eq(7).text().toLowerCase(); // 네 번째 열 값
		            var rowData_4_3 = $(this).find('td').eq(8).text().toLowerCase(); // 네 번째 열 값
		            var rowData_4_4 = $(this).find('td').eq(9).text().toLowerCase(); // 네 번째 열 값	
		
		            if (rowData_1.indexOf(findtitleText) !== -1 && rowData_2.indexOf(finduseridText) !== -1 &&
		                rowData_3.indexOf(findscoreText) !== -1 && 
		                (rowData_4_1.indexOf(findreviewText) !== -1 || rowData_4_2.indexOf(findreviewText) !== -1 || rowData_4_3.indexOf(findreviewText) !== -1 || rowData_4_4.indexOf(findreviewText) !== -1)) {
		                $(this).show(); // 일치하는 경우 표시
		                count++;
		            } else {
		                $(this).hide(); // 일치하지 않는 경우 숨김
		            }
		        });
		        updateDisplayedRowCount();
		    });
		    
		});
		function updateDisplayedRowCount() {
			//alert("updateDisplayedRowCount");
		    var displayedRowCount = $('.table tbody tr:visible').length;
		    var displayedRowCountElement = document.getElementById("findResult");
		    displayedRowCountElement.textContent = "검색 결과 : " + displayedRowCount;
		}

		// 페이지 로딩 시나 필터가 변경될 때마다 호출하여 업데이트
		
		var filterBtn = document.getElementById('filterResetBtn')

		filterBtn.addEventListener("click", filterReset);
		
		function filterReset(){
			//alert("필터 초기화");
			findtitleInput.val("");
			finduseridInput.val("");
			findscoreInput.val("");
			findreviewInput.val("");
			$('.table tbody tr').show();
			updateDisplayedRowCount();
		}
	    
	    $('.table tbody tr').click(function() {
	    	
	        var rowData = $(this).find('td');
	        modal.find('#userid').val(rowData.eq(0).text());
	        modal.find('#userpw').val(rowData.eq(1).text());
	        modal.find('#username').val(rowData.eq(2).text());
	        modal.find('#birthday').val(rowData.eq(3).text());
	        modal.find('#email').val(rowData.eq(4).text());
	        modal.find('#userAddress').val(rowData.eq(5).text());
	        modal.find('#Genre_1').val(rowData.eq(6).text());
	        modal.find('#Genre_2').val(rowData.eq(7).text());
	        modal.find('#Genre_3').val(rowData.eq(8).text());
	        modal.find('#Genre_4').val(rowData.eq(9).text());
	        modal.modal('show');
	       
	    });

	    // 모달 내의 '저장' 버튼을 클릭할 때 수정된 데이터를 테이블에 적용하는 코드를 추가합니다.
	    $('.save-button').click(function() {
	        var data_1 = modal.find('#userid').val();
	        var data_2 = modal.find('#userpw').val();
	        var data_3 = modal.find('#username').val();
	        var data_4 = modal.find('#birthday').val();
	        var data_5 = modal.find('#email').val();
	        var data_6 = modal.find('#userAddress').val();
	        var data_7 = modal.find('#Genre_1').val();
	        var data_8 = modal.find('#Genre_2').val();
	        var data_9 = modal.find('#Genre_3').val();
	        var data_10 = modal.find('#Genre_4').val();

	        var selectedRow = $('.table tr.active');
	        selectedRow.find('td').eq(0).text(data_1);
	        selectedRow.find('td').eq(1).text(data_2);
	        selectedRow.find('td').eq(2).text(data_3);
	        selectedRow.find('td').eq(3).text(data_4);
	        selectedRow.find('td').eq(4).text(data_5);
	        selectedRow.find('td').eq(5).text(data_6);
	        selectedRow.find('td').eq(6).text(data_7);
	        selectedRow.find('td').eq(7).text(data_8);
	        selectedRow.find('td').eq(8).text(data_9);
	        selectedRow.find('td').eq(9).text(data_10);

	        modal.modal('hide');
	        //alert("저장버튼 실행1");
	        admin_F("user","update");
	        //admin_F("user","delete");
	        //alert("저장버튼 실행2");
	        
	    });

	    $('.deletebtn').click(function() {
	    	admin_F("user","delete");
	        modal.modal('hide');
	    });

	    // 테이블 행 클릭 시 선택한 행에 'active' 클래스를 추가하여 하이라이트 효과를 줍니다.
	    $('.table tbody tr').click(function() {
	        $('.table tbody tr').removeClass('active');
	        $(this).addClass('active');
	    });

	    // 검색어 입력 상자의 내용이 변경될 때 테이블을 필터링합니다.
	    filterInput.on('input', function() {
	        var filterText = filterInput.val().toLowerCase();
	        $('.table tbody tr').each(function() {
	            var rowData_1 = $(this).find('td').eq(0).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_2 = $(this).find('td').eq(1).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_3 = $(this).find('td').eq(2).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_4 = $(this).find('td').eq(3).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_5 = $(this).find('td').eq(4).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_6 = $(this).find('td').eq(5).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_7 = $(this).find('td').eq(6).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_8 = $(this).find('td').eq(7).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_9 = $(this).find('td').eq(8).text().toLowerCase(); // 첫 번째 열 값
	            var rowData_10 = $(this).find('td').eq(9).text().toLowerCase(); // 첫 번째 열 값
	            if (rowData_1.indexOf(filterText) !== -1 || 
	            		rowData_2.indexOf(filterText) !== -1 || 
	            		rowData_3.indexOf(filterText) !== -1 || 
	            		rowData_4.indexOf(filterText) !== -1 || 
	            		rowData_5.indexOf(filterText) !== -1 || 
	            		rowData_6.indexOf(filterText) !== -1 || 
	            		rowData_7.indexOf(filterText) !== -1 || 
	            		rowData_8.indexOf(filterText) !== -1 || 
	            		rowData_9.indexOf(filterText) !== -1 || 
	            		rowData_10.indexOf(filterText) !== -1 ) {
	                $(this).show(); // 일치하는 경우 표시
	                
	            } else {
	                $(this).hide(); // 일치하지 않는 경우 숨김
	            
	        	}
	        });
	    });

	    modal.on('hidden.bs.modal', function() {
	        $(this).find('.inputTextData').val(''); // 입력 상자를 비우기
	    });
	    
	    
	    $('#myModal').on('shown.bs.modal', function () {
	        var spans = $(this).find('.my-span'); // 모달 내의 my-span 클래스 요소를 선택합니다.

	        // 최대 넓이를 초기값으로 설정합니다.
	        var maxWidth = 0;

	        // 모든 span 요소의 넓이를 비교하여 최대 넓이를 찾습니다.
	        spans.each(function() {
	            var spanWidth = $(this).width();
	            if (spanWidth > maxWidth) {
	                maxWidth = spanWidth;
	            }
	        });

	        // 최대 넓이를 가진 span 요소의 넓이를 모든 span 요소에 설정합니다.
	        spans.width(maxWidth);
	        
	    });
	    var button = document.getElementById('addressSerchBtn')
	    
        button.addEventListener("click", sample4_execDaumPostcode);
	    
	    function sample4_execDaumPostcode() {
	    	//alert("execDaumPostcode");
			new daum.Postcode(
				{
					oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					document.getElementById("userAddress").value = data.roadAddress;
				}
			}).open();
		}
	});
	</script>

</body>
</html>