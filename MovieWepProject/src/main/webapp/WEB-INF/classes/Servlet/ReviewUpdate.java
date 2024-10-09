package Servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import Office.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;

import DB.DatabaseConnection;
import DB.DAO.DAO_ReviewDB;
import DB.Data.Data_Review;
import DB.Data.Data_User;
import Office.DayBox3;

@WebServlet("/ReviewUpdate")
public class ReviewUpdate extends HttpServlet {
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
		String fun = json.getString("fun");

		// System.out.println("---------------------------" + fun);

		String number = json.getString("number");
		String title = json.getString("title");
		String userid = json.getString("userid");
		String DOCID = json.getString("DOCID");
		String review = json.getString("review");
		String score = json.getString("score");
		// String no, String userid, String title, String director, String score, String
		// review
		Data_Review reviewData = new Data_Review(number, userid, title, DOCID, score, review);
		DAO_ReviewDB db = new DAO_ReviewDB();
		JSONObject jsonResponse = new JSONObject();
		int result = 0;
		if (fun.equals("del")) {
			result = db.deleteReview(reviewData);
		} else {
			result = db.updateReview(reviewData);
		}

		System.out.println("리뷰 작성 서블렛 : " + result);
		// 응답 전송 (예: 성공 메시지)

		jsonResponse.put("message", result);

		// JSON 응답을 클라이언트로 전송
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());
	}
}