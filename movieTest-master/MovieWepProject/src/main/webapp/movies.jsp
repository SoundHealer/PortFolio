<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie List</title>
</head>
<body>
    <h1>Movie List</h1>
    <%
        String apiKey = "e7f29f3a771e33fd7d52149b8b31761c";
        String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + apiKey + "&targetDt=20230828";

        StringBuilder jsonResponse = new StringBuilder();
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                jsonResponse.append(inputLine);
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String responseData = jsonResponse.toString();
        JSONObject jsonObject = new JSONObject(responseData);
        JSONObject boxOfficeResult = jsonObject.getJSONObject("boxOfficeResult");
        JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");

        %>
        <ul>
        <%
        for (int i = 0; i < dailyBoxOfficeList.length(); i++) {
            JSONObject movieObject = dailyBoxOfficeList.getJSONObject(i);
            String movieName = movieObject.getString("movieNm");
            String sales = movieObject.getString("salesAmt");
        %>
            <li><%= movieName %> - <%= sales %>원</li>
        <%
        }
        %>
        </ul>
    </body>
</html>
