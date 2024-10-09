<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
</head>
<body>
    <h1>Main Page</h1>
    
    <!-- "dateInputForm.jsp" 파일을 포함 -->
    <jsp:include page="selectDate.jsp" />

    <script>
        var selectedDate; // 선택한 날짜를 저장할 JavaScript 변수

        // "dateInputForm.jsp"에서 선택한 날짜를 가져와 JavaScript 변수에 할당
        function setSelectedDate(date) {
            selectedDate = date;
            alert(selectedDate);
        }

        // 선택한 날짜를 사용할 예제
        function selectedDate() {
            if (selectedDate) {
                alert("선택한 날짜: " + selectedDate);
                // 여기에서 선택한 날짜를 사용하실 수 있습니다.
            } else {
                alert("날짜를 먼저 선택하세요.");
            }
        }
    </script>
</body>
</html>
