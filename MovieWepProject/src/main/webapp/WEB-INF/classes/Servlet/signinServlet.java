package Servlet;

import DB.*;
import DB.Data.Data_User;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet("/SignIn")
public class signinServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		String userId = json.getString("userId");
		String userPw = json.getString("userPw");

		Data_User u = new Data_User(userId, userPw);
		DatabaseConnection db = new DatabaseConnection();
		JSONObject jsonResponse = new JSONObject();
		JSONObject result = db.signIn(u);
		HttpSession session = request.getSession();
		int resultInt = (int) result.get("result");
		if (resultInt == 0) {
			session.setAttribute("userName", result.get("userName"));
			session.setAttribute("userId", result.get("userId"));
			session.setAttribute("userPw", result.get("userPw"));
			session.setAttribute("userEmail", result.get("userEmail"));
			session.setAttribute("birthDay", result.get("birthDay"));
			session.setAttribute("userAddress", result.get("userAddress"));
			session.setAttribute("Genre_1", result.get("Genre_1"));
			session.setAttribute("Genre_2", result.get("Genre_2"));
			session.setAttribute("Genre_3", result.get("Genre_3"));
			session.setAttribute("Genre_4", result.get("Genre_4"));

		}
		// 응답 전송 (예: 성공 메시지)

		jsonResponse.put("result", resultInt);

		// JSON 응답을 클라이언트로 전송
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());
	}
}