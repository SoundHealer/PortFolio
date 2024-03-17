<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Office.*"%>
<%@ page import="java.util.*"%>
<%@ page import="DB.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>시네마 위키</title>
<!-- 부트스트랩 CSS 링크 추가 -->
<!-- 부트스트랩 및 jQuery 및 Popper.js JavaScript 라이브러리 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFWttU33_ZQvbz5cU1vdkdtcyPL2Tr53U&libraries=places"
></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"
></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
	integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
	crossorigin="anonymous"
></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/css/styles1.css">
<!-- 기존 CSS 스타일 시트 링크 -->
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
		<script type="text/javascript">
		
		var userId = '<%=session.getAttribute("userId")%>';
			if (userId != 'null') {
				//alert(userId);
			}
		</script>
		<body_main>
		<div id="movieCarousel" class="carousel slide" data-ride="carousel" data-interval="5000">
			<!-- 인디케이터 -->
			<ol class="carousel-indicators">
				<li data-target="#movieCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#movieCarousel" data-slide-to="1"></li>
				<li data-target="#movieCarousel" data-slide-to="2"></li>
				<li data-target="#movieCarousel" data-slide-to="3"></li>
				<li data-target="#movieCarousel" data-slide-to="4"></li>
				<!-- 필요한 만큼 인디케이터를 추가하십시오 -->
			</ol>
			<!-- 슬라이드 -->
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="resource/images/스틸컷1.jpg" alt="30일" style="width: 100%;">
					<div class="carousel-caption">
						<h3>30일</h3>
						<p>기억도 로맨스도 날리고 웃음만 남긴 이들의 제대로 터지는 코미디가 온다!.</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resource/images/스틸컷2.jpg" alt="용감한 시민" style="width: 100%;">
					<div class="carousel-caption">
						<h3>용감한 시민</h3>
						<p>"선은 네가 먼저 넘었다. 말이 안 통하면 혼나야지!"</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resource/images/스틸컷3.jpg" alt="플라워 킬링 문" style="width: 100%;">
					<div class="carousel-caption">
						<h3>플라워 킬링 문</h3>
						<p>진정한 사랑과 말할 수 없는 배신이 교차하는 서부 범죄극!!</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resource/images/스틸컷4.jpg" alt="보스턴 1947" style="width: 100%;">
					<div class="carousel-caption">
						<h3>보스턴 1947</h3>
						<p>1947년 태극마크를 달고 달렸던 마라토너들의 가슴 벅찬 여정! 올 추석, 단 하나의 감동 실화가 온다!
