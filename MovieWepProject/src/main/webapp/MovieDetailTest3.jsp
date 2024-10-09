<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="boxOffice.*, java.util.List, java.util.ArrayList, java.io.IOException, java.time.LocalDate, java.time.format.DateTimeFormatter" %>


<!DOCTYPE html>
<html>
<head>
    <title>Movie Detail</title>
</head>
<body>
    <h1>Movie Detail</h1>

    <%
    String movieTitle = request.getParameter("title");
    String dName = request.getParameter("director");

    if (movieTitle != null && !movieTitle.isEmpty()) {
        List<MovieInfo> movieInfoList = boxOffice.MovieDetail2.searchMovieInfo(movieTitle);
        // 영화 정보가 있을 때 처리
        if (movieInfoList != null && !movieInfoList.isEmpty()) {
    %>
    <h2><%= movieTitle %></h2>
    <h2><%= dName %></h2>

    <h2>Movie Information:</h2>
    <ul>
        <%
        for (MovieInfo movieInfo : movieInfoList) {
            String movieT = movieInfo.getMovieTitle(); // 영화 제목 가져오기
            String directorName = movieInfo.getDirectorName(); // 감독 이름 가져오기
            String nation = movieInfo.getNation(); // 국가 정보 가져오기
        %>
        <li>Title: <%= movieT %></li>
        <li>Director: <%= directorName %></li>
        <li>Nation: <%= nation %></li>
        <li>poster: <%
                        List<String> posters = movieInfo.getPosters();
                        if (!posters.isEmpty()) {
                            // 하나의 포스터만 표시하도록 변경
                            String firstPoster = posters.get(0);
                        %>
                                <img src="<%= firstPoster %>" alt="Movie Poster"><br>
                        <%
                        } else {
                        %>
                            No posters available.
                        <%
                        }
                        %></li>
        <%
        }
        %>
    </ul>

    <!-- 이곳에 추가적인 영화 정보를 표시할 수 있습니다. -->
    <%
        }
    }
    %>
</body>
</html>
