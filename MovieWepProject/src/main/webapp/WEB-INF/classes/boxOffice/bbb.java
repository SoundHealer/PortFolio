package boxOffice;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class bbb {
    private static final String API_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp";
    private static final String API_KEY = "25QF8GG6G9R22N50D3X4"; // 본인의 KMDB API 키로 대체

    public static String searchMovies(String title) throws IOException {
        // 영화 제목을 URL 인코딩
        String encodedTitle = URLEncoder.encode(title, "UTF-8");

        // API 요청 URL 생성
        String apiUrl = API_URL + "?ServiceKey=" + API_KEY + "&collection=kmdb_new&title=" + encodedTitle +"&detail=Y";

        // HTTP GET 요청 생성 및 설정
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        // 응답 읽기
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        conn.disconnect();

        return response.toString();
    }

    public static void main(String[] args) throws IOException {
        String title = "범죄도시2"; // 검색할 영화 제목
        String result = searchMovies(title);

        // 검색 결과를 출력
        System.out.println(result);
    }
}
