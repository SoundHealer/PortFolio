<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="KMDB.*,KMDB.LoadKMDBData.*, java.util.List, java.util.ArrayList, java.io.IOException, java.time.LocalDate, java.time.format.DateTimeFormatter"
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 상세 정보</title>
<!-- 필요한 CSS 파일 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/css/styles1.css">
<!-- 새로운 CSS 파일 사용 가능 -->
<style>
/* 이미지 호버 효과 정의 */
.poster-img {
	max-width: 100%;
	transition: transform 0.3s ease-in-out; /* 호버 시에 변화를 부드럽게 적용 */
}

/* 호버 시 이미지 크기 확대 */
.poster-img:hover {
	transform: scale(1.1); /* 이미지 크기를 1.1배 확대 */
}
</style>
</head>
<body>
	<main>
		<!-- 로고 이미지 -->
		<header>
			<div id="top">
				<!-- 다운후 변경 -->
				<jsp:include page="loadFile/top.jsp" />
				<jsp:include page="loadFile/menuBar.jsp" />
			</div>
		</header>
		<div class="container mt-5" style="width: 60%;
    display: flex;
    flex-wrap: wrap;
    flex-direction: column;
    align-items: center;">
			<h1 class="text-center">영화 검색</h1>
			<form action="movietest.jsp" method="GET" onsubmit="removeSpaces()"
				style="display: flex; align-content: center; align-items: center; justify-content: flex-start; flex-wrap: wrap;"
			>
				<div class="input-group">
					<input type="text" class="form-control" id="title" name="title" onsubmit="removeSpaces()"
						required style="font-size: xx-large;"
					>
					<button type="submit" value="Search" class="btn btn-outline-success">
					<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" >
  								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
							</svg>
							</button>
				</div>
				<label style="font-size : 22px;">
					<input type="radio" name="types" value="title" checked>
					제목
				</label>
				<label class="ml-3" style="font-size : 22px;">
					<input type="radio" name="types" value="director">
					감독
				</label>
			</form>
			<%
			String movieTitle = request.getParameter("title");
			String resultHtml = ""; // 검색 결과를 저장할 빈 HTML 문자열
			String types = request.getParameter("types");
			ArrayList<KMDB_Data> movieInfoList = null;
			if (movieTitle != null && !movieTitle.isEmpty()) {

				LoadKMDBData loadData = new LoadKMDBData();

				if (types.equals("title")) {
					movieInfoList = loadData.getKMDB_title(movieTitle);
				} else {
					movieInfoList = loadData.getKMDB_director(movieTitle);
				}

				if (movieInfoList != null && !movieInfoList.isEmpty()) {
					for (KMDB_Data movieInfo : movieInfoList) {

				String movieid = movieInfo.getMovieId();
				String movieSeq = movieInfo.getMovieSeq();

				String DOCID = movieInfo.getDOCID();

				String title = movieInfo.getTitle();
				String director = movieInfo.getDirectors().get(0).getDirectorNm();
				String nation = movieInfo.getNation();
				String genre = movieInfo.getGenre();
				String prodYear = movieInfo.getProdYear();

				String posterUrl = movieInfo.getPosters()[0];

				resultHtml += "<div class='row mt-3'>";
				resultHtml += "<div class='col-md-4'>";

				if (posterUrl != null && !posterUrl.isEmpty() && !posterUrl.equals("")) {

					// 포스터 이미지가 있는 경우
					resultHtml += "<a href='MovieInfoOfMovieSeq.jsp?DOCID=" + DOCID + "&title=" + title + "'>";
					resultHtml += "<img class='poster-img' src='" + posterUrl + "' alt='포스터' style='max-width: 100%;'>";
					resultHtml += "</a>";
				} else {
					// 포스터 이미지가 없는 경우 흑백 로고 이미지 표시
					resultHtml += "<img class='poster-img' src='resource/images/흑백로고.png' alt='로고' style='max-width: 80%;'>";
				}
				resultHtml += "</div>";
				resultHtml += "<div class='col-md-8'>";
				resultHtml += "<h4><a href='MovieInfoOfMovieSeq.jsp?DOCID=" + DOCID + "&title=" + title + "'>" + title
						+ " (" + prodYear + ")</a></h4>";
				resultHtml += "<p>감독: " + director + "</p>";
				resultHtml += "<p>장르: " + genre + "</p>";
				resultHtml += "<p>국가: " + nation + "</p>";
				// 필요한 정보를 추가하세요
				resultHtml += "</div>";
				resultHtml += "</div>";
					}
				} else {
					resultHtml += "<p>검색 결과가 없습니다.</p>";
				}
			}
			%>
			<!-- Display the search results -->
			<div class="container mt-5">
				<h2 class="text-center"></h2>
				<%=resultHtml%>
			</div>
		</div>
		<footer>
			<div id="bottom">
				<jsp:include page="loadFile/bottom.jsp" />
			</div>
		</footer>
	</main>
</body>
</html>