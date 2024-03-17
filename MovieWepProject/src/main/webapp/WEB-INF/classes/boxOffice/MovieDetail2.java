package boxOffice;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class MovieDetail2 {
    private static final String API_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp";
    private static final String API_KEY = "77I86OA3PQ26LKYE5PG0"; // 본인의 KMDB API 키로 대체

    public static List<MovieInfo> searchMovieInfo(String query,String Types) throws IOException {
        // 영화 제목을 URL 인코딩
    	
        String encodedquery = URLEncoder.encode(query, "UTF-8");
        String types = Types;
        System.out.println(types);
        // API 요청 URL 생성
        String API_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp";
        String API_KEY = "77I86OA3PQ26LKYE5PG0"; // 본인의 KMDB API 키로 대체
        String apiUrl = API_URL + "?ServiceKey=" + API_KEY + "&collection=kmdb_new&query=" + encodedquery+"&"+types+"="+encodedquery+"&detail=Y&sort=prodYear&listCount="+20;

        // HTTP GET 요청 생성 및 설정
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        // 응답 읽기
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        conn.disconnect();

        // JSON 파싱
        JsonParser jsonParser = new JsonParser();
        
        JsonObject jsonResponse = jsonParser.parse(response.toString()).getAsJsonObject();

        // 필요한 정보 추출
        JsonArray data = jsonResponse.getAsJsonArray("Data");
        
        if (data == null || data.size() == 0) {
            System.out.println("데이터가 없습니다.");
            return new ArrayList<>(); // 빈 목록 반환 또는 예외를 던질 수 있음
        }
        
        JsonArray results = data.get(0).getAsJsonObject().getAsJsonArray("Result");
        
        if (results == null) {
            System.out.println("검색 결과가 없습니다.");
            return new ArrayList<>(); // 빈 목록 반환 또는 예외를 던질 수 있음
        }

        List<MovieInfo> movieInfoList = new ArrayList<>();
        
        for (int i = 0; i < results.size(); i++) {
            JsonObject result = results.get(i).getAsJsonObject();
            String movieTitle = result.get("title").getAsString();
            if (movieTitle.contains("!HS") || movieTitle.contains("!HE")) {
            	movieTitle = movieTitle.replaceAll("\\s!HS\\s|\\s!HE\\s", "");
            }

            System.out.println("Original Title: " + movieTitle);

            JsonArray directors = result.getAsJsonArray("director");
            String directorName = "";

            if (directors != null && directors.size() > 0) {
                JsonObject director = directors.get(0).getAsJsonObject();
                directorName = director.get("directorNm").getAsString(); // 감독 이름
                if (directorName.contains("!HS") || directorName.contains("!HE")) {
                   directorName = directorName.replaceAll("\\s!HS\\s|\\s!HE\\s", "");
                }
            }

            String nation = result.get("nation").getAsString(); // 국가 정보

            // 중복된 "rating" 키 처리
            JsonArray ratings = result.getAsJsonArray("rating");
            
            String plot = result.get("plot").getAsString(); // "plot" 정보
            
            //배우
            JsonArray actors = result.getAsJsonArray("actor");
            String repRlsDate = result.get("repRlsDate").getAsString();
            
            List<String> actorNames = new ArrayList<>();
            
            if (actors != null && actors.size() > 0) {
                for (int j = 0; j < actors.size(); j++) {
                    JsonObject actor = actors.get(j).getAsJsonObject();
                    String actorName = actor.get("actorNm").getAsString(); // 배우 이름
                    actorNames.add(actorName);
                }
            }
            
            //장르
            String genre = result.get("genre").getAsString(); // "genre" 정보
            
            String prodYear = result.get("prodYear").getAsString(); // "prodYear" 정보
            
            
            // "posters" 값을 불러옴
            JsonElement postersElement = result.get("posters");
            List<String> posters = new ArrayList<>();

            if (postersElement != null && postersElement.isJsonPrimitive()) {
                String postersValue = postersElement.getAsString();
                String[] posterUrls = postersValue.split("\\|");
                for (String posterUrl : posterUrls) {
                    posters.add(posterUrl);
                }
            }

            // MovieInfo 객체 생성 및 추가
            MovieInfo movieInfo = new MovieInfo(movieTitle, directorName, nation, plot,repRlsDate, genre,prodYear);
            movieInfo.setPosters(posters);
            movieInfo.setActors(actorNames);         
            movieInfoList.add(movieInfo);
        }

        return movieInfoList;
    }
}