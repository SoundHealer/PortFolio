<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <!-- 검색창 추가 -->
    <div class="container mt-5">
        <h2 class="text-center">영화 검색</h2>
        <form id="searchForm" style="display: flex; align-content: center; align-items: center; justify-content: center;">
            <div class="form-group" style="width: 80%; display: flex; align-content: center; align-items: center; justify-content: center; margin: 0px;">
                <label for="searchQuery"></label>
                <input type="text" class="form-control1" id="searchQuery" name="query" placeholder="영화 제목을 입력하세요" style="width: 80%;">
                <button type="submit" class="btn btn-primary">검색</button>
            </div>
        </form>
        <!-- 검색 결과 및 페이지 버튼 표시 위치 -->
        <div id="searchResult" class="mt-3"></div>
        <div id="pagination" class="text-center mt-3"></div>
    </div>

    <script>
        $(document).ready(function() {
            var currentPage = 1;
            var totalPages = 1; // 초기값은 1로 설정

            function performSearch(query, page) {
                // KDMB API 요청
                $.ajax({
                    url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp",
                    type: "GET",
                    dataType: "json",
                    data: {
                        ServiceKey: "77I86OA3PQ26LKYE5PG0", // 여기에 본인의 API 키를 입력하세요
                        collection: "kmdb_new",
                        query: query,
                        detail: "Y", // 검색 결과 상세정보 
                        listCount: 10, // 검색 결과 수 (원하는 개수로 수정)
                        currentPage: page // 현재 페이지
                    },
                    success: function(data) {
                        console.log(data); // API 응답 데이터를 콘솔에 출력

                        // 실제 검색 결과 데이터 추출
                        var searchResults = data.Data[0].Result;
                        totalPages = Math.ceil(data.Data[0].ResultCount / 10); // 페이지 수 계산
                        
                     // 영화 제목에서 !HS와 !HE 태그를 제거하고 공백을 제거하여 정리하는 함수
                        function cleanTitle(title) {
                            return title.replace(/!HS|!HE/g, '').trim();
                        }

                        // 검색 결과를 웹 페이지에 표시하는 예제
                        var resultHtml = "<h3>검색 결과</h3>";
                        if (searchResults && searchResults.length > 0) {
                            searchResults.forEach(function(movie) {
                                var docId = movie.DOCID; // 영화 DOCID
                                var title = cleanTitle(movie.title); // 영화명 정제
                                var kmdbUrl = movie.kmdbUrl; // KMDB URL
                                var releaseDate = movie.releaseDate; // 개봉일
                                var prodYear = movie.prodYear; // 제작년도
                                var directors = movie.directors;
                                var directorNm = movie.directoNm; // 감독 정보가 없는 경우 기본값 설정  수정 필요                      
                                var nation = movie.nation; // 국가
                                var plot = movie.plot; // 줄거리 정보
                                if (plot.length > 200) {
                                    plot = plot.substring(0, 200) + "...";
                                }
                                var posterUrl = movie.posters.split("|")[0]; // 포스터 URL

                             // 검색 결과를 웹 페이지에 추가
                                resultHtml += "<div class='row mt-3'>";
                                resultHtml += "<div class='col-md-4'>";
                                if (posterUrl) {
                                    // 포스터 이미지에 데이터 속성으로 DOCID 추가
                                    resultHtml += "<img src='" + posterUrl + "' alt='포스터' style='max-width: 100%;' data-DOCID='" + docId + "'>";
                                } else {
                                    resultHtml += "<img src='resource/images/흑백로고.png' alt='로고' style='max-width: 80%;'>";
                                }
                                resultHtml += "</div>";
                                resultHtml += "<div class='col-md-8'>";
                                resultHtml += "<h4><span id='title'>" + title + "</span> (<span id='year'>" + prodYear + "</span>)</h4>";
                                resultHtml += "<p>감독: " + directorNm + "</p>";
                                resultHtml += "<p>국가: " + nation + "</p>";
                                resultHtml += "<p>장르: " + movie.genre + "</p>"; // 장르 정보 추가
                                resultHtml += "<p>줄거리: <span id='plot'>" + plot + "</span></p>";
                                resultHtml += "</div>";
                                resultHtml += "</div>";
                            });
                        } else {
                            resultHtml += "<p>검색 결과가 없습니다.</p>";
                        }

                        // 검색 결과를 웹 페이지에 추가
                        $("#searchResult").html(resultHtml);
                        generatePagination(currentPage);
                    },
                    error: function(error) {
                        console.error("API 요청 실패: " + JSON.stringify(error));
                    }
                });
            }

            function generatePagination(currentPage) {
                var paginationHtml = "<ul class='pagination'>";
                for (var i = 1; i <= totalPages; i++) {
                    if (i === currentPage) {
                        paginationHtml += "<li class='page-item active'><a class='page-link' href='#'>" + i + "</a></li>";
                    } else {
                        paginationHtml += "<li class='page-item'><a class='page-link' href='#' data-page='" + i + "'>" + i + "</a></li>";
                    }
                }
                paginationHtml += "</ul>";

                $("#pagination").html(paginationHtml);

                // 페이지 번호 클릭 이벤트 처리
                $("#pagination a.page-link").click(function(event) {
                    event.preventDefault();
                    var page = $(this).data("page");
                    currentPage = page;
                    performSearch($("#searchQuery").val(), page);
                });
            }

            $("#searchForm").submit(function(event) {
                event.preventDefault();
                currentPage = 1;
                performSearch($("#searchQuery").val(), currentPage);
            });
            
         // 포스터 이미지에 호버 효과 추가
            $("#searchResult").on("mouseenter", "img[src^='http']", function() {
                $(this).css("transform", "scale(1.1)");
                $(this).css("transition", "transform 0.3s");
            });

            $("#searchResult").on("mouseleave", "img[src^='http']", function() {
                $(this).css("transform", "scale(1)");
                $(this).css("transition", "transform 0.3s");
            });
            
         // 포스터 이미지를 클릭했을 때 새 페이지로 이동
            $("#searchResult").on("click", "img[src^='http']", function() {
                var docId = $(this).data("DOCID"); // 클릭한 영화의 DOCID를 가져옴
                window.location.href = "movie_detail.jsp?docid=" + docId; // 새 페이지로 이동
            });


     
        });
    </script>
   <footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
</body>
</html>