package Servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/src/main/webapp/WEB-INF/classes/userLogin/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 여기에서 사용자 인증 로직을 수행합니다.
        // (예: 데이터베이스와 비교하여 사용자 정보를 확인)

        if (username.equals("0000") && password.equals("0000")) {
            // 로그인 성공 시 세션에 사용자 정보를 저장
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            // 로그인 후 리다이렉트할 페이지 설정
            response.sendRedirect(request.getContextPath() + "/welcome.jsp");
        } else {
            // 로그인 실패 시 에러 메시지를 request에 저장
            request.setAttribute("errorMessage", "로그인 실패");

            // 로그인 페이지로 포워딩
            request.getRequestDispatcher("/steellogin.jsp").forward(request, response);
        }
    }
}