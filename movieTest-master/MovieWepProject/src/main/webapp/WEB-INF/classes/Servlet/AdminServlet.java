package Servlet;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import DB.DAO.*;

@WebServlet("/adminServlet")
public class AdminServlet extends HttpServlet {

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
		System.out.println(json.toString());
		// 데이터 확인 및 MySQL DB에 추가하는 로직 수행
		String type = json.getString("type");
		String doFun = json.getString("doFun");
		String[] datas = new String[10];
		datas[0] = json.getString("data_1");
		datas[1] = json.getString("data_2");
		datas[2] = json.getString("data_3");
		datas[3] = json.getString("data_4");
		datas[4] = json.getString("data_5");
		datas[5] = json.getString("data_6");
		datas[6] = json.getString("data_7");
		datas[7] = json.getString("data_8");
		datas[8] = json.getString("data_9");
		datas[9] = json.getString("data_10");

//		System.out.println("관리자 서블렛 : " + type);
//		for (int i = 0; i < 10; i++) {
//			System.out.println("datas[" + i + "] : " + datas[i]);
//		}
		int result = 0;

		JSONObject jsonResponse = new JSONObject();
		if(type.equals("user")) {
			DAO_UserDB dao = new DAO_UserDB();
			if(doFun.equals("update"))
				result = dao.updateUserData(datas);
			else if(doFun.equals("delete"))
				result = dao.deleteUserData(datas);
		}else if(type.equals("review")) {
			DAO_ReviewDB dao = new DAO_ReviewDB();
			if(doFun.equals("update"))
				result = dao.updateReview(datas);
			else if(doFun.equals("delete"))
				result = dao.deleteReview(datas);
		}else if(type.equals("cinema")) {
			DAO_CinemaDB dao = new DAO_CinemaDB();
			if(doFun.equals("update"))
				result = dao.updateCinema(datas);
			else if(doFun.equals("delete"))
				result = dao.deleteReview(datas);
			else if(doFun.equals("insert"))
				result = dao.insertCinema(datas);
		}

		System.out.println("리뷰 작성 서블렛 : " + result);

		jsonResponse.put("result", result);

		// JSON 응답을 클라이언트로 전송
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonResponse.toString());
	}
}
