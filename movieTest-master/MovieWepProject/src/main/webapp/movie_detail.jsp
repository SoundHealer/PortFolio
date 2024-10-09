<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 상세 정보</title>
    <!-- 필요한 CSS 파일 링크 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="resource/css/styles2.css"> <!-- 새로운 CSS 파일 사용 가능 -->
</head>
<body>
   <header>
		<div id="top">
		<!-- 다운후 변경 -->
			<jsp:include page="loadFile/top.jsp" /> 
			<jsp:include page="loadFile/menuBar.jsp" />
		</div>
	</header>

    <!-- 영화 상세 정보를 표시할 컨테이너 -->
    <div class="container mt-5">
        <h2 class="text-center">영화 상세 정보</h2>
        <div id="movieDetails" class="mt-3">
            <!-- 여기에 클릭한 영화의 상세 정보를 동적으로 표시합니다. -->
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // URL에서 DOCID 파라미터를 가져옵니다.
            var urlParams = new URLSearchParams(window.location.search);
            var docId = urlParams.get("docid");

            // 영화 상세 정보를 가져와서 표시합니다.
            loadMovieDetails(docId);

            function loadMovieDetails() {
                // URL에서 "midx" 파라미터 값을 가져옴
                var urlParams = new URLSearchParams(window.location.search);
                var midx = urlParams.get("midx");

                // midx를 사용하여 영화 상세 정보를 가져오는 API를 호출
                $.ajax({
                    url: "http://api.example.com/get_movie_details", // 실제 API 엔드포인트로 변경해야 함
                    type: "GET",
                    dataType: "json",
                    data: {
                        midx: midx // 영화의 midx를 파라미터로 전달
                    },
                    success: function(data) {
                        // API로부터 받은 데이터를 사용하여 영화 상세 정보를 표시
                        var movieDetails = data; // API 응답에서 적절한 필드로 변경해야 함

                        // 영화 제목 표시
                        $("#movieTitle").text(movieDetails.title);

                        // 감독 표시
                        $("#director").text("감독: " + movieDetails.director);

                        // 출연 배우 표시
                        $("#actors").text("출연 배우: " + movieDetails.actors);

                        // 개봉일 표시
                        $("#releaseDate").text("개봉일: " + movieDetails.releaseDate);

                        // 영화 설명 표시
                        $("#description").text(movieDetails.description);

                        // 기타 필요한 정보를 표시
                        // ...

                        // 예매 버튼을 클릭했을 때 예매 페이지로 이동
                        $("#bookTicketButton").click(function() {
                            window.location.href = "http://www.example.com/book_ticket?midx=" + midx; // 예매 페이지 URL로 이동
                        });
                    },
                    error: function(error) {
                        console.error("API 요청 실패: " + JSON.stringify(error));
                    }
                });
            }
        });
        </script>
         <footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>
	</body>
	</html>
