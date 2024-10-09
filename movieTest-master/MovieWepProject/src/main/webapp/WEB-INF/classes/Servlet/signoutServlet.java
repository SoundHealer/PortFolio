package Servlet;

import DB.*;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet("/SignOut")
public class signoutServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		JSONObject jsonResponse = new JSONObject();
		jsonResponse.put("result", userId);
		HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());
        // 로그아웃 후 리다이렉트할 페이지 설정 (로그인 페이지)
        response.sendRedirect("main.jsp");
	}
}