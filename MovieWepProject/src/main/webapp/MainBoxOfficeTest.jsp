<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*,Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 정보</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>일일 박스 오피스 순위</h1>
    <div id="movie-list">
        <!-- 여기에 영화 정보를 표시할 것입니다 -->
    </div>

    <script>
        $(document).ready(function() {
            // 페이지 로드 시 실행할 내용
            fetchMovieData();
        });

        function fetchMovieData() {
            $.ajax({
                type: "GET",
                url: "MainBoxServlet", // AJAX 요청을 처리하는 서블릿 경로
                data: { targetDate: "20230908" }, // 날짜를 지정
                dataType: "json",
                success: function(data) {
                    // 영화 정보를 성공적으로 받았을 때 실행될 함수
                    displayMovieData(data);
                },
                error: function() {
                    alert("영화 정보를 불러오는데 실패했습니다.");
                }
            });
        }

        function displayMovieData(data) {
            var movieList = $("#movie-list");
            movieList.empty(); // 기존 데이터 삭제

            // 데이터를 순회하며 화면에 표시
            $.each(data, function(index, movieData) {
                var movieDiv = $("<div>");
                movieDiv.append("<p>랭킹: " + movieData.rank + "</p>");
                movieDiv.append("<p>영화 제목: " + movieData.movieNm + "</p>");
                movieDiv.append("<p>개봉일: " + movieData.openDt + "</p>");
                movieDiv.append("<img src='" + movieData.posterUrl + "' alt='포스터'>");
                movieDiv.append("<hr>");
                movieList.append(movieDiv);
            });
        }
    </script>
</body>
</html>
