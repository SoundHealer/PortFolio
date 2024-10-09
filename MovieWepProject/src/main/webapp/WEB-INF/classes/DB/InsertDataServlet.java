package DB;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InsertDataServlet")
public class InsertDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트에서 전송한 데이터를 가져옵니다.
    	/*
    	 * name = document.getElementById("userName").value;
		var id = document.getElementById("userId").value;
		var pw = document.getElementById("userPw").value;
		var address = document.getElementById("userAddress").value;
		var genres*/
    	
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String address = request.getParameter("address");
        String genres = request.getParameter("genres");

        // MySQL 데이터베이스 연결 정보
//        String url = "jdbc:mysql://localhost:3306/moviedb";
//        String username = "root";
//        String password = "0000";
        String url = "jdbc:mysql://121.130.132.95:3306/moviedb"; // 데이터베이스 URL
        String username = "outlineuser"; // 데이터베이스 사용자 이름
        String password = "outline0000"; // 데이터베이스 암호
        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.jdbc.Driver");

            // 데이터베이스 연결
            Connection connection = DriverManager.getConnection(url, username, password);

            // 데이터베이스에 데이터 삽입 쿼리
            String insertQuery = "INSERT INTO user (id, pw, name, address, genres) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, id);
            preparedStatement.setString(2, pw);
            preparedStatement.setString(3, name);
            preparedStatement.setString(4, address);
            preparedStatement.setString(5, genres);

            // 데이터 삽입 실행
            preparedStatement.executeUpdate();

            // 리소스 해제
            preparedStatement.close();
            connection.close();

            // 클라이언트에 성공 응답
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            // 클라이언트에 오류 응답
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
