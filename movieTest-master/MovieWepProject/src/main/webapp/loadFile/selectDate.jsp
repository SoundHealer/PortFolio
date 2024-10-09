<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>날짜 입력 폼</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<%
//param_date
String param_date = request.getParameter("param_date");
param_date = param_date == null ? "" : param_date;
String year = "1900";
String month = "1";
String day = "1";
if (!param_date.equals("")) {
	year = param_date.split("-")[0];
	month = param_date.split("-")[1];
	day = param_date.split("-")[2];
}
%>
</head>
<body>
	<div class="input-group">
		<select class="form-control" id="year" name="year">
			<%
			for (int i = 1900; i <= 2023; i++) {
				String select = "";
				if ((i + "").equals(year))
					select = "selected";
			%>
			<option value="<%=i%>" <%=select%>><%=i%>년
			</option>
			<%
			}
			%>
		</select>
		<select class="form-control" id="month" name="month">
			<%
			for (int i = 1; i <= 12; i++) {
				String select = "";
				if ((i + "").equals(month))
					select = "selected";
			%>
			<option value="<%=i%>" <%=select%>><%=i%>월
			</option>
			<%
			}
			%>
		</select>
		<select class="form-control" id="day" name="day">
			<option value="1">1일</option>
		</select>
	</div>
	<script>
    
        var yearDropdown = document.getElementById("year");
        var monthDropdown = document.getElementById("month");
        var dayDropdown = document.getElementById("day");

        monthDropdown.addEventListener("change", function() {
        	setDayList();
        });
		
        function setDayList(){
        	var selectedYear = yearDropdown.value;
            var selectedMonth = monthDropdown.value;
            var daysInMonth = new Date(selectedYear, selectedMonth, 0).getDate();

            dayDropdown.innerHTML = "";
            var farm_day = "<%=day%>";
			for (var day = 1; day <= daysInMonth; day++) {
				var option = document.createElement("option");
				option.value = day;
				option.text = day + "일";
				if (farm_day == day) {
					option.selected = true;
				} else{
					option.selected = false;
				}

				dayDropdown.appendChild(option);
			}
		}
		setDayList();
		// 날짜 선택 버튼 클릭 시, 선택한 날짜를 JavaScript 함수로 전달
		document.getElementById("submitBtn").addEventListener(
				"click",
				function() {
					var selectedYear = yearDropdown.value;
					var selectedMonth = monthDropdown.value;
					var selectedDay = dayDropdown.value;
					var selectedDate = selectedYear + "-" + selectedMonth + "-"
							+ selectedDay;

					// 선택한 날짜를 JavaScript 함수로 전달

				});
	</script>
</body>
</html>
