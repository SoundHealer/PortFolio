<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
    import="boxOffice.*, Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<!-- css작업시작 -->
<html>
<head>
    <title>Box Office Data</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- Bootstrap 5 JavaScript 링크 추가 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
  	rel="stylesheet">
  	<link rel="stylesheet" href="resource/css/styles1.css">
    <style>
    #movieDataBody tr {
    cursor: pointer;
	}
	#titleDiv {
	display:flex;
	margin-top:20px;
	justify-content: center;
	}
	.nemo-box {
            width: 70%; /* 테이블과 같은 길이로 설정 */
		    max-width: 80%; /* 테이블과 동일한 최대 너비로 설정, 필요에 따라 조절 가능 */
		    height: 10%; /* 테이블과 같은 높이로 설정 */
		    margin: 20px auto; /* 가운데 정렬 및 위아래 여백 조절 */
		    background-color: #f0f0f0; /* 배경 색상 */
		    padding: 10px; /* 내부 여백 */
		    font-size: 13px;
        }
    #downloadButton{
    margin-left:10px;
    }
	#calendarDiv{
	display:flex;
	justify-content: center;
	}
	#calLabel{
	margin-right: 20px;
	}
	#targetDate{
	margin-right : 10px;
	}
	#seleDate{
	display:flex;
	justify-content: center;
	margin:20px;
	border-top: 1px solid #000;
	border-bottom:1px solid #000;
	}
	#posterDiv{
	display: flex;
  	justify-content: center; /* 가로 중앙 정렬 */
  	align-items: center; 
	}
	#detailDiv{
	display: flex;
	min-width: 255px;
	flex-direction: column;
  	justify-content: center; /* 가로 중앙 정렬 */
  	
	}
	#firstDiv{
	display:flex;
	justify-content: center; /* 수평 가운데 정렬 */
    width: 100%; /* 가로로 100% 크기 */
	}
	#secondDiv {
	    display: flex;
	}
	#graphDiv{
	display:flex;
	justify-content: center; /* 수평 가운데 정렬 */
    width: 100%; /* 가로로 100% 크기 */
    height:30%;
    margin: 60px;
	}
	#barDiv{
	width:30vw;
	height: 30vw;
	margin-right:100px;
	}
	#pieDiv{
	width:30vw;
	height: 30vw;
	}
	#fileDiv {
	display:flex;
	
	margin-top:20px;
	justify-content: center;
	width : 70%;
	}

    </style>
