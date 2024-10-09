<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MySQL 연동 예제</title>
</head>
<body>
    <h1>MySQL 연동 예제</h1>
    
    <% 
        // MySQL 연결 정보 설정
        String url = "jdbc:mysql://localhost:3306/moviedb";
        String username = "root";
        String password = "0000";
        
        // MySQL JDBC 드라이버 클래스 로드
        Class.forName("com.mysql.jdbc.Driver");
        
        // 데이터베이스 연결
        Connection connection = DriverManager.getConnection(url, username, password);
        
        // SQL 쿼리 실행
        Statement statement = connection.createStatement();
        String query = "SELECT * FROM moviedb.cinema";
        ResultSet resultSet = statement.executeQuery(query);
        
        // 결과 출력
        while (resultSet.next()) {
            String column1 = resultSet.getString("name");
            String column2 = resultSet.getString("address");
            // 원하는 방식으로 데이터를 출력합니다.
            out.println("Column1: " + column1 + ", Column2: " + column2 + "<br>");
        }
        
        // 연결 및 리소스 해제
        resultSet.close();
        statement.close();
        connection.close();
    %>
</body>
</html>
