<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="KMDB.*, java.util.List, java.io.IOException, java.util.ArrayList"%>
<%@ page import="KMDB.KMDB_Data.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 검색</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<link rel="stylesheet" href="resource/css/styles1.css">
<link rel="stylesheet" href="resource/css/reviewStyle.css">
<style>
.movie-details {
	display: flex;
	align-items: center;
	justify-content: center; /* 수평 가운데 정렬 추가 */
	font-size: 15pt; /* 텍스트 크기를 15pt로 조정 */
	font-weight: bold; /* 글꼴을 굵게 만듭니다. */
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

/* 배우 목록 텍스트 스타일 조정 */
.actors-list {
	font-size: 15pt; /* 텍스트 크기를 15pt로 조정 */
	font-weight: normal; /* 폰트 굵기를 기본값으로 설정합니다. */
}

/* 나머지 텍스트 스타일 조정 */
p {
	font-size: 15pt; /* 텍스트 크기를 15pt로 조정 */
	font-weight: normal; /* 폰트 굵기를 기본값으로 설정합니다. */
}

/* 나머지 줄거리 숨기기 */
.plot-details {
	display: none;
}

/* 더보기 링크 스타일 */
.read-more {
	color: #007bff;
	cursor: pointer;
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
	<body_main>
	<h1 id="title" class="text-center">영화 상세정보</h1>
	<%
	request.setCharacterEncoding("UTF-8");
	String param_docid = request.getParameter("DOCID");
	String param_title = request.getParameter("title");

	String director = request.getParameter("director");
	String title = request.getParameter("title");

	ArrayList<KMDB_Data> ListData = new ArrayList<KMDB_Data>(); // ListData 리스트를 생성

	LoadKMDBData loadData = new LoadKMDBData();
	KMDB_Data kmdbData = new KMDB_Data();
	System.out.println("movieDOCID : " + param_docid);
	if (param_docid != null && !param_docid.isEmpty() && param_docid != "undefined") {
		ArrayList<KMDB_Data> movieInfoList = loadData.getKMDB_movieDOCID(param_docid);
		KMDB_Data data = movieInfoList.get(0);
		// 영화 정보가 있을 때 처리
	%>
	<div class="movieDetaileData">
		<div id="movie-details" class="movie-details">
			<div class="movie-poster">
				<%
				String poster = data.getPosters()[0];
				String selectPoster = "resource/images/흑백로고.png";
				if (poster != null && !poster.isEmpty() && !poster.equals(""))
					selectPoster = poster;
				%>
				<img src="<%=selectPoster%>" alt="Movie Poster" style="max-width: 100%;">
			</div>
			<div class="movie-info">
				<p class="movie-title"><%=data.getTitle()%>
					(<%=data.getProdYear()%>)
				</p>
				<p>
					감독명:
					<%=data.getDirectors().get(0).getDirectorNm()%></p>
				<p>
    배우:[
    <%
    ArrayList<actor> ActorList = data.getActors();
    String actorListText = ""; // 배우 목록 텍스트를 초기화

    for (int i = 0; i < ActorList.size(); i++) {
        actorListText += ActorList.get(i).getActorNm();
        if (i < ActorList.size() - 1) {
            actorListText += ", ";
        }
    }
    // 배우 목록이 50자 이상인 경우
    if (actorListText.length() > 50) {
    %>
        <span class="actors-list">
            <%=actorListText.substring(0, 50)%>
        </span>
        <span class="actors-details" style="display: none;">
            <%=actorListText.substring(50)%>
        </span>
        <a href="javascript:void(0);" class="read-more-actors" onclick="toggleActorsList()">더보기</a>
    <%
    } else {
    %>
        <%=actorListText%>
    <%
    }
    %>
    ]
</p>

				<p>
					장르 :
					<%=data.getGenre()%></p>
				<p>
					개봉일 :
					<%=data.getRepRlsDate()%></p>
				<p>
					줄거리 :
					<span class="plot-summary">
						<%
						String plot = data.getPlots().get(0).getPlotText();
						int plotLen = plot.length();
						if (plotLen > 150) {
						%>
						<%=plot.substring(0, 150)%>
					</span>
					<span class="plot-details">
						<%=data.getPlots().get(0).getPlotText().substring(150)%>
					</span>
					<a href="javascript:void(0);" class="read-more" onclick="togglePlotSummary()">더보기</a>
					<%
					} else {
					%>
					<span class="plot-summary">
						<%=plot%>
					</span>
					<%
					}
					%>
					
				</p>
			</div>
		</div>
		<%
		} else {
		%>
		<script type="text/javascript">
			alert("영화 정보를 찾을수 없습니다.");
			history.back();
		</script>
		<%
		}
		%>
		<div id="showReviewListDiv">
			<jsp:include page="loadFile/startImgTest.jsp">
				<jsp:param name="param_type" value="movie" />
				<jsp:param name="param_docid" value="<%=param_docid%>" />
				<jsp:param name="param_title" value="<%=param_title%>" />
			</jsp:include>
		</div>
	</div>
	<script>
		function togglePlotSummary() {
			var plotSummary = document.querySelector(".plot-summary");
			var plotDetails = document.querySelector(".plot-details");
			var readMoreLink = document.querySelector(".read-more");

			if (plotDetails.style.display === "none") {
				plotDetails.style.display = "inline"; // 나머지 줄거리를 보이게 함
				readMoreLink.innerText = "간략히 보기";
			} else {
				plotDetails.style.display = "none"; // 나머지 줄거리를 숨김
				readMoreLink.innerText = "더보기";
			}
		}
		
	
	    function toggleActorsList() {
	        var actorsList = document.querySelector(".actors-list");
	        var actorsDetails = document.querySelector(".actors-details");
	        var readMoreActorsLink = document.querySelector(".read-more-actors");

	        if (actorsDetails.style.display === "none") {
	            actorsDetails.style.display = "inline"; // 나머지 배우 목록을 보이게 함
	            readMoreActorsLink.innerText = "간략히 보기";
	        } else {
	            actorsDetails.style.display = "none"; // 나머지 배우 목록을 숨김
	            readMoreActorsLink.innerText = "더보기";
	        }
	    }
	</script>
	
	</body_main>
	<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
	</main>
</body>
</html>
