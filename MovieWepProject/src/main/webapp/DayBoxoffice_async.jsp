<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*,Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>


    <title>날짜 선택 및 변환</title>
    <style>
    	
    	.nemo-box {
            width: 70%; /* 테이블과 같은 길이로 설정 */
		    max-width: 80%; /* 테이블과 동일한 최대 너비로 설정, 필요에 따라 조절 가능 */
		    height: 10%; /* 테이블과 같은 높이로 설정 */
		    margin: 20px auto; /* 가운데 정렬 및 위아래 여백 조절 */
		    background-color: #f0f0f0; /* 배경 색상 */
		    padding: 10px; /* 내부 여백 */
		    font-size: 13px;
		    
        }
		.loading {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-content {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .spinner {
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid #3498db;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        #keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .even {
            background-color: #f2f2f2;
        }
        .even {
            background-color: #f2f2f2;
        }
        .DateCon {
            text-align: center;
            margin-top: 50px;
        }
        .table-container {
            display: flex;
            flex-direction: column;
            max-width: 80%; /* 테이블 너비를 80%로 변경 */
            margin: 20px auto; /* 테이블 위 아래 여백 조정 */
        }
        
        .table-container table td:nth-child(2) {
            white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
            overflow: hidden;
            text-overflow: ellipsis; /* 텍스트가 너무 길 경우 생략 (...) 표시 */
            max-width: 200px; /* 최대 너비 설정, 필요에 따라 조절하세요 */
        }
        .table-container table tr:nth-child(odd) {
            background-color:  #f2f2f2;
        }
        .table-container table tr:first-child {
            border-top: 2px solid #ED1C23; /* 상단 가장자리 선 두꺼운 선 스타일 설정 */
            border-bottom: 2px solid #000; /* 하단 가장자리 선 두꺼운 선 스타일 설정 */
            
        }
        .date-header {
            text-align: left;
            font-size: 20px;
            color: #D92332 ;
        }
        
        #table-first table td:nth-child(2) {
            white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
            overflow: hidden;
            text-overflow: ellipsis; /* 텍스트가 너무 길 경우 생략 (...) 표시 */
            max-width: 200px; /* 최대 너비 설정, 필요에 따라 조절하세요 */
        }
        #table-first table tr:nth-child(odd) {
            background-color:  #f2f2f2;
        }
        #table-first table tr:first-child {
            border-top: 2px solid #ED1C23; /* 상단 가장자리 선 두꺼운 선 스타일 설정 */
            border-bottom: 2px solid #000; /* 하단 가장자리 선 두꺼운 선 스타일 설정 */
            
        }





		/*그래프 용 상단 가장자리 선 두꺼운 선 스타일 설정 */
		.movie-info {
            cursor: pointer;
        }

        .movie-info:hover {
            background-color: #f0f0f0;
        }

        .hidden {
            display: none;
        }
        #date-container {
            display: flex;
            justify-content: center; /* 가운데 정렬을 위해 추가 */
            margin: 2px 0; /* 위아래 여백 조절 */
        }

        #container {
	        display: flex;
	        justify-content: center; /* 중앙 정렬로 변경 */
	    }
	
		#table-container {
		    width: 500px; /* 원하는 가로 크기를 설정할 수 있습니다 */
		    height: 350px; /* 원하는 세로 크기를 설정할 수 있습니다 */
		    overflow: auto; /* 내용이 컨테이너 크기를 넘어갈 때 스크롤바를 추가합니다 */
		}
	
	    #poster-container {
	    	display: flex;
	        
	        text-align: center;
	        margin: 5px;
	        justify-content: flex-end;
	    }
	    /* 스타일을 조절하기 위한 CSS */
	    
	    .movie-info-container {
		    display: flex;
		    flex-direction: column;
		    margin-right: 40px;
		    margin-left: 30px;
		    width: 300px; /* 고정 가로 크기를 설정하세요 */
		    height: 400px; /* 고정 세로 크기를 설정하세요 */
		    overflow: auto; /* 스크롤바를 추가합니다 */
		}
		
		.movie-info-list {
		    display: flex;
		    flex-wrap: wrap;
		    margin: 0;
		    padding: 0;
		    flex-direction: column;
		}
		
		.movie-info-list dt, .movie-info-list dd {
		    display: inline-block;
		    text-align: center;
		    margin: 0;
		}
		
		.movie-info-list dt {
		    display: inline-block;
		    text-align: center;
		    padding-right: 10px;
		    font-weight: bold;
		}
		#charts-container {
		    display: flex;
		    justify-content: center;
		}
		
		#charts-container > div {
		    margin l: 1px;
		}
		
		#bargraph {
			margin-right: 20px;
		    display: flex;
		    text-align: center;
		    align-items: center;
		}
		
		#salesChart {
		    margin-right: 20px;
		    margin-left: 20px;
		    width: 400px;
		    height: 300px;
		}
		
		#salesShareChart {
		    margin-right: 20px;
		    margin-left: 20px;
		    width: 400px; /* 예시로 다른 너비를 설정 */
		    height: 300px; /* 예시로 다른 높이를 설정 */
		}
    
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="resource/css/styles1.css">
    <div id="top">
        <!-- 다운후 변경 -->
        <jsp:include page="loadFile/top.jsp" /> 
        <jsp:include page="loadFile/menuBar.jsp" />
    </div>
