<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>시네마 위키</title>
<!-- 부트스트랩 CSS 링크 추가 -->
<!-- 부트스트랩 및 jQuery 및 Popper.js JavaScript 라이브러리 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/css/styles1.css">
<!-- 기존 CSS 스타일 시트 링크 -->

</style>
</head>
<body>
	<!-- 로고 이미지 -->
	<header>
		<div id="top">
			<!-- 다운후 변경 -->
			<jsp:include page="loadFile/top.jsp" />
			<jsp:include page="loadFile/menuBar.jsp" />
		</div>
	</header>
	<script type="text/javascript">
		
		var userId = '<%=session.getAttribute("userId")%>';
		if (userId == 'null') {
			window.location.href = 'signin.jsp';
		}
	</script>
	<div class="reviews">
		<!-- 다운후 변경 -->
		<jsp:include page="loadFile/reviews.jsp" />
	</div>
	
	<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
</body>
</html>