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
	table-layout:fixed;
}

.table-container thead {
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
width: 100%;
	background-color: #f5f5f5; /* 헤더의 배경색 설정 (원하는 색상으로 변경 가능) */
}

th {
	text-align: left; /* 필요에 따라 헤더 셀의 텍스트 정렬을 조정합니다 */
	padding: 10px; /* 필요한 경우 헤더 셀에 패딩 추가 */
}

tbody {
width: 100%;
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
	<main>
	<!-- 모달 창 정의 -->
	<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="staticBackdropLabel"
		aria-hidden="false"
	>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">영화관 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="font-size: 8px;">
					<!-- "no", "DOCID", "title", "userid", "score", "review", "registration_date" -->
					<!-- 모달 내부에 수정할 데이터를 표시하고 입력 상자를 추가합니다 -->
					<div class="input-group mb-3">
						<span class="input-group-text my-span">이름</span>
						<input type="text" id="insertname" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">주소</span>
						<textarea id="insertaddress" name="address" class="form-control" aria-label="With textarea"
							disabled="disabled"
						></textarea>
						<button class="btn btn-outline-primary" type="button" id="addressSerchBtn">조회</button>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">전화번호</span>
						<input type="text" id="inserttel" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">홈페이지</span>
						<input type="text" id="insertwep" class="form-control">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary insert-button">저장</button>
				</div>
			</div>
		</div>
	</div>
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
					<!-- "no", "DOCID", "title", "userid", "score", "review", "registration_date" -->
					<!-- 모달 내부에 수정할 데이터를 표시하고 입력 상자를 추가합니다 -->
					<div class="input-group mb-3">
						<span class="input-group-text my-span">이름</span>
						<input type="text" id="name" class="form-control" disabled="disabled">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">주소</span>
						<textarea id="address" name="address" class="form-control" aria-label="With textarea"
							disabled="disabled"
						></textarea>
						<button class="btn btn-outline-primary" type="button" id="addressSerchBtn">조회</button>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">전화번호</span>
						<input type="text" id="tel" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text my-span">홈페이지</span>
						<input type="text" id="wep" class="form-control">
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
	
	<%
	DAO_CinemaDB cinemaData = new DAO_CinemaDB();
	ArrayList<Data_Cinema> cinemaList = cinemaData.getAllCinemaData();
	int count = cinemaList.size();
	%>
	<div class="title">
		<h1>영화관 관리</h1>
		<h3>
			전체 리뷰수 :
			<%=count%>개
		</h3>
		<div class="input-group mb-3" style="width: 100%;">
			<span class="input-group-text" id="inputGroup-sizing-default">영화관 검색</span>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findname" placeholder="find">
				<label for="floatingInput">이름</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findaddress" placeholder="find">
				<label for="floatingInput">주소</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findtel" placeholder="find">
				<label for="floatingInput">전화번호</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control filterText" id="findwep" placeholder="find">
				<label for="floatingInput">홈페이지</label>
			</div>
			<button type="button" id="filterResetBtn" class="btn btn-primary">검색 초기화</button>
			<button type="button" id="insertBtn" class="btn btn-outline-primary">영화관 추가</button>
		</div>
		<span id="findResult">
			검색결과 :
			<%=count%>개
		</span>
	</div>
	<div class="body_main">
		<div class="table-container">
			<table id="userInfoTable" class="table table-responsive table-hover">
				<thead>
					<tr>
						<th class="">이름</th>
						<th class="">주소</th>
						<th class="">전화번호</th>
						<th class="">홈페이지</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Data_Cinema data : cinemaList) {
					%>
					<tr>
						<td><%=data.getName()%></td>
						<td><%=data.getAddress()%></td>
						<td><%=data.getTel()%></td>
						<td><%=data.getWep()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	</main>
	<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
	<script type="text/javascript">
		$(document).ready(function() {
			var modal = $('#myModal');
			var insertmodal = $('#insertModal');
			
			var filterInputs = $('.filterText');
			//findname findaddress findtel findwep
			var findnameInput = $('#findname');
			var findaddressInput = $('#findaddress');
			var findtelInput = $('#findtel');
			var findwepInput = $('#findwep');
			
			
			
			$('.table tbody tr').click(
					function() {
						// name address tel wep
						var rowData = $(this).find('td');
						modal.find('#name').val(rowData.eq(0).text());
						modal.find('#address').val(rowData.eq(1).text());
						modal.find('#tel').val(rowData.eq(2).text());
						modal.find('#wep').val(rowData.eq(3).text());
						
						modal.modal('show');

					});

			// 모달 내의 '저장' 버튼을 클릭할 때 수정된 데이터를 테이블에 적용하는 코드를 추가합니다.
			$('.save-button').click(function() {
				var data_1 = modal.find('#name').val();
				var data_2 = modal.find('#address').val();
				var data_3 = modal.find('#tel').val();
				var data_4 = modal.find('#wep').val();

				var selectedRow = $('.table tr.active');
				selectedRow.find('td').eq(0).text(data_1);
				selectedRow.find('td').eq(1).text(data_2);
				selectedRow.find('td').eq(2).text(data_3);
				selectedRow.find('td').eq(3).text(data_4);

				modal.modal('hide');
				//alert("저장버튼 실행1");
				admin_F("cinema", "update");
				//admin_F("user","delete");
				//alert("저장버튼 실행2");

			});
			
			
			$('.deletebtn').click(function() {
				admin_F("cinema", "delete");
				modal.modal('hide');
			});
			
			$('.insert-button').click(function() {
				admin_F("cinema", "insert");
				insertmodal.modal('hide');
			});

			// 테이블 행 클릭 시 선택한 행에 'active' 클래스를 추가하여 하이라이트 효과를 줍니다.
			$('.table tbody tr').click(function() {
				$('.table tbody tr').removeClass('active');
				$(this).addClass('active');
			});

			// 검색어 입력 상자의 내용이 변경될 때 테이블을 필터링합니다.
			// 검색어를 입력하는 입력 상자
			
			filterInputs.each(function() {
			    $(this).on('input', function() {
			    	
			    	var findnameText = findnameInput.val().toLowerCase();
			        var findaddressText = findaddressInput.val().toLowerCase();
			        var findtelText = findtelInput.val().toLowerCase();
			        var findwepText = findwepInput.val().toLowerCase();
			        
			        $('.table tbody tr').each(function() {
			            var rowData_1 = $(this).find('td').eq(0).text().toLowerCase(); // 첫 번째 열 값
			            var rowData_2 = $(this).find('td').eq(1).text().toLowerCase(); // 두 번째 열 값
			            var rowData_3 = $(this).find('td').eq(2).text().toLowerCase(); // 세 번째 열 값
			            var rowData_4 = $(this).find('td').eq(3).text().toLowerCase(); // 네 번째 열 값
		
			            if (rowData_1.indexOf(findnameText) !== -1 && rowData_2.indexOf(findaddressText) !== -1 &&
			                rowData_3.indexOf(findtelText) !== -1 && rowData_4.indexOf(findwepText) !== -1) {
			                $(this).show(); // 일치하는 경우 표시
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
			
			var insertBtn = document.getElementById('insertBtn')
			var filterBtn = document.getElementById('filterResetBtn')

			filterBtn.addEventListener("click", filterReset);
			insertBtn.addEventListener("click", insertmodalShow);
			function insertmodalShow(){
				insertmodal.modal('show');
			}
			
			function filterReset(){
				//alert("필터 초기화");
			
				findnameInput.val("");
				findaddressInput.val("");
				findtelInput.val("");
				findwepInput.val("");
				$('.table tbody tr').show();
				updateDisplayedRowCount();
			}
			
			
			modal.on('hidden.bs.modal', function() {
				$(this).find('.inputTextData').val(''); // 입력 상자를 비우기
			});

			$('#myModal').on('shown.bs.modal', function() {
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
						document.getElementById("insertaddress").value = data.roadAddress;
					}
				}).open();
			}
		});
	</script>
</body>
</html>