</head>
<body>


	
	<div class="nemo-box">
        [박스오피스]코너는 실시간 발권데이터를 전일기준까지 반영하여 각종 통계정보를 제공합니다.
        <br>

매일 24시 이후 전환/제공되는 [전일자 통계정보]는 상영마감 및 보정처리 등의 사유로 익일 오전까지 계속 업데이트 되며, 일마감 후 데이터보정 등의 사유로 통계정보는 변동 될 수 있음을 참고하시기 바랍니다.
<br>
<br>
통계이용안내
<br>
<br>

① [박스오피스]코너는 연도별 영화상영관 연동율에 따라 실시간 수집된 발권데이터를 전일기준까지 반영한 통계정보입니다.
<br>

② [공식통계]코너는 영진위에서 매년 발표하는 “한국영화연감”의 영화별 흥행기록을 참고한 것입니다.
<br>

한국영화연감(1971~2010) 통계를 기준으로 정리한 것이며, 2011년부터는 통합전산망을 기준으로 일정한 주기(매월, 매년)로 마감 처리하여 산출되는 통계정보입니다.
<br>

통계마감 주기(월별, 년별)에 따라 공식통계 수치는 추후 변동될 수 있습니다.
<br>
    </div>
    <div class="loading" id="loading">
        <div class="loading-content">
            <div class="spinner"></div>
            <p>로딩 중...</p>
        </div>
    </div>
