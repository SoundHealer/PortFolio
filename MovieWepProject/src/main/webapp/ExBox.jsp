<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*,Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Box Office Data</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .poster-container {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Box Office Data</h1>

    <label for="targetDate">날짜 선택 (YYYYMMDD):</label>
    <input type="date" id="targetDate" name="targetDate">
    <button id="getDataBtn">데이터 가져오기</button>
    <div>
        <div>
            <div class="poster-container">
                <!-- 포스터 나오는 div -->
                <img id="posterImage" style="display: none; max-width: 100%;" />
            </div>
            <div>
	            <div>
	                <h2 id="movieName" style="display: none;"></h2>
	            </div>
	            <div id="directorDiv" style="display: none;">
				        <p>감독: <span id="director"></span></p>
				        <p>개봉일: <span id="openDate"></span></p>
				        <p>관람등급: <span id="watchGrade"></span></p>
				        <p>상영시간: <span class="showTm"></span></p>
				        <p>제작국가: <span id="nation"></span></p>
				        <p>제작상태: <span id="productionStatus"></span></p>
				</div>
            </div>
        </div>
    </div>
    <div id="movieData" style="display: none;">
        <table>
            <thead>
                <tr>
                    <th>랭킹</th>
                    <th>랭킹 증감분</th>
                    <th>영화 제목</th>
                    <th>관객수</th>
                    <th>매출액</th>
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
                        	console.log(data); // 데이터를 콘솔에 출력하여 내용을 확인
                            displayMovieData(data);
                            $('#movieData').show(); // 데이터 가져오면 movieData 표시
                        },
                        error: function () {
                            alert('데이터를 가져오는 중에 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('날짜를 입력해 주세요.');
                }
            });
            // 클릭한 영화의 포스터와 정보를 보여주는 함수
			$('#movieDataBody').on('click', 'tr', function () {
			    var posterUrl = $(this).data('poster');
			    var movieName = $(this).data('name');
			    var director = $(this).data('director');
			    var openDate = $(this).data('openDate');
			    var watchGrade = $(this).data('watchGrade');
			    var showTm = $(this).data('showTm');
			   
			    var nation = $(this).data('nation');
			    var productionStatus = $(this).data('productionStatus');
			
			    $('#posterImage').attr('src', posterUrl);
			    $('#posterImage').show();
			    $('#movieName').text(movieName).show();
			    $('#director').text(director);
			    $('#openDate').text(openDate);
			    $('#openDate').show();
			    $('#watchGrade').text(watchGrade);
			    $('.showTm').text(showTm);
			    $('#nation').text(nation);
			    $('#productionStatus').text(productionStatus);
			
			    // 추가 정보를 나타내는 div를 보이도록 설정
			    $('#directorDiv').show();
			});
			
            function displayMovieData(data) {
                var tableBody = $('#movieDataBody');
                tableBody.empty();
                for (var i = 0; i < data.length; i++) {
                    var movie = data[i];
                    var row = '<tr data-poster="' + movie.posterUrl + '" data-name="' + movie.movieNm + '" data-director="' + movie.directors.join(', ') + '" data-openDate="' + movie.openDt + '" data-watchGrade="' + movie.watchGradeNm + '" data-showTm="' + movie.showTm + '" data-nation="' + movie.nationNm + '" data-productionStatus="' + movie.prdtStatNm + '">' +
                    '<td>' + movie.rank + '</td>' +
                    '<td>' + movie.rankInten + '</td>' +
                    '<td>' + movie.movieNm + '</td>' +
                    '<td>' + movie.audiCnt + '</td>' +
                    '<td>' + movie.salesAmt + '</td>' +
                    '</tr>';
                    tableBody.append(row);
                }
            }
        });
    </script>
</body>