</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resource/images/스틸컷5.jpg" alt="그대들은 어떻게 살 것인가" style="width: 100%;">
					<div class="carousel-caption">
						<h3>그대들은 어떻게 살 것인가</h3>
						<p>일본 애니메이션 거장 미야자키 하야오 10년 만의 신작! 미야자키 하야오의 모든 것을 담은 자전적 판타지!</p>
					</div>
				</div>
			</div>
			<!-- 컨트롤러 -->
			<a class="carousel-control-prev" href="#movieCarousel" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">이전</span>
			</a>
			<a class="carousel-control-next" href="#movieCarousel" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">다음</span>
			</a>
		</div>
		<div class="mainCenterDiv">
			<div class="container mt-5">
				<h2 class="text-center">인기 영화</h2>
				<div id="movie-list" class="row">
					<!-- 여기에 랜덤한 10개의 인기 영화 포스터가 추가됩니다. -->
				</div>
			</div>
			<div class="container mt-5" >
				<h2 class="text-center">추천 영화</h2>
				<div id="recommended-movie-list" class="row">
					<div class="container"
						style=" margin-bottom: 40px; padding: 20px;"
					>
						<div id="recommended-movie-list" class="row"
							style="display: flex; flex-direction: column; align-items: center; flex-wrap: nowrap; min-height: 200px; width: 100%; justify-content: space-evenly; 
							<% if(session.getAttribute("userId") ==  null){ %>
							border: 1px solid black; <%} %>
						"><div class="movie-gallery">
							<%
							if (session.getAttribute("userId") != null) {

								UserGenreSimilarityFinder d = new UserGenreSimilarityFinder();

								List<MainBoxCtor> dataList = d.resultInterestMovieData(session.getAttribute("userId").toString());

								//System.out.println(d.resultInterestMovieData(dataList));

								for (MainBoxCtor data : dataList) {
									System.out.println(data.toString());
							%>
							
								<div class="col-md-3 movie-item"
									onclick="location.href='/MovieWepProject/MovieInfoOfMovieSeq.jsp?DOCID=<%=data.getMovieDOCID()%>&title=<%=data.getMovieNm()%>';"
								>
									<img src="<%=data.getPosterUrl()%>" alt="포스터" class="poster">
									<div class="movie-info text-center">
										<p class="movie-title">
											<strong><%=data.getMovieNm()%></strong>
										</p>
										<p class="movie-release-date">
											<strong><%=data.getOpenDt()%></strong>
										</p>
									</div>
								</div>
							
							<%
							}
							} else {
							%>
							</div>
							<h3>로그인이 필요합니다.</h3>
							<button type="button" class="btn btn-primary"
								onclick="location.href='/MovieWepProject/signin.jsp'"
							>로그인</button>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			<!-- CGV 영화관 사진 및 링크 -->
			<!-- 특별관 섹션 -->
			<div class="container text-center mt-5">
				<h2>특별관</h2>
				<div class="row">
					<div class="col-md-6">
						<div id="theater-images">
							<img id="cgv-image" src="resource/images/cgv_logo1.jpg" alt="CGV 로고" width="560"
								height="320" onclick="navigateToTheaterWebsite('cgv');"
							>
							<img id="lotte-image" src="resource/images/lotte_logo1.jpg" alt="롯데시네마 로고" width="560"
								height="320" style="display: none;" onclick="navigateToTheaterWebsite('lotte');"
							>
							<img id="megabox-image" src="resource/images/megabox1_logo.jpg" alt "메가박스 로고" width="560"
								height="320" style="display: none;" onclick="navigateToTheaterWebsite('megabox');"
							>
						</div>
					</div>
					<div class="col-md-6">
						<ul class="theater-list">
							<li>
								<a href="#" class="theater-link" onclick="showTheaterImage('cgv');  scrollPrevent(event);">
									<strong>CGV</strong>
								</a>
							</li>
							<li>
								<a href="#" class="theater-link"
									onclick="showTheaterImage('lotte');  scrollPrevent(event);"
								>
									<strong>롯데시네마</strong>
								</a>
							</li>
							<li>
								<a href="#" class="theater-link"
									onclick="showTheaterImage('megabox');  scrollPrevent(event);"
								>
									<strong>메가박스</strong>
								</a>
							</li>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
		</body_main>
		<footer>
			<div id="bottom">
				<jsp:include page="loadFile/bottom.jsp" />
			</div>
		</footer>
		<style>
.theater-list {
	list-style: none;
	padding: 0;
}

.theater-list li {
	margin-bottom: 10px;
	text-align: center;
}

.theater-link {
	display: block;
	font-size: 50px; /* 원하는 크기로 조정하세요 */
	text-decoration: none; /* 밑줄 없앰 */
	border: 2px solid transparent; /* 테두리 스타일 추가 */
	padding: 10px; /* 내부 여백 추가 */
	transition: border-color 0.3s; /* 테두리 색상 변경 애니메이션 */
}

.theater-link:hover {
	border-color: #000; /* 마우스 호버 시 테두리 색상 변경 */
	font-weight: bold; /* 텍스트 굵게 표시 */
}

#cgv-image,
#lotte-image,
#megabox-image {
    cursor: pointer;
}
</style>
		<script src="resource/js/script1.js"></script>
		<!-- JavaScript 파일 링크  -->
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				// 로그인 버튼 클릭 시 login.html로 이동
				const loginButton = document.querySelector("#loginButton");
				loginButton.addEventListener("click", function() {
					window.location.href = "login.html";
				});

				// 회원가입 버튼 클릭 시 register.html로 이동
				const registerButton = document
						.querySelector("#registerButton");
				registerButton.addEventListener("click", function() {
					window.location.href = "signup.jsp";
				});
			});

			// 텍스트 클릭 시 스크롤 방지
			function scrollPrevent(event) {
				event.preventDefault();
			}

			$(document).ready(function() {
				// 페이지 로드 시 실행할 내용
				fetchMovieData();
			});

			$(document).ready(function() {
				// 캐러셀 초기화
				$('#movieCarousel').carousel();
			});

			function showTheaterImage(theaterName) {
				// 모든 극장 이미지를 숨김
				document.getElementById("cgv-image").style.display = "none";
				document.getElementById("lotte-image").style.display = "none";
				document.getElementById("megabox-image").style.display = "none";

				// 선택한 극장 이미지만 표시
				document.getElementById(theaterName + "-image").style.display = "block";
			}

			function navigateToTheaterWebsite(theaterName) {
				// 극장 이름에 따라 URL 설정
				var theaterURLs = {
					cgv : "https://www.cgv.co.kr",
					lotte : "https://www.lottecinema.co.kr",
					megabox : "https://www.megabox.co.kr"
				};

				// 선택한 극장의 URL로 이동
				var theaterURL = theaterURLs[theaterName];
				if (theaterURL) {
					window.location.href = theaterURL;
				} else {
					alert("해당 극장의 홈페이지 URL이 설정되어 있지 않습니다.");
				}
			}

			function formatDate(date) {
				// 날짜를 "yyyymmdd" 형식으로 변환
				var year = date.getFullYear();
				var month = (date.getUTCMonth() + 1).toString()
						.padStart(2, '0');
				var day = date.getUTCDate().toString().padStart(2, '0');
				return year + month + day;
			}

			function fetchMovieData() {

				var today = new Date();
				var yesterday = new Date(today);
				yesterday.setDate(today.getDate() - 1);
				var formattedDate = formatDate(yesterday);
				$.ajax({
					type : "GET",
					url : "MainBoxServlet", // AJAX 요청을 처리하는 서블릿 경로
					data : {
						targetDate : formattedDate
					}, // 날짜를 지정
					dataType : "json",
					async : false,
					success : function(data) {
						// 영화 정보를 성공적으로 받았을 때 실행될 함수
						console.log("fetchMovieData : " + data);
						displayMovieData(data);
					},
					error : function() {
						alert("영화 정보를 불러오는데 실패했습니다.");
					}
				});
			}

			function displayMovieData(data) {
				var movieList = $("#movie-list");
				movieList.empty(); // 기존 데이터 삭제
				//console.log("movie-list : " + data);

				var gallery = $("<div class='movie-gallery'></div>");

				$
						.each(
								data,
								function(index, movieData) {

									//
									//alert(movieData);
									var movieDOCID = movieData.movieDOCID;
									var movieTitle = movieData.movieNm;
									if (movieDOCID == undefined) {
										movieDOCID = "";
									}

									var posterDiv = $("<div class='text-center'>");
									//MovieInfoOfMovieSeq.jsp?movieSeq=55873
									var url = "MovieInfoOfMovieSeq.jsp?DOCID="
											+ movieDOCID + "&title="
											+ encodeURIComponent(movieTitle);
									console.log(url);
									//onclick='"+url+""'
									//alert(url);
									var movieDiv = $("<div class='col-md-3 movie-item' onclick=location.href='"+url+"';>");
									var posterUrl = movieData.posterUrl
											|| "resource/images/흑백로고.png";
									var poster = $("<img src='" + posterUrl + "' alt='포스터' class='poster'>");

									// 제목과 개봉일을 감싸는 div를 추가하고 스타일 적용
									var infoDiv = $("<div class='movie-info text-center'>");
									var title = $("<p class='movie-title'><strong>"
											+ movieData.movieNm
											+ "</strong></p>");
									var releaseDate = $("<p class='movie-release-date'><strong>"
											+ movieData.openDt
											+ "</strong></p>");

									posterDiv.append(poster);
									infoDiv.append(title);
									infoDiv.append(releaseDate);

									movieDiv.append(poster);
									movieDiv.append(infoDiv);
									movieList.append(movieDiv);
									gallery.append(movieDiv);

									//alert(movieData.movieSeq)
								});
				movieList.append(gallery);
			}

			if (userId != 'null' && false) {//로그인 상태일때 추천영화 진행
				function fetchMovieData() {

					$.ajax({
						type : "GET",
						url : "RecommendMovies", // AJAX 요청을 처리하는 서블릿 경로
						data : {
							"userId" : userId
						}, // 날짜를 지정
						dataType : "json",
						//async : false,
						success : function(data) {
							// 영화 정보를 성공적으로 받았을 때 실행될 함수
							console.log("RecommendMovies : " + data);
							displayRecommendedMovieData(data);
						},
						error : function() {
							alert("영화 정보를 불러오는데 실패했습니다.");
						}
					});
				}
			}

			//추천 영화 형식을 인기 영화 형식으로 만들었습니다.
			
		</script>
	</main>
</body>
</html>