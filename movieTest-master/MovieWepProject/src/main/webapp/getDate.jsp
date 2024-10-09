<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>날짜 확인</title>
</head>
<body>
    <h1>날짜 확인</h1>
    
    <% 
        String selectedDate = request.getParameter("selectedDate");
        String formattedDate = ""; // 날짜 형식을 변환할 변수

        // selectedDate를 (yyyy/mm/dd) 형식으로 변환
        if (selectedDate != null && !selectedDate.isEmpty()) {
            String[] dateParts = selectedDate.split("-");
            if (dateParts.length == 3) {
                formattedDate = dateParts[0] + "/" + dateParts[1] + "/" + dateParts[2];
            }
        }
    %>
    
    <p>선택한 날짜: <%= formattedDate %></p>
</body>
</html>
