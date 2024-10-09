<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cinema Data</title>
</head>
<body>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Address</th>
            <th>지역1</th>
            <th>지역2</th>
            <th>X</th>
            <th>Y</th>
            <th>Call No</th>
            <th>WEP</th>
        </tr>
        <%
        CinemaDataAccess cinemaAccess = new CinemaDataAccess();
		List<Cinema> cinemaList = cinemaAccess.getAllCinemaData();

		for (Cinema cinema : cinemaList) {
			/*
		cinema.setName(resultSet.getString("name"));
        cinema.setAddress(resultSet.getString("address"));
        cinema.setArea_1(resultSet.getString("Area_1"));
        cinema.setArea_2(resultSet.getString("Area_2"));
        cinema.setLocation_x(resultSet.getFloat("location_x"));
        cinema.setLocation_y(resultSet.getFloat("location_y"));
        cinema.setTel(resultSet.getString("tel"));
        cinema.setWep(resultSet.getString("wep"));*/
        %>
        <tr>
        
            <td><%= cinema.getName() %></td>
            <td><%= cinema.getAddress() %></td>
            <td><%= cinema.getArea_1() %></td>
            <td><%= cinema.getArea_2() %></td>
            <td><%= cinema.getLocation_x() %></td>
            <td><%= cinema.getLocation_y() %></td>
            <td><%= cinema.getTel() %></td>
            <%if(cinema.getWep().equals("")){ %>
             <td>-</td><%
            } else { %>
            <td><a href = <%= cinema.getWep() %>>사이트</a></td>
            <%}%>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
