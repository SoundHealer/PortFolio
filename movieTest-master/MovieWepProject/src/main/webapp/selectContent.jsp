<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>선택된 내용</title>
</head>
<body>
    <h2>선택된 내용</h2>
    
    <% 
        String content = request.getParameter("content");
        if (content != null) {
    %>
    <p>선택한 날짜: <%= content %></p>
    <!-- 선택한 날짜에 따른 내용을 표시할 부분을 추가 -->
    <%
        } else {
    %>
    <p>선택된 내용이 없습니다.</p>
    <%
        }
    %>
</body>
</html>
