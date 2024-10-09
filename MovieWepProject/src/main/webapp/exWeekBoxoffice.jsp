<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
    import="boxOffice.*, Office.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<!-- 부트스트랩넣고 작업중 -->
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
    <button id="getDataBtn" type="button" class="btn btn-outline-primary btn-sm">조회</button>
    <div class="alert alert-warning alert-dismissible fade show" id="dataAlert" style="display: none;" role="alert">
    날짜를 확인 해주세요.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>

    <div>
        <div>
        <span id="selectedDate"></span>
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
	<div>
	<button id="downloadButton" style="display: none;">엑셀 파일 다운로드</button>
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
                var targetDateSource = $('#targetDate').val();
                
             // 선택한 날짜를 가져와서 처리
                var selectedDate = $('#targetDate').val(); // 이 부분은 이미 코드에 있습니다.

                // getWeekInfo 함수를 사용하여 정보 가져오기
                var weekInfo = getWeekInfo(selectedDate);

                // 결과 출력
                console.log('Week Number: ' + weekInfo.weekNumber);
                console.log('Start Date: ' + weekInfo.startDate.toISOString().split('T')[0]);
                console.log('End Date: ' + weekInfo.endDate.toISOString().split('T')[0]);
                
                
                if (targetDate) {
                    $.ajax({
                        url: 'WeekBoxDataServlet?targetDate=' + targetDate,
                        method: 'GET',
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                        	if (data.length > 0) {
                                receivedData = data;
                                console.log(data);
                                displayMovieData(data);
                                $('#movieData').show();
                                $('#downloadButton').show();
                                $('#dataAlert').hide();
                                $('#selectedDate').text(weekInfo.weekNumber + '주 ' + weekInfo.startDate.toISOString().split('T')[0] + ' ~ ' + weekInfo.endDate.toISOString().split('T')[0]);
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
            
            function getWeekInfo(selectedDate) {
                var dateObject = new Date(selectedDate);

                // 몇 번째 주인지 확인
                function getWeekNumber(d) {
                    d = new Date(d);
                    d.setHours(0, 0, 0);
                    d.setDate(d.getDate() + 4 - (d.getDay() || 7));
                    var yearStart = new Date(d.getFullYear(), 0, 1);
                    var weekNumber = Math.ceil(((d - yearStart) / 86400000 + 1) / 7);
                    return weekNumber;
                }

                var weekNumber = getWeekNumber(dateObject);

                // 해당 주의 시작 날짜 계산
                var startDate = new Date(dateObject);
                startDate.setDate(dateObject.getDate() - dateObject.getDay()); // 해당 주의 첫 번째 날

                // 해당 주의 끝 날짜 계산
                var endDate = new Date(startDate);
                endDate.setDate(startDate.getDate() + 6); // 해당 주의 마지막 날

                return {
                    weekNumber: weekNumber,
                    startDate: startDate,
                    endDate: endDate,
                };
            }



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
           // $('#getDataBtn').trigger('click');
            
        });
    </script>
</body>
</html>
