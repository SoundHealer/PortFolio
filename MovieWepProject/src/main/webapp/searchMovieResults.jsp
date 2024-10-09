<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 검색 결과</title>
    <!-- 필요한 CSS 파일 링크 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="resource/css/styles1.css">
</head>
<body>
    <!-- 상단 메뉴바 추가 (동일한 형식으로) -->
    <jsp:include page="loadFile/top.jsp" />
    <jsp:include page="loadFile/menuBar.jsp" />

    <!-- 검색 결과를 표시할 영역 -->
    <div class="container mt-5">
        <h2 class="text-center">검색 결과</h2>
        <form action="searchMovieResults.jsp" method="GET" style="
    	display: flex;
    	align-content: center;
    	align-items: center;
    	justify-content: center;"
        >
     <div class="form-group" style="
    	width: 80%;
    	display: flex;
    	align-content: center;
    	align-items: center;
    	justify-content: center;
    	margin: 0px;
            ">
     <label for="searchQuery"></label>
     <input type="text" class="form-control1" id="searchQuery" name="query" placeholder="영화 제목을 입력하세요" style= "
    	width: 80%;
    	
                ">
    <button type="submit" class="btn btn-primary">검색</button>
            </div>      
        </form>
    </div>
        <%-- 여기에 KMDB API를 호출하여 검색 결과를 화면에 표시하는 코드를 추가합니다. --%>
        <div class="row" id="movieResults">
            <%-- 검색 결과를 반복해서 표시합니다. --%>
        </div> 
    </div>

    <!-- 필요한 JavaScript 라이브러리 및 스크립트 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // KMDB API 키
        var apiKey = '77I86OA3PQ26LKYE5PG0';

        // 검색어 가져오기
        var searchQuery = '<%= request.getParameter("query") %>';

        // KMDB API 호출 및 결과 처리
        $.ajax({
            url: 'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2kmdb_new2&detail=N&director=%EB%B0%95%EC%B0%AC%EC%9A%B1&ServiceKey=77I86OA3PQ26LKYE5PG0',
            data: {
                apikey: apiKey,
                title: searchQuery,
                itemPerPage: 10  // 가져올 결과 수 (원하는 개수로 수정 가능)
            },
            dataType: 'json',
            success: function(data) {
                // API 호출 성공 시 결과 처리
                var movieResults = data.Data;

             // 결과를 표시할 HTML 요소를 가져옴
                var movieResultsContainer = document.getElementById('movieResults');

                // 각 영화 결과를 반복해서 표시
                for (var i = 0; i < movieResults.length; i++) {
                    var movie = movieResults[i];
                    var movieItem = document.createElement('div');
                    movieItem.className = 'movie-item';
                    movieItem.innerHTML = `
                        <div class="movie-poster">
                            <img src="${movie.posters[0].posters[0]}" alt="${movie.title}">
                        </div>
                        <div class="movie-details">
                            <h2 class="movie-title">${movie.title} (${movie.prdtYear})</h2>
                            <p class="movie-plot">${movie.plot}</p>
                        </div>
                    `;
                    movieResultsContainer.appendChild(movieItem);
                }
            },
            error: function() {
                // API 호출 실패 시 오류 처리
                console.error('API 호출에 실패했습니다.');
            }
        });
    </script>
     <footer>
		<p>&copy; 시네마 위키</p>
	</footer>
</body>
</html>
