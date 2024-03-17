<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*,Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Box Office Data</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>Box Office Data</h1>

    <label for="targetDate">날짜 선택 (YYYYMMDD):</label>
    <input type="date" id="targetDate" name="targetDate">
    <button id="getDataBtn">데이터 가져오기</button>
    <p id="selectedDate"></p>

	<div>
		<!--  포스터 나오는 곳 -->
	</div>
	<div id="movieData">
    	<table>
	        <thead>
	            <tr>
	                <th>랭킹</th>
	                <th>랭킹 증감분</th>
	                <th>영화 제목</th>
	                <th>영화 코드</th>
	                <th>개봉일</th>
	                <th>관객수</th>
	                <th>관객수 증감률</th>
	                <th>관객수 증감 비율</th>
	                <th>매출액</th>
	                <th>매출액 변동</th>
	                <th>매출액 변동 증감</th>
	                <th>감독</th>
	                <th>감독 영어명</th>
	                <th>관람등급</th>
	                <th>상영시간</th>
	                <th>제작국가</th>
	                <th>제작상태</th>
	            </tr>
	        </thead>
	        <tbody id="movieDataBody">
	        </tbody>
	    </table>
    </div>

    <script>
        $(document).ready(function () {
            $('#getDataBtn').click(function () {
                var targetDate = $('#targetDate').val().replace(/-/g, ''); // "-" 문자 제거
                if (targetDate) {
                    $.ajax({
                        url: 'movieDataServlet?targetDate=' + targetDate,
                        method: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            displayMovieData(data);
                            $('#selectedDate').text('선택한 날짜: ' + targetDate);
                        },
                        error: function () {
                            alert('데이터를 가져오는 중에 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('날짜를 입력해 주세요.');
                }
            });

            function displayMovieData(data) {
                var movies = data; // 받아온 데이터를 배열에 저장

                var tableBody = $('#movieDataBody');
                tableBody.empty();
                for (var i = 0; i < movies.length; i++) {
                    var movie = movies[i];
                    var row = '<tr>' +
                        '<td>' + movie.rank + '</td>' +
                        '<td>' + movie.rankInten + '</td>' +
                        '<td>' + movie.movieNm + '</td>' +
                        '<td>' + movie.movieCd + '</td>' +
                        '<td>' + movie.openDt + '</td>' +
                        '<td>' + movie.audiCnt + '</td>' +
                        '<td>' + movie.audiInten + '</td>' +
                        '<td>' + movie.audiChange + '</td>' +
                        '<td>' + movie.salesAmt + '</td>' +
                        '<td>' + movie.salesChange + '</td>' +
                        '<td>' + movie.salesShare + '</td>' +
                        '<td>' + movie.directors.join(', ') + '</td>' +
                        '<td>' + movie.directorsEn.join(', ') + '</td>' +
                        '<td><img src="' + movie.posterUrl + '" width="100" height="150"></td>' +
                        '<td>' + movie.watchGradeNm + '</td>' +
                        '<td>' + movie.showTm + '</td>' +
                        '<td>' + movie.nationNm + '</td>' +
                        '<td>' + movie.prdtStatNm + '</td>' +
                        '</tr>';
                    tableBody.append(row);
                }
            }
        });
    </script>
</body>
</html>
