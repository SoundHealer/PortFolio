package Servlet;

import DB.*;
import DB.Data.Data_User;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.json.simple.parser.ParseException;

@WebServlet("/SignUp")
public class signupServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("회원가입 서블렛 실행");
		// 클라이언트로부터 전송된 데이터 읽기
		request.setCharacterEncoding("UTF-8");
		BufferedReader reader = request.getReader();
		StringBuilder requestData = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			requestData.append(line);
		}

		// JSON 데이터 파싱
		JSONObject json = new JSONObject(requestData.toString());

		// 데이터 확인 및 MySQL DB에 추가하는 로직 수행
		String userName = json.getString("userName");
		String userId = json.getString("userId");
		String userPw = json.getString("userPw");
		String userEmail = json.getString("userEmail");
		Date birthDay = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDate;
        try {
            parsedDate = dateFormat.parse(json.getString("birthDay"));
            // java.util.Date을 java.sql.Date로 변환
            birthDay = new Date(parsedDate.getTime());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		String userAddress = json.getString("userAddress");
		String Genre_1 = json.getString("Genre_1");
		String Genre_2 = json.getString("Genre_2");
		String Genre_3 = json.getString("Genre_3");
		String Genre_4 = json.getString("Genre_4");
		
		
		Data_User u = new Data_User(userId, userPw, userName, birthDay, userEmail, userAddress, Genre_1, Genre_2, Genre_3, Genre_4);
		DatabaseConnection db = new DatabaseConnection();
		JSONObject jsonResponse = new JSONObject();
		int result = db.signUp(u);
		
		// 응답 전송 (예: 성공 메시지)
		
		jsonResponse.put("message", result);

		// JSON 응답을 클라이언트로 전송
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());
	}
}