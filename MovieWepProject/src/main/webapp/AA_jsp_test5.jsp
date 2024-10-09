<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10-Column Table</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<link rel="stylesheet" href="resource/css/styles1.css">
</head>
<body>
	<div class="dropdown">
		<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
			data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">관리</button>
		<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			<button type="button" class="btn btn-primary dropdown-btn" data-message="수정">수정</button>
			<button type="button" class="btn btn-danger dropdown-btn" data-message="삭제">삭제</button>
		</div>
	</div>
	<p id="message">선택된 메시지가 여기에 표시됩니다.</p>
	<script>
		$(document).ready(function() {
			// 드롭다운 메뉴 아이템을 클릭했을 때
			$('.dropdown-btn').click(function() {
				var selectedMessage = $(this).data('message'); // 선택한 아이템의 데이터 메시지 가져오기
				if (selectedMessage == "수정") {
					alert("수정 버튼 클릭");
				}
				$('#message').text(selectedMessage); // 메시지를 표시할 요소에 메시지 설정
			});
		});
	</script>
</body>
</html>
