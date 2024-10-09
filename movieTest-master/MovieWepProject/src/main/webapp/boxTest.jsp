<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*, java.util.List, java.util.ArrayList, java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <title>날짜 선택 및 변환</title>
    <style>
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
		    max-width: 70%; /* 테이블 너비를 100%로 변경 */
		    margin: 20px auto; /* 테이블 위 아래 여백 조정 */
		}
		
		.table-container table td:nth-child(2) {
		    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
		    overflow: hidden;
		    text-overflow: ellipsis; /* 텍스트가 너무 길 경우 생략 (...) 표시 */
		    max-width: 200px; /* 최대 너비 설정, 필요에 따라 조절하세요 */
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
    <div class="DateCon">
        <form id="abc" >
            <label for="startDate"></label>
            <input type="date" id="startDate" name="startDate">
            <label for="endDate"></label>
            <input type="date" id="endDate" name="endDate">
            <input type="submit" value="조회" id="submitButton" onclick="validateDateRange()">
        </form>
        
        <%
        
        
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");
        
        if (startDateParam != null && !startDateParam.trim().isEmpty() &&
            endDateParam != null && !endDateParam.trim().isEmpty()) {
            LocalDate startDate = LocalDate.parse(startDateParam);
            LocalDate endDate = LocalDate.parse(endDateParam);

            if (startDate.isBefore(endDate) || startDate.isEqual(endDate)) {
                // Iterate through the date range and fetch data for each date
                LocalDate currentDate = startDate;
                while (!currentDate.isAfter(endDate)) {
                    String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                    String formattedDateDisplay = currentDate.format(DateTimeFormatter.ofPattern("yyyy년 M월 d일"));
                    List<datamovie> dataForDate = Dayboxoffice.fetchDataByDate(formattedDate);
        %>
        <div class="table-container">
            <div class="date-header"><%= formattedDateDisplay %></div>
            <table border="1">
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
                    <td><%= cinema.getSalesAmt() %></td>
                    <td><%= cinema.getSalesInten() %></td>
                    <td><%= cinema.getSalesShare() %></td>
                    <td><%= cinema.getAudiCnt() %></td>
                    <td><%= cinema.getAudiInten() %></td>
                    <td><%= cinema.getSalesAcc() %></td>
                    <td><%= cinema.getAudiAcc() %></td>
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
        else{
        	
            java.util.Date currentDateServer = new java.util.Date(); //자바에서 현재서버 시간 들고오기
            

            %>
            <script>
        	 // 서버에서 가져온 현재 날짜를 로컬 시간대로 변환
        	var serverDate = new Date('<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(currentDateServer) %>');
        	
        	// 7일 전 날 계산
        	var sevenDaysAgoDate = new Date(serverDate);
        	sevenDaysAgoDate.setDate(serverDate.getDate() - 7);
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
    </div>
    <script>
    
    
        // 초기 정렬 상태
        var ascending = true;
    
        // 정렬 버튼에 대한 이벤트 리스너 설정
        var upButtons = document.querySelectorAll('.btn_up01');
        var downButtons = document.querySelectorAll('.btn_dw01');
    
        upButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                sortTable(button.closest('table'), ascending);
                ascending = !ascending; // 정렬 상태 변경
            });
        });
    
        downButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                sortTable(button.closest('table'), !ascending);
                ascending = !ascending; // 정렬 상태 변경
            });
        });
    
        // 테이블을 정렬하는 함수
        function sortTable(table, ascending) {
            var rows = table.rows;
            var switching = true;
    
            while (switching) {
                switching = false;
    
                for (var i = 1; i < rows.length - 1; i++) {
                    var shouldSwitch = false;
                    var x = rows[i].getElementsByTagName('td')[0]; // 순위 열
    
                    var y = rows[i + 1].getElementsByTagName('td')[0]; // 다음 행의 순위 열
    
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
        }
        
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