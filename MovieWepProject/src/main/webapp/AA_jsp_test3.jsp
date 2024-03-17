<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<link rel="stylesheet" href="resource/css/styles1.css">
<title>2x2 Grid with Inputs</title>
<style type="text/css">
.parent {
	margin: 50px;
	border: 1px solid #000;
	padding: 10px;
	width: 80%;
	height: 150px;
	position: relative;
}

.top-left {
	display: flex;
	flex-direction: row;
	flex-wrap: nowrap;
	align-items: center;
}

.top-left .name {
	margin-right: 5px;
}

.dropdownBtn {
	position: absolute;
	top: 10px;
	right: 10px;
}

.review {
	border: 1px solid #AAA;
	position: absolute;
	top: 50px;
	width: calc(100% - 20px);
	height: calc(100% - 60px);
	overflow: auto; /* 내용이 범위를 벗어날 때 스크롤 표시 */
	max-height: 250px; /* 스크롤 영역의 최대 높이를 지정 */
}
.reviewEditBtn{
height: 30px;
padding: 3px 12px;
}
</style>
</head>
<body>
	<div class="parent">
		<div class="top-left">
			<p class="name">아이디</p>
			<p>평점</p>
		</div>
		<div class="review">
			<p class="bottom">
				span
				<br>
				span
				<br>
				span
				<br>
				span
			</p>
		</div>
		<div class="dropdownBtn dropdown">
			<button type="button" class="btn btn-primary reviewEditBtn" data-message="수정">수정</button>
		</div>
	</div>
</body>
</html>