<div class="DateCon">
        <form id="abc">
            <label for="endDate">날짜 선택  :</label>
            <input type="date" id="endDate" name="endDate">
            <input type="hidden" id="formattedDateInput" name="formattedDate" value="">
            <input type="submit" value="조회" id="submitButton" onclick="return formatSelectedDate()">
        </form>
    </div>
    <script>
            document.getElementById("loading").style.display = "block";
    </script>
    <br><br><br>
    <div id="container">
        <div id="poster-container">
            <!-- 포스터를 표시할 div -->
        </div>
        <div id="table-first">
            <table border="1" style="width: 100%;">
                <tr>
                    <th>순위</th>
                    <th>영화명</th>
                    <th>매출액</th>
                    <th>관객수</th>
                    <th>증감율</th>
                </tr>
                
                <%
                String endDate = request.getParameter("endDate");
                
                // formatSelectedDate 함수로부터 받은 formattedDate 파라미터를 가져옴
                String formattedDate = request.getParameter("formattedDate");

                // 선택한 날짜를 (yyyy/mm/dd) 형식으로 변환
                if (formattedDate != null && !formattedDate.isEmpty()) {
                    List<boxData2> movieDataList = Office.DayBox3.fetchDataByDate(formattedDate);

                    for (boxData2 movieData : movieDataList) {
                    	
                %>
                
                
                <tr class="movie-info">
                    <td><%= movieData.getRank() %></td>
                    
                    <td>
                        <%= movieData.getMovieNm() %>
                        <div class="hidden">
                            <img src="<%= movieData.getPosterUrl() %>" alt="Movie Poster" width="100">
                        </div>
                    </td>
                    <td><%= movieData.getSalesAmt() %></td>
                    <td><%= movieData.getAudiCnt() %></td>
                    <td><%= movieData.getRankInten() %></td>
                </tr>
                <%
                    }
                }
                %>
            </table>
        </div>
    </div>
    <!-- 원형 그래프와 막대 그래프를 포함하는 div 컨테이너 -->
	<div id="charts-container">
	
	    <div id ="bargraph">
	    해당일 매출액(원)
	    <br>
	        <canvas id="salesChart"></canvas>
	    </div>
	    <div>
	    해당일 매출 비율(%)
	    <br>
	        <canvas id="salesShareChart"></canvas>
	    </div>
	</div>

    <%
        

        // formatSelectedDate 함수로부터 받은 formattedDate 파라미터를 가져옴

        if (formattedDate != null && !formattedDate.isEmpty()) {
            List<datamovie> dataForDate = Dayboxoffice.fetchDataByDate(formattedDate);
    %>
    <div class="table-container">
        
        <table border="1">
            <tr>
                <th scope="col">
                순위
                <span class="btn_updwBox">
                    <button name="btn4_up" type="button" class="btn_up01" onclick="sortTable(this)">
                        <span>정렬</span>
                    </button>
                </span>
                </th>
                <th>영화명</th>
                <th>개봉일</th>
                <th>매출액</th>
                <th>전일 대비 매출액 증감</th>
                <th>매출액 점유율</th>
                <th>관객 수</th>
                <th>전일 대비 관객 수</th>
                <th>누적 매출액</th>
                <th>누적 관객수</th>
                <th>스크린수</th>
                <th>상영횟수</th>
            </tr>
            <%
                for (datamovie cinema : dataForDate) {
            %>
            <tr>
                <td><%= cinema.getRank() %></td>
                <td><%= cinema.getMovieNm() %></td>
                <td><%= cinema.getOpenDt() %></td>
                <td class="salesAmt"><%= cinema.getSalesAmt() %></td>
                    <td class="salesInten"><%= cinema.getSalesInten() %></td>
                    <td><%= cinema.getSalesShare() %></td>
                    <td><%= cinema.getAudiCnt() %></td>
                    <td><%= cinema.getAudiInten() %></td>
                    <td class="salesAcc"><%= cinema.getSalesAcc() %></td>
                    <td class="audiAcc"><%= cinema.getAudiAcc() %></td>
                <td><%= cinema.getScrnCnt() %></td>
                <td><%= cinema.getShowCnt() %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <%
    }
    else {
    %>
    <script>
        var yesterdayDate = new Date();
        yesterdayDate.setDate(yesterdayDate.getDate() - 1);

        // 시작 날짜와 종료 날짜 input 요소에 값을 설정
        document.getElementById("endDate").valueAsDate = yesterdayDate;
    </script>
    <%
    }
    %>
    <script>
         // 데이터 로딩이 완료된 후 로딩 화면 숨김
         document.getElementById("loading").style.display = "none";
    </script>
    </div>
    <script>
    	
        // 초기 정렬 상태
        var ascending = true;
    
        // 정렬 버튼에 대한 이벤트 리스너 설정
        var upButtons = document.querySelectorAll('.btn_up01');
    
        upButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                processTable(button.closest('table'), ascending);
                ascending = !ascending; // 정렬 상태 변경
            });
        });
        
        function formatSelectedDate() { //submit 실행시 true반환되면 폼 데이터를 파라메트로 제출
            var selectedDate = document.getElementById("endDate").value;

            // 선택한 날짜를 (yyyyMMdd) 형식으로 변환
            var dateParts = selectedDate.split("-");
            if (dateParts.length === 3) {
                var formattedDate = dateParts[0] + dateParts[1] + dateParts[2];
                // hidden input 요소에 값을 설정
                document.getElementById("formattedDateInput").value = formattedDate;
                return true; // 폼을 제출
            } else {
                alert("날짜를 선택하세요.");
                return false; // 날짜가 유효하지 않으면 폼을 제출하지 않음
            }
        }
    
     // 테이블 정렬 함수
        function sortTable(button) {
            var table = button.closest("table");
            var rows = table.rows;
            var switching = true;

            while (switching) {
                switching = false;
                for (var i = 1; i < rows.length - 1; i++) {
                    var shouldSwitch = false;
                    var x = rows[i].getElementsByTagName('td')[0];
                    var y = rows[i + 1].getElementsByTagName('td')[0];

                    if (ascending) {
                        if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    } else {
                        if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }

                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                }
            }

            // 방향 변경
            ascending = !ascending;
        }
     
     
     
     
        

        // 각 영화 정보 묶음에 클릭 이벤트 추가
        var movieInfoElements = document.querySelectorAll(".movie-info");
        var posterContainer = document.getElementById("poster-container");
        
        var selectedMovieIndex = -1; // 초기 선택값
        
        document.addEventListener("DOMContentLoaded", function() {
            // Trigger a click event on the first movie element (index 0)
            var firstMovieElement = movieInfoElements[0];
            if (firstMovieElement) {
                firstMovieElement.click();
            }
        });

        movieInfoElements.forEach(function (element, index) {
            element.addEventListener("click", function () {
                // 클릭된 영화 정보 묶음에서 포스터 URL, 감독 정보, 영화 이름, 그리고 기타 정보를 가져와서 표시
                var posterElement = element.querySelector("div.hidden");
                var posterUrl = posterElement.querySelector("img").getAttribute("src");
                var directors = movieDataArray[index].directors;
                var movieName = movieDataArray[index].movieName;
                var openDate = movieDataArray[index].openDate;
                var watchGrade = movieDataArray[index].watchGrade;
                var showTime = movieDataArray[index].showTime;
                var nation = movieDataArray[index].nation;
                var prdtStat = movieDataArray[index].prdtStat;
                var rank = movieDataArray[index].rank;
                var salesShare = movieDataArray[index].salesShare;

                // 포스터, 영화 정보를 각각 하나의 <div>로 묶은 HTML 문자열 생성
                var posterHtml = '<img src="' + posterUrl + '" alt="Movie Poster" width="280">';
                var movieInfoHtml = '<div class="movie-info-container">';
                movieInfoHtml += '<div>'+ movieName + '</div>';
                movieInfoHtml += '<div>';
                movieInfoHtml += '<dl class="movie-info-list">';
                movieInfoHtml += '<dt>감독</dt><dd>' + directors + '</dd>';
                movieInfoHtml += '<dt>개봉일</dt><dd>' + openDate + '</dd>';
                movieInfoHtml += '<dt>등급</dt><dd>' + watchGrade + '</dd>';
                movieInfoHtml += '<dt>상영 시간</dt><dd>' + showTime + '</dd>';
                movieInfoHtml += '<dt>국가</dt><dd>' + nation + '</dd>';
                movieInfoHtml += '<dt>제작 상태</dt><dd>' + prdtStat + '</dd>';
                movieInfoHtml += '<dt>순위</dt><dd>' + rank + '</dd>';
                movieInfoHtml += '<dt>매출 점유율</dt><dd>' + salesShare + '</dd>';
                movieInfoHtml += '</dl>';
                movieInfoHtml += '</div>';
                movieInfoHtml += '</div>';
                var combinedHtml = '<div style="display: flex;">' + posterHtml + movieInfoHtml + '</div>';

                // poster-container의 내용을 새로운 HTML로 업데이트
                posterContainer.innerHTML = combinedHtml;
                

                // 이전 선택을 취소하고 새로운 영화 선택
                if (selectedMovieIndex !== -1) {
                    // 이전 선택된 영화의 배경색을 원래대로 변경
                    var backgroundColors = salesChart.data.datasets[0].backgroundColor;
                    backgroundColors[selectedMovieIndex] = 'rgba(75, 192, 192, 0.5)'; // 원래 색상으로 변경
                }

                // 클릭한 영화의 인덱스를 저장
                selectedMovieIndex = index;

                // 그래프의 배경색을 업데이트하여 클릭한 영화의 막대를 빨간색으로 표시
                var backgroundColors = salesChart.data.datasets[0].backgroundColor;
                backgroundColors[selectedMovieIndex] = 'rgba(255, 0, 0, 0.5)'; // 빨간색으로 변경

                // 그래프 업데이트
                salesChart.update();
                updateDoughnutChart();
            });
        });

        
        
        var movieDataArray = [
            <% 
            // 선택한 날짜를 (yyyy/mm/dd) 형식으로 변환
            if (formattedDate != null && !formattedDate.isEmpty()) {
                List<boxData2> movieDataList = Office.DayBox3.fetchDataByDate(formattedDate);

            for (boxData2 movieData : movieDataList) { 
            %>
            {
                rank: '<%= movieData.getRank() %>',
                movieName: '<%= movieData.getMovieNm() %>',
                openDate: '<%= movieData.getOpenDt() %>',
                audiAcc: '<%= movieData.getAudiAcc() %>',
                rankChange: '<%= movieData.getRankInten() %>',
                salesAmt: '<%= movieData.getSalesAmt() %>',
                salesShare: '<%= movieData.getSalesShare() %>',
                directors: '<%= String.join(", ", movieData.getDirectors()) %>',
                watchGrade: '<%= movieData.getWatchGradeNm() %>',
                showTime: '<%= movieData.getShowTm() %>',
                nation: '<%= movieData.getNationNm() %>',
                prdtStat: '<%= movieData.getPrdtStatNm() %>',
                posterUrl: '<%= movieData.getPosterUrl() %>',
                
            },
            <%
            }
            }
            %>
        ];
        
     // movieDataArray에서 영화 이름과 판매액을 추출합니다.
        var movieNames = movieDataArray.map(function (movieData) {
            return movieData.movieName;
        });
        var salesAmounts = movieDataArray.map(function (movieData) {
            return parseInt(movieData.salesAmt);
        });

        var backgroundColors = [];

     // 모든 막대를 같은 색상으로 설정
        var backgroundColor = 'rgba(75, 192, 192, 0.5)';

        salesAmounts.forEach(function (amount, index) {
            backgroundColors.push(backgroundColor); // 모든 막대에 동일한 색상 적용
        });

        var ctx = document.getElementById('salesChart').getContext('2d');
        var salesChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: movieNames,
                datasets: [{
                    label: '매출액',
                    data: salesAmounts,
                    backgroundColor: backgroundColors, // 배경색 배열 설정
                    borderWidth: 1,
                }],
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
        
        var salesShares = movieDataArray.map(function (movieData) {
            return parseFloat(movieData.salesShare.replace('%', '')); // '%' 문자 제거 후 숫자로 변환
        });

     // 배경색 배열 정의
        var backgroundColors = [
		    'rgba(255, 99, 132, 0.5)',
		    'rgba(255, 159, 64, 0.5)',
		    'rgba(255, 205, 86, 0.5)',
		    'rgba(75, 192, 192, 0.5)',
		    'rgba(54, 162, 235, 0.5)',
		    'rgba(255, 0, 0, 0.5)',
		    'rgba(0, 255, 0, 0.5)',
		    'rgba(0, 0, 255, 0.5)',
		    'rgba(128, 128, 128, 0.5)',
		    'rgba(0, 128, 128, 0.5)'
		];

     // 원형 그래프 데이터 설정
        var doughnutData = {
            
            datasets: [{
                label: '매출 비율',
                data: salesShares,
                backgroundColor: backgroundColors,
                borderWidth: 5, // 테두리를 제거합니다.

                
            }],
        };

        // 원형 그래프를 생성하는 함수
        function createDoughnutChart() {
            var salesShareCtx = document.getElementById('salesShareChart').getContext('2d');
            return new Chart(salesShareCtx, {
                type: 'doughnut',
                data: doughnutData,
                options: {
                    responsive: true,
                    cutoutPercentage: 30, // 중심 부분을 50%로 잘라냅니다.
                    onClick: function (e) {
                        // 클릭한 영화의 인덱스를 저장
                        selectedMovieIndex = e.active[0]._index;

                        // 원형 그래프 업데이트
                        updateDoughnutChart();
                    },
                },
            });
        }

     // 원형 그래프 업데이트 함수
        function updateDoughnutChart() {
            if (selectedMovieIndex !== -1) {
                var borderWidths = Array(movieNames.length).fill(5); // 모든 테두리 값을 15로 초기화
                borderWidths[selectedMovieIndex] = 0; // 선택한 영화의 테두리 값을 1로 설정

                // 테두리 값을 업데이트하고 그래프를 업데이트합니다.
                salesShareChart.data.datasets[0].borderWidth = borderWidths;
                salesShareChart.update();
            }
        }



        // 원형 그래프 생성
        var salesShareChart = createDoughnutChart();
    
    </script>
    <footer>
        <div id="bottom">
            <jsp:include page="loadFile/bottom.jsp" />
        </div>
    </footer>
</body>
</html>