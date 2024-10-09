<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>시네마 위키</title>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="../resource/css/styles1.css"> <!-- 기존 CSS 스타일 시트 링크 -->
</head>
<body>

<div class="container">
  <div class="row">
    <div class="col">
		<div class="box-container">
			<jsp:include page="../mini_userInfo.jsp"/>
	    </div>
    </div>
    <div class="col">
		<div class="box-container">
			<jsp:include page="../mini_userInfo.jsp"/>
	    </div>
    </div>
  </div>
  <div class="row">
    <div class="col">
		<div class="box-container">
			<jsp:include page="../mini_userInfo.jsp"/>
	    </div>
    </div>
    <div class="col">
		<div class="box-container">
			<jsp:include page="../mini_userInfo.jsp"/>
	    </div>
    </div>
    <div class="col">
		<div class="box-container">
			<jsp:include page="../mini_userInfo.jsp"/>
	    </div>
    </div>
  </div>
</div>
</body>