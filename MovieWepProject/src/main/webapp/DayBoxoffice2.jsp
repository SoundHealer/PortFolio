<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

    <title>날짜 선택 및 변환</title>
    <style>
    	
    	.nemo-box {
            width: auto; /* 테이블과 같은 길이로 설정 */
		    max-width: 80%; /* 테이블과 동일한 최대 너비로 설정, 필요에 따라 조절 가능 */
		    height: 10%; /* 테이블과 같은 높이로 설정 */
		    margin: 20px auto; /* 가운데 정렬 및 위아래 여백 조절 */
		    background-color: #f0f0f0; /* 배경 색상 */
		    padding: 10px; /* 내부 여백 */
		    
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

        @keyframes spin {
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
            background-color: #f2f2f2;
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
    </style>
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
        [박스오피스]코너는 실시간 발권데이터를 전일기준까지 반영하여 일별/주간/주말/기간별 등 각종 통계정보를 제공합니다.

매일 24시 이후 전환/제공되는 [전일자 통계정보]는 상영마감 및 보정처리 등의 사유로 익일 오전까지 계속 업데이트 되며, 일마감 후 데이터보정 등의 사유로 통계정보는 변동 될 수 있음을 참고하시기 바랍니다.

통계이용안내

① [박스오피스], [테마통계]코너는 연도별 영화상영관 연동율에 따라 실시간 수집된 발권데이터를 전일기준까지 반영한 통계정보입니다.

② [공식통계]코너는 영진위에서 매년 발표하는 “한국영화연감”의 영화별 흥행기록을 참고한 것입니다.

한국영화연감(1971~2010) 통계를 기준으로 정리한 것이며, 2011년부터는 통합전산망을 기준으로 일정한 주기(매월, 매년)로 마감 처리하여 산출되는 통계정보입니다.

통계마감 주기(월별, 년별)에 따라 공식통계 수치는 추후 변동될 수 있습니다.
    </div>
    <div class="loading" id="loading">
        <div class="loading-content">
            <div class="spinner"></div>
            <p>로딩 중...</p>
        </div>
    </div>

    <div class="DateCon">
        <form id=abc>
            <label for="startDate"></label>
            <input type="date" id="startDate" name="startDate">
            <label for="endDate"></label>
            <input type="date" id="endDate" name="endDate">
            <input type="submit" value="조회" id="submitButton" onclick="validateDateRange()">
        </form>
        <%
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");
        String startDateInput = null;
        String endDateInput = null;

        if (startDateParam != null && !startDateParam.trim().isEmpty()) {
           	LocalDate startDate = LocalDate.parse(startDateParam);
            LocalDate previousStartDate = startDate.minusDays(1); // 현재 날짜에서 하루를 뺀 날짜 계산
            startDateInput = previousStartDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            System.out.println(startDate);
            System.out.println(startDateInput);
            
        }

        if (endDateParam != null && !endDateParam.trim().isEmpty()) {
            LocalDate endDate = LocalDate.parse(endDateParam);
            LocalDate previousEndDate = endDate.minusDays(1); // 현재 날짜에서 하루를 뺀 날짜 계산
            endDateInput = previousEndDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            System.out.println(endDate);
            System.out.println(endDateInput);
        }
        
        
            		
        if (startDateParam != null && !startDateParam.trim().isEmpty() &&
            endDateParam != null && !endDateParam.trim().isEmpty()) {
            LocalDate startDate = LocalDate.parse(startDateParam);
            LocalDate endDate = LocalDate.parse(endDateParam);
            LocalDate previousStartDate = LocalDate.parse(startDateInput);
            LocalDate previousEndDate = LocalDate.parse(endDateInput);

            if (startDate.isBefore(endDate) || startDate.isEqual(endDate)) {
                // Iterate through the date range and fetch data for each date
                if (startDate.isBefore(endDate) || startDate.isEqual(endDate)) {
                        // 데이터 로딩 시작 시 로딩 화면 표시
       %>
        <script>
            document.getElementById("loading").style.display = "block";
        </script>
        <%
                LocalDate currentDate = startDate;
        		LocalDate previousDate = previousStartDate;
                while (!currentDate.isAfter(endDate)) {
                    String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                    //데이터-1날짜
                    String formattedPreivousDate = previousDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                    String formattedDateDisplay = currentDate.format(DateTimeFormatter.ofPattern("yyyy년 M월 d일"));
                    List<datamovie> dataForDate = Dayboxoffice.fetchDataByDate(formattedDate);   
                    List<datamovie> previousforDate =  Dayboxoffice.fetchDataByDate(formattedPreivousDate);
        %>
        <div class="table-container">
            <div class="date-header"> <%= formattedDateDisplay %></div>
            <table class="sortable-table" border="1">
                <tr>
                    <th scope="col">
                    순위
                    <span class="btn_updwBox">
                        <button name="btn4_up" type="button" class="btn_up01">
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
                    currentDate = currentDate.plusDays(1); // Move to the next date
                }
            } 
        }
     }
		else{
        	
            java.util.Date currentDateServer = new java.util.Date(); //자바에서 현재서버 시간 들고오기
            

            %>
            <script>
        	 // 서버에서 가져온 현재 날짜를 로컬 시간대로 변환
        	var serverDate = new Date('<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(currentDateServer) %>');
        	
        	// 7일 전 날 계산
        	var sevenDaysAgoDate = new Date(serverDate);
        	sevenDaysAgoDate.setDate(serverDate.getDate() - 3);
        			 // 하루 전 날 계산
        	var yesterdayDate = new Date(serverDate);
        	yesterdayDate.setDate(serverDate.getDate() - 1);
        			 // 조회 버튼 클릭 이벤트 리스너 추가
        		document.getElementById("submitButton").addEventListener("click", function() {
        	    displaySelectedDates(); // 날짜 출력 함수 호출
        	});
        	
        	// 시작 날짜와 종료 날짜 input 요소에 값을 설정
        	document.getElementById("startDate").valueAsDate = sevenDaysAgoDate;
        	document.getElementById("endDate").valueAsDate = yesterdayDate;
        	
        	document.getElementById("abc").submit();
        	
        	
        	
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
    
        // 테이블을 정렬 및 천 단위 쉼표 추가하는 함수
        function processTable(table, ascending) {
            var rows = Array.from(table.querySelectorAll('tbody tr'));
    
            // 정렬 기준 열 선택 (예: 순위 열)
            var columnIndex = 0; // 순위 열에 해당하는 열 번호
            var sortByColumn = (a, b) => {
                var aValue = parseInt(a.children[columnIndex].innerText);
                var bValue = parseInt(b.children[columnIndex].innerText);
                return ascending ? aValue - bValue : bValue - aValue;
            };
    
            // 테이블 정렬
            rows.sort(sortByColumn);
            rows.forEach((row) => table.querySelector('tbody').appendChild(row));
    
            // 천 단위 쉼표 추가 함수
            function addCommasToData(dataElements) {
                dataElements.forEach(function (element) {
                    var dataValue = parseInt(element.innerText);
                    element.innerText = dataValue.toLocaleString();
                });
            }
    
            // 정렬 버튼 클릭 이벤트 설정
            var sortButtons = table.querySelectorAll('.btn_updwBox button');
            sortButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    ascending = !ascending; // 정렬 상태 변경
                    processTable(table, ascending);
                });
            });
    
            // 천 단위 쉼표를 추가할 열 선택 및 처리
            var columnsToAddCommas = table.querySelectorAll('.salesAmt, .salesInten, .salesAcc, .audiAcc');
            addCommasToData(columnsToAddCommas);
        }
    
        // 초기 페이지 로드 시 모든 테이블에 대해 정렬 함수 호출
        var sortableTables = document.querySelectorAll('.sortable-table');
        sortableTables.forEach(function (table) {
            processTable(table, true); // 초기에 오름차순 정렬
        });
    
        function validateDateRange() {
            var startDate = new Date(document.getElementById('startDate').value);
            var endDate = new Date(document.getElementById('endDate').value);
            var oneWeek = 7 * 24 * 60 * 60 * 1000; // 1주일을 밀리초로 표현
    
            var timeDifference = endDate - startDate;
    
            if (timeDifference > oneWeek) {
                alert('날짜 범위가 1주일을 넘을 수 없습니다.');
                event.preventDefault(); // 폼 제출을 막습니다.
            }
        }
        
        
    </script>
    <footer>
        <div id="bottom">
            <jsp:include page="loadFile/bottom.jsp" />
        </div>
    </footer>
</body>
</html>