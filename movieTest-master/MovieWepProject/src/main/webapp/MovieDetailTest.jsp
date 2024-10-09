<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*, java.util.List, java.io.IOException, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 검색</title>
<!-- 필요한 CSS 파일 링크 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/css/styles1.css">
<!-- jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.movie-details {
	display: flex;
	align-items: center;
	justify-content: center; /* 수평 가운데 정렬 추가 */
}

.movie-poster {
	max-width: 50%;
	margin-right: 20px; /* 포스터 이미지와 영화 정보 사이의 여백 추가 */
}

.movie-info {
	max-width: 50%;
	padding: 20px;
}

.movie-title {
	font-size: 24px; /* 원하는 크기로 조정 */
	font-weight: bold; /* 굵게 만들기 */
}
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
	<h1 id="title" class="text-center">
		영화 상세정보
		</h1>
		<%
		String movieTitle = request.getParameter("title");
		String dName = request.getParameter("director");
		String types = request.getParameter("types");

		List<MovieInfo> ListData = new ArrayList<>(); // ListData 리스트를 생성

		if (movieTitle != null && !movieTitle.isEmpty()) {
			List<MovieInfo> movieInfoList = boxOffice.MovieDetail2.searchMovieInfo(movieTitle, types);

			// 영화 정보가 있을 때 처리
			if (movieInfoList != null && !movieInfoList.isEmpty()) {
				// 일치하는 데이터가 있는지 확인
				boolean matchFound = false;

				// movieInfoList를 순회하며 영화 제목과 감독명이 포함된 데이터가 있는지 확인
				for (MovieInfo movieInfo : movieInfoList) {
			if (movieInfo.getMovieTitle().contains(movieTitle) && movieInfo.getDirectorName().equals(dName)) {
				matchFound = true;
				// 데이터를 ListData에 추가
				ListData.add(movieInfo);
				break; // 일치하는 데이터를 찾았으면 루프 종료
			}
				}
				if (!matchFound) {
			ListData.add(movieInfoList.get(0));
				}

				// ListData에서 상세 정보를 표시
				for (MovieInfo movieInfo : ListData) {
		%>
		<div class="movieDetaileData">
			<div id="movie-details" class="movie-details">
				<div class="movie-poster">
					<%
					List<String> posters = movieInfo.getPosters();
					String posterUrl = posters.get(0);
					if (posters != null && !posters.isEmpty() && !posterUrl.equals("")) {
						String firstPoster = posters.get(0);
					%>
					<img src="<%=firstPoster%>" alt="Movie Poster" style="max-width: 100%;">
					<%
					} else {
					%>
					<img src="resource/images/흑백로고.png" alt="로고" style="max-width: 100%;">
					<%
					}
					%>
				</div>
				<div class="movie-info">
					<p class="movie-title"><%=movieInfo.getMovieTitle()%>
						(<%=movieInfo.getProdYear()%>)
					</p>
					<p>
						감독명:
						<%=movieInfo.getDirectorName()%></p>
					<p>
						배우:
						<%=movieInfo.getActors()%></p>
					<p>
						장르 :
						<%=movieInfo.getGenre()%></p>
					<p>
						개봉일 :
						<%=movieInfo.getRepRlsDate()%></p>
					<p>
						줄거리 :
						<%=movieInfo.getPlot()%></p>
				</div>
			</div>
			<%
			}
			}
			}
			%>
			<div class="reviews">
		<!-- 다운후 변경 -->
		<jsp:include page="loadFile/reviews_Test.jsp" />
	</div>
		</div>
		<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
</body>
</html>