package DB;

import java.sql.*;
import java.util.*;

public class DataDAO {
	
	DatabaseConnection dbconn = new DatabaseConnection();
	
    public List<String> fetchData_Test() {
        List<String> data = new ArrayList<>();
        Connection connection = dbconn.getConnection();
        try {
            String query = "SELECT name FROM cinema"; // 적절한 SQL 쿼리를 작성
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String value = resultSet.getString("name"); // 컬럼 이름으로 값을 가져옴
                data.add(value);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
    
    public List<List<String>> fetchData() {
        List<List<String>> data = new ArrayList<>();
        Connection connection = dbconn.getConnection();
        try {
            String query = "SELECT * FROM your_table"; // 적절한 SQL 쿼리를 작성
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (resultSet.next()) {
                List<String> rowData = new ArrayList<>();
                for (int i = 1; i <= columnCount; i++) {
                    rowData.add(resultSet.getString(i));
                }
                data.add(rowData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
    
    public String test() {
    	return "test";
    }
    
}
