package Servlet;

import java.io.IOException;
import java.util.List;
import Office.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Office.DayBox3;

@WebServlet("/WeekBoxDataServlet")
public class WeekBoxOfficeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 클라이언트에서 전달한 대상 날짜를 가져옵니다.
        String targetDate = request.getParameter("targetDate");

        if (targetDate != null) {
            // 대상 날짜를 사용하여 영화 데이터를 가져오는 메소드 호출
            List<boxData2> movieDataList = WeekBox.fetchDataByDate(targetDate);

            if (movieDataList != null && !movieDataList.isEmpty()) {
                // 영화 데이터를 JSON 형식으로 변환
                String jsonData = convertToJSON(movieDataList);
                               // JSON 데이터를 응답으로 전송
                response.getWriter().write(jsonData);
            } else {
                // 데이터가 없을 때 에러 메시지를 응답으로 전송
                response.getWriter().write("{\"error\": \"No data available\"}");
            }
        } else {
            // 대상 날짜가 전달되지 않았을 때 에러 메시지를 응답으로 전송
            response.getWriter().write("{\"error\": \"Missing target date parameter\"}");
        }
    }

    private String convertToJSON(List<boxData2> movieDataList) {
        // Gson 라이브러리를 사용하여 영화 데이터를 JSON 형식으로 변환
        Gson gson = new Gson();
        String jsonData = gson.toJson(movieDataList);
        
        System.out.println(jsonData);
        // JSON 데이터를 반환
        return jsonData;
    }
}