</head>
<body>
	<header>
		<div id="top">
			<!-- 다운후 변경 -->
			<jsp:include page="loadFile/top.jsp" />
			<jsp:include page="loadFile/menuBar.jsp" />
		</div>
	</header>
	<div id="titleDiv">
	<h1 class="display-5"><hr class="titleHr">일별 박스오피스<hr class="my-2"></h1>
	</div>
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
    <div id = "calendarDiv">
    <label for="targetDate" id="calLabel">날짜 선택 </label>
    <input type="date" id="targetDate" name="targetDate">
    <button id="getDataBtn" type="button" class="btn btn-outline-primary btn-sm">조회</button>
    <button id="downloadButton" class="btn btn-outline-primary btn-sm" style="display: none;">엑셀 파일 다운로드</button>
    <div class="alert alert-warning alert-dismissible fade show" id="dataAlert" style="display: none;" role="alert">
    날짜를 확인 해주세요.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
	</div>
	<div id = "seleDate" style="display: none;">
	<strong><span id="selectedDate"></span></strong>
	</div>
    <div id = "firstDiv">
        <div id = "secondDiv">
           	<div id = "posterDiv">
                <img id="posterImage" style="display: none; min-height:400px; min-width: 270px; max-width: 270px; max-height: 400px;"/>
            </div>
            <div id = "detailDiv">
                <div>
                    <h2 id="movieName" style="display: none;"></h2>
                    <hr class="movieNameHr" style="display: none;">    
                </div>
                <div id="directorDiv" style="display: none;">
                    <p>
                        <strong>감독</strong>
                        <span id="director"></span>
                    </p>
                    <p>
                        <strong>개봉일</strong>
                        <span id="openDate"></span>
                    </p>
                    <p>
                        <strong>관람등급</strong>
                        <span id="watchGrade"></span>
                    </p>
                    <p>
                        <strong>상영시간</strong>
                        <span id="showTm"></span>
                    </p>
                    <p>
                        <strong>제작국가</strong>
                        <span id="nation"></span>
                    </p>
                    <p>
                        <strong>제작상태</strong>
                        <span id="productionStatus"></span>
                    </p>
                </div>
            </div>
        </div>
        <div id="movieData" style="display: none;">
            <table class="table">
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
    <div id="graphDiv">
	    <div id ="barDiv">
		    <canvas id="salesChart" style="width: 100%; height: 100%;"></canvas>
		</div>
		<div id ="pieDiv">
		    <canvas id="salesShareChart" style="width: 100%; height: 100%;"></canvas>
		</div>
	</div>
	<footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>

    <script>
    var selectedMovieName = null; // selectedMovieName 변수 초기화
    
        $(document).ready(function () {
            var salesChart; // 막대 그래프 인스턴스를 저장할 변수
            var salesShareChart; // 원 그래프 인스턴스를 저장할 변수
         // 날짜 필드의 값을 가져옵니다.
            var targetDate = $('#targetDate').val();
            var targetDateSource = $('#targetDate').val();

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
                var targetDateSource = $('#targetDate').val();
                var result = targetDateSource + "일 박스오피스";
                console.log(result); // 또는 필요한 곳에서 결과를 사용
                if (targetDate) {
                    $.ajax({
                        url: 'movieDataServlet?targetDate=' + targetDate,
                        method: 'GET',
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                        	if (data.length > 0) {
                                receivedData = data;
                                console.log(data);
                                displayMovieData(data);
                                $('#seleDate').show();
                                $('#movieData').show();
                                $('.movieNameHr').show();
                                $('#downloadButton').show();
                                $('#dataAlert').hide();
                                $('#selectedDate').text(result);
                                
                            } else {
                                $('#dataAlert').show();
                            }
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
             	
				if (movieName.length > 8) {
				    TitleName = movieName.substring(0, 8) + '...';
				    $('#movieName').text(TitleName).show();
				}else{
				$('#movieName').text(movieName).show();
				}
				
				if (director.length > 8) {
				    TitleDirector = director.substring(0, 8) + '...';
				    $('#director').text(TitleDirector).show();
				}else{
				$('#director').text(director).show();
				}
                
                $('#openDate').text(openDate);
                $('#watchGrade').text(watchGrade);
                $('#showTm').text(showTm);
                $('#nation').text(nation);
                $('#productionStatus').text(productionStatus);
                // 추가 정보를 나타내는 div를 보이도록 설정
                $('#directorDiv').show();
            });
            
            $('#downloadButton').click(function () {
            	var ButtonDate = $('#targetDate').val();
                console.log(receivedData);

                if (receivedData && receivedData.length > 0) {
                    var excelData = [];
                    for (var i = 0; i < receivedData.length; i++) {
                        var movie = receivedData[i];
                        var movieRow = {
                        	"순위": movie.rank,
                            "영화명": movie.movieNm,
                            "개봉일": movie.openDt,
                            "당일 매출액": movie.salesAmt,
                            "당일 매출액 점유율(%)": movie.salesShare,
                            "전일대비 매출액 즘강율(%)": movie.salesChange,
                            "누적 매출액": movie.salesAcc,
                            "당일 관객 수": movie.audiCnt,
                            "전일 대비 관객수 증감 비율":movie.audiChange,
                            "누적 관객 수":movie.audiAcc,
                            "감독": movie.directors.join(', '), // 감독 정보 추가
                            "상영 시간(분)":movie.showTm,
                            "제작 국가":movie.nationNm,
                            "제작 상태":movie.prdtStatNm,
                            "관람 등급":movie.watchGradeNm,
                            // 필요한 속성을 추가하세요
                        };
                        excelData.push(movieRow);
                    }

                    // 데이터를 XLSX 워크시트로 변환합니다.
                    var ws = XLSX.utils.json_to_sheet(excelData);
                    ws['!cols'] = [{ wch: 7 }, { wch: 35 }, { wch: 10 }, { wch: 8 }, { wch: 8 }, { wch: 8 }, { wch: 12 }, { wch: 11 }, { wch: 12 }, { wch: 14 }, { wch: 14 }, { wch: 11 }, { wch: 10 }];

                    // XLSX 워크북을 만들고 워크시트를 추가합니다.
                    var workbook = XLSX.utils.book_new();
                    
                    var title = ButtonDate + " 박스 오피스 일간 데이터"; // 제목 생성
                    XLSX.utils.book_append_sheet(workbook, ws, title);

                    // 워크북을 Excel 파일로 저장합니다.
                    XLSX.writeFile(workbook, title+".xlsx");
                } else {
                    alert("내보낼 영화 데이터가 없거나 데이터를 먼저 가져와야 합니다.");
                }
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
                            label: '매출액',
                            data: data,
                            backgroundColor: labels.map(label => (label === selectedMovieName) ? 'red' : 'rgba(75, 192, 192, 0.2)'),
                            borderColor: 'rgba(0, 0, 0, 0.25)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        },
                        plugins: {
                            legend: {
                                display: false // 라벨 숨김
                            }
                        },
                        maintainAspectRatio: false // 가로-세로 비율 유지하지 않음
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
                    },
                    options:{ 
                        plugins:{
                            legend: {
                                display: false
                            },
                        }
                    }
                });
            }
            
            
            //자동실행구문
            $('#getDataBtn').trigger('click');
            
        });
    
    </script>
</body>
</html>
