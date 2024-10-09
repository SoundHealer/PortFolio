package DB;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String userName = request.getParameter("userName");
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String userAddress = request.getParameter("userAddress");
        String genre1 = request.getParameter("Genre_1");
        String genre2 = request.getParameter("Genre_2");
        String genre3 = request.getParameter("Genre_3");
        String genre4 = request.getParameter("Genre_4");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // JDBC 드라이버 클래스 로드
            Class.forName("com.mysql.jdbc.Driver");

            // MySQL 데이터베이스에 연결
//            String url = "jdbc:mysql://localhost:3306/moviedb";
//            String username = "root";
//            String password = "0000";
            String url = "jdbc:mysql://121.130.132.95:3306/moviedb"; // 데이터베이스 URL
            String username = "outlineuser"; // 데이터베이스 사용자 이름
            String password = "outline0000"; // 데이터베이스 암호
            conn = DriverManager.getConnection(url, username, password);

            // 아이디 중복 확인
            String checkIdSql = "SELECT * FROM user WHERE id = ?";
            pstmt = conn.prepareStatement(checkIdSql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 중복된 아이디가 이미 존재하는 경우
                response.getWriter().write("duplicate");
            } else {
                // 중복된 아이디가 없는 경우 회원 정보를 데이터베이스에 저장
                String insertSql = "INSERT INTO user (name, id, pw, address, genre) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, userName);
                pstmt.setString(2, userId);
                pstmt.setString(3, userPw);
                pstmt.setString(4, userAddress);
                pstmt.setString(5, genre1 + "|" + genre2 + "|" + genre3 + "|" + genre4);

                int rowsInserted = pstmt.executeUpdate();

                if (rowsInserted > 0) {
                    // 회원가입 성공
                    response.getWriter().write("success");
                } else {
                    // 회원가입 실패
                    response.getWriter().write("failure");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
