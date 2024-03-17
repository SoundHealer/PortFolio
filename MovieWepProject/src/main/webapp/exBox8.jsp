<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
    import="boxOffice.*, Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<!-- 기능 다 넣고 css 작업전 코드 -->
<html>
<head>
    <title>Box Office Data</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    #movieDataBody tr {
    cursor: pointer;
	}
    </style>
</head>
<body>
    <h1>Box Office Data1</h1>
    <label for="targetDate">날짜 선택 (YYYYMMDD):</label>
    <input type="date" id="targetDate" name="targetDate">
    <button id="getDataBtn">데이터 가져오기</button>
    <div>
        <div>
            <div>
                <img id="posterImage" style="display: none; max-width: 100%;" />
            </div>
            <div>
                <div>
                    <h2 id="movieName" style="display: none;"></h2>
                </div>
                <div id="directorDiv" style="display: none;">
                    <p>
                        감독:
                        <span id="director"></span>
                    </p>
                    <p>
                        <strong>개봉일</strong>
                        <span id="openDate"></span>
                    </p>
                    <p>
                        관람등급:
                        <span id="watchGrade"></span>
                    </p>
                    <p>
                        상영시간:
                        <span id="showTm"></span>
                    </p>
                    <p>
                        제작국가:
                        <span id="nation"></span>
                    </p>
                    <p>
                        제작상태:
                        <span id="productionStatus"></span>
                    </p>
                </div>
            </div>
        </div>
        <div id="movieData" style="display: none;">
            <table>
                <thead>
                    <tr>
                        <th>랭킹</th>
                        <th>영화 제목</th>
                        <th>관객수</th>
                        <th>매출액</th>
                        <th>랭킹 증감분</th>
                    </tr>
                </thead>
                <tbody id="movieDataBody">
                </tbody>
            </table>
        </div>
    </div>
    <div>
	    <div style="width: 50%; height: 50%;">
		    <canvas id="salesChart" style="width: 100%; height: 100%;"></canvas>
		</div>
		<div style="width: 40%; height: 60%;">
		    <canvas id="salesShareChart" style="width: 100%; height: 100%;"></canvas>
		</div>
	</div>

    <script>
    var selectedMovieName = null; // selectedMovieName 변수 초기화
    
        $(document).ready(function () {
            var salesChart; // 막대 그래프 인스턴스를 저장할 변수
            var salesShareChart; // 원 그래프 인스턴스를 저장할 변수
         // 날짜 필드의 값을 가져옵니다.
            var targetDate = $('#targetDate').val();

            // 만약 날짜 필드가 비어 있다면 어제 날짜를 설정합니다.
            if (targetDate === "") {
                // 오늘 날짜를 얻습니다.
                var today = new Date();

                // 어제 날짜를 계산합니다.
                var yesterday = new Date(today);
                yesterday.setDate(today.getDate() - 1);

                // 어제 날짜를 "YYYY-MM-DD" 형식의 문자열로 변환합니다.
                var yesterdayString = yesterday.toISOString().split('T')[0];

                // 어제 날짜를 입력 필드에 설정합니다.
                $('#targetDate').val(yesterdayString);
                
            }
            
            $('#getDataBtn').click(function () {
                var targetDate = $('#targetDate').val().replace(/-/g, ''); // "-" 문자 제거
                if (targetDate) {
                    $.ajax({
                        url: 'movieDataServlet?targetDate=' + targetDate,
                        method: 'GET',
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            console.log(data);
                            displayMovieData(data);
                            $('#movieData').show();
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
            	
            	$('#movieDataBody tr').css('background-color', 'transparent');

                $(this).css('background-color', 'rgba(134,142,150,0.2)');


                var posterUrl = $(this).data('poster');
                var movieName = $(this).data('name');
                selectedMovieName = movieName;
                updateBarColor(selectedMovieName);
                updateDoughnutChart(selectedMovieName);
                
                var director = $(this).data('director');
                var openDate = $(this).data('opendate');
                var watchGrade = $(this).data('watchgrade');
                var showTm = $(this).data('showtm');
                var nation = $(this).data('nation');
                var productionStatus = $(this).data('productionstatus');
                var rankOldAndNew = $(this).data('rankoldandnew');
                
             // posterUrl이 정의되어 있는지 확인한 후 src 속성을 설정합니다.
                if (posterUrl!=undefined) {
                    $('#posterImage').attr('src', posterUrl);
                    $('#posterImage').show();
                    console.log(posterUrl);
                } else {
                    // posterUrl이 정의되지 않은 경우 기본 이미지를 설정하거나 이미지를 숨깁니다.
                    $('#posterImage').attr('src', 'resource/images/흑백로고.png'); // 기본 이미지 경로로 바꿔주세요
                    // 원하는 경우 이미지를 숨기는 대신 기본 이미지를 설정할 수 있습니다.
                    $('#posterImage').hide();
                }
             // 	alert("dsadsa"+(movie.posterUrl === undefined));
                $('#movieName').text(movieName).show();
                $('#director').text(director);
                $('#openDate').text(openDate);
                $('#watchGrade').text(watchGrade);
                $('#showTm').text(showTm);
                $('#nation').text(nation);
                $('#productionStatus').text(productionStatus);
                // 추가 정보를 나타내는 div를 보이도록 설정
                $('#directorDiv').show();
            });
            
            

            function displayMovieData(data) {
                var tableBody = $('#movieDataBody');
                tableBody.empty();
                var salesData = [];
                var labels = [];
                var salesShare = [];
                for (var i = 0; i < data.length; i++) {
                    var movie = data[i];
                    var audiCntWithCommas = formatNumberWithCommas(movie.audiCnt);
                    var salesAmtWithCommas = formatNumberWithCommas(movie.salesAmt);
                    
                    var arrowIcon = ''; // Initialize arrow icon
                    var arrowColor = ''; // Initialize arrow color

                    if (movie.rankOldAndNew === 'OLD') {
                        if (movie.rankInten < 0) {
                            arrowIcon = '<span style="color: blue">▼</span>'; // Negative rankInten, display blue down arrow
                        } else if (movie.rankInten > 0) {
                            arrowIcon = '<span style="color: red">▲</span>'; // Positive rankInten, display red up arrow
                        } else if (movie.rankInten == 0) {
                            arrowIcon = '─'; // No action for rankInten = 0
                        }
                    } else if (movie.rankOldAndNew === 'NEW') {
                        arrowIcon = movie.rankOldAndNew; // Display 'NEW' for rankOldAndNew
                        arrowColor = 'rgb(255, 150, 20)';
                    }

                    var rankInfo;
                    if (movie.rankOldAndNew === 'OLD') {
                        if (movie.rankInten == 0) {
                            rankInfo = arrowIcon;
                        } else {
                            rankInfo = arrowIcon + ' ' + Math.abs(movie.rankInten);
                        }
                    } else if (movie.rankOldAndNew === 'NEW') {
                        rankInfo = movie.rankOldAndNew;
                    }
 
                   	var posterEx = "";
                   	if(movie.posterUrl==""||movie.posterUrl === undefined){
                   		posterEx='resource/images/흑백로고.png';
                   	}else{posterEx=movie.posterUrl;}
                    var row = '<tr data-poster="' + posterEx +
                        '" data-name="' + movie.movieNm +
                        '" data-director="' + movie.directors.join(', ') +
                        '" data-opendate="' + movie.openDt +
                        '" data-watchgrade="' + movie.watchGradeNm +
                        '" data-showtm="' + movie.showTm +
                        '" data-nation="' + movie.nationNm +
                        '" data-productionstatus="' + movie.prdtStatNm +
                        '">' +
                        '<td>' + movie.rank + '</td>' +
                        '<td>' + movie.movieNm + '</td>' +
                        '<td>' + audiCntWithCommas + '</td>' + // 관객수에 천 단위 쉼표 추가
                        '<td>' + salesAmtWithCommas + '</td>' +
                        '<td style="color:' + arrowColor + ';">' + rankInfo + '</td>' +
                        '</tr>';

                    tableBody.append(row);
                    salesData.push(movie.salesAmt);
                    labels.push(movie.movieNm);
                    salesShare.push(movie.salesShare);
                }
                createSalesChart(salesData, labels);
                createSalesShareChart(salesShare, labels);
                tableBody.find('tr:first').trigger('click');
            }
            
            function formatNumberWithCommas(number) {
                return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            
            function updateBarColor(movieName) {
                if (salesChart) {
                    salesChart.data.datasets[0].backgroundColor = salesChart.data.labels.map(label => {
                        return label === movieName ? 'red' : 'rgba(75, 192, 192, 0.2)';
                    });
                    salesChart.update();
                }
            }
            function updateDoughnutChart(movieName) {
                if (salesShareChart) {
                    salesShareChart.data.datasets[0].backgroundColor = salesShareChart.data.labels.map(label => {
                        return label === movieName ? 'red' : 'rgba(75, 192, 192, 0.2)';
                    });
                    salesShareChart.update();
                }
            }


            function createSalesChart(data, labels) {
                if (salesChart) {
                    salesChart.destroy();
                }

                var ctx = document.getElementById('salesChart').getContext('2d');
                salesChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '매출액321',
                            data: data,
                            backgroundColor: labels.map(label => (label === selectedMovieName) ? 'red' : 'rgba(75, 192, 192, 0.2)'),
                            borderColor: 'rgba(255, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }


            function createSalesShareChart(data, labels) {
                if (salesShareChart) {
                    salesShareChart.destroy(); // 현재 원 그래프가 있으면 파괴
                }

                var ctx = document.getElementById('salesShareChart').getContext('2d');
                salesShareChart = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '매출 점유율',
                            data: data,
                            backgroundColor: [
                                'rgba(75, 192, 192, 0.2)'
                            ],
                            borderColor: [
                                'rgba(0, 0, 0, 0.25)'
                            ],
                            borderWidth: 3
                        }]
                    }
                });
            }
            //자동실행구문
            //$('#getDataBtn').trigger('click');
        });
    </script>
</body>
</html>
