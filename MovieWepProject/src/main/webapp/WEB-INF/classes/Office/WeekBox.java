package Office;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class WeekBox {

    private static final String API_KEY = "e7f29f3a771e33fd7d52149b8b31761c";
    private static final String BASE_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";
    private static final String KOFIC_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json";
    private static final String API_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp";
    private static final String KMDB_API_KEY = "25QF8GG6G9R22N50D3X4"; // 본인의 KMDB API 키로 대체

    public static List<boxData2> fetchDataByDate(String targetDt) {
        HttpClient httpClient = HttpClients.createDefault();
        List<boxData2> movieDayDataList = new ArrayList<>();

        try {
            String apiUrl = BASE_API_URL + "?key=" + API_KEY + "&targetDt=" + targetDt + "&weekGb=0";
            HttpGet httpGet = new HttpGet(apiUrl);
            HttpResponse response = httpClient.execute(httpGet);

            if (response.getStatusLine().getStatusCode() == 200) {
                String json = EntityUtils.toString(response.getEntity());
                JSONObject jsonObject = new JSONObject(json);
                JSONObject boxOfficeResult = jsonObject.getJSONObject("boxOfficeResult");
                JSONArray weeklyBoxOfficeList = boxOfficeResult.getJSONArray("weeklyBoxOfficeList");

                for (int i = 0; i < weeklyBoxOfficeList.length(); i++) {
                    JSONObject movieData = weeklyBoxOfficeList.getJSONObject(i);
                    String movieCd = movieData.getString("movieCd");
                    String movieTitle = movieData.getString("movieNm");
                    String director = "";
                    String watchGradeNm = "";

                    // KOFIC API를 사용하여 movieCd를 기반으로 영화 정보를 가져옵니다.
                    String movieInfoUrl = KOFIC_API_URL + "?key=" + API_KEY + "&movieCd=" + movieCd;
                    HttpGet movieInfoHttpGet = new HttpGet(movieInfoUrl);
                    HttpResponse movieInfoResponse = httpClient.execute(movieInfoHttpGet);

                    if (movieInfoResponse.getStatusLine().getStatusCode() == 200) {
                        String movieInfoJson = EntityUtils.toString(movieInfoResponse.getEntity());
                        JSONObject movieInfoObject = new JSONObject(movieInfoJson);
                        JSONObject movieInfoResult = movieInfoObject.getJSONObject("movieInfoResult");
                        JSONObject movieInfo = movieInfoResult.getJSONObject("movieInfo");

                        JSONArray directorsArray = movieInfo.getJSONArray("directors");
                        List<String> directors = new ArrayList<>();
                        List<String> directorsEn = new ArrayList<>(); // 감독의 영문 이름을 저장할 리스트 추가

                        for (int j = 0; j < directorsArray.length(); j++) {
                            JSONObject directorObject = directorsArray.getJSONObject(j);
                            String directorName = directorObject.getString("peopleNm");
                            directors.add(directorName);

                            // 영문 이름 가져와서 directorsEn 리스트에 추가
                            String directorNameEn = directorObject.getString("peopleNmEn");
                            directorsEn.add(directorNameEn);

                            if (j == 0) {
                                director = directorName;
                            }
                        }
                        
                        if (movieInfo.has("audits")) {
                            JSONArray auditsArray = movieInfo.getJSONArray("audits");
                            if (auditsArray.length() > 0) {
                                JSONObject auditObject = auditsArray.getJSONObject(0);
                                watchGradeNm = auditObject.getString("watchGradeNm");
                            }
                        }

                        String releaseDt = movieData.getString("openDt");
                        String posterUrl = searchMoviePoster(movieTitle, releaseDt);

                        // 추가 정보 가져오기
                        
                        String showTm = movieInfo.getString("showTm");
                        String nationNm = movieInfo.getJSONArray("nations").getJSONObject(0).getString("nationNm");
                        String prdtStatNm = movieInfo.getString("prdtStatNm");

                        boxData2 Daydata = new boxData2();
                        Daydata.setRank(movieData.getString("rank"));
                        Daydata.setRankInten(movieData.getString("rankInten"));//랭킹 증감분
                        Daydata.setRankOldAndNew(movieData.getString("rankOldAndNew"));
                        Daydata.setMovieNm(movieTitle);
                        Daydata.setMovieCd(movieCd);
                        String openDt = movieData.getString("openDt");
                        Daydata.setOpenDt(openDt.replaceAll("-", ""));
                        Daydata.setAudiCnt(movieData.getString("audiCnt"));
                        Daydata.setAudiAcc(movieData.getString("audiAcc"));
                        Daydata.setAudiInten(movieData.getString("audiInten"));
                        Daydata.setAudiChange(movieData.getString("audiChange"));
                        Daydata.setSalesAmt(movieData.getString("salesAmt"));
                        Daydata.setSalesAcc(movieData.getString("salesAcc"));
                        
                        Daydata.setSalesShare(movieData.getString("salesShare"));
                        Daydata.setSalesChange(movieData.getString("salesChange"));
                        Daydata.setDirectors(directors);
                        Daydata.setDirectorsEn(directorsEn); // 영문 감독 이름 리스트 설정
                        Daydata.setPosterUrl(posterUrl);

                        // 추가 정보 설정
                        Daydata.setWatchGradeNm(watchGradeNm);
                        Daydata.setShowTm(showTm);
                        Daydata.setNationNm(nationNm);
                        Daydata.setPrdtStatNm(prdtStatNm);

                        movieDayDataList.add(Daydata);
                    }
                }
            } else {
                System.err.println("API 호출 오류: " + response.getStatusLine().getReasonPhrase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return movieDayDataList;
    }


    public static String searchMoviePoster(String query, String releaseDts) throws IOException {
        String encodedQuery = URLEncoder.encode(query, "UTF-8");
        
        String encodedReleaseDts = URLEncoder.encode(releaseDts, "UTF-8");

        String apiUrl = API_URL + "?ServiceKey=" + KMDB_API_KEY +
            "&collection=kmdb_new&title=" + encodedQuery +
            
            "&releaseDts=" + encodedReleaseDts +
            "&detail=Y&sort=prodYear&listCount=" + 10;

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        conn.disconnect();

        JsonParser jsonParser = new JsonParser();

        JsonObject jsonResponse = jsonParser.parse(response.toString()).getAsJsonObject();

        JsonArray data = jsonResponse.getAsJsonArray("Data");

        if (data == null || data.size() == 0) {
            System.out.println("데이터가 없습니다.");
            return null;
        }

        JsonArray results = data.get(0).getAsJsonObject().getAsJsonArray("Result");

        if (results == null || results.size() == 0) {
            System.out.println("검색 결과가 없습니다.");
            return null;
        }

        JsonObject firstResult = results.get(0).getAsJsonObject();
        
        

        JsonElement postersElement = firstResult.get("posters");

        if (postersElement != null && postersElement.isJsonPrimitive()) {
            String postersValue = postersElement.getAsString();
            String[] posterUrls = postersValue.split("\\|");
            if (posterUrls.length > 0) {
                return posterUrls[0];
            }
        }

        return null;
    }
    public static void main(String[] args) throws IOException {
        List<boxData2> movieDataList = fetchDataByDate("20231027");

        for (boxData2 movieData : movieDataList) {
            System.out.println("랭킹: " + movieData.getRank());
            System.out.println("랭킹 증감분 : " + movieData.getRankInten());
            System.out.println("랭킹 신규구분 : " + movieData.getRankOldAndNew());
            System.out.println("영화 제목: " + movieData.getMovieNm());
            System.out.println("영화 코드: " + movieData.getMovieCd());
            System.out.println("개봉일: " + movieData.getOpenDt());
            System.out.println("관객수: " + movieData.getAudiCnt());
            System.out.println("관객수 증감률: " + movieData.getAudiInten());
            System.out.println("관객수 증감 비율: " + movieData.getAudiChange());
            System.out.println("매출액: " + movieData.getSalesAmt());
            System.out.println("매출액 변동: " + movieData.getSalesChange());
            System.out.println("매출액 변동 증감: " + movieData.getSalesShare());
            System.out.println("감독: " + String.join(", ", movieData.getDirectors()));
            System.out.println("감독 영어명 : " + String.join(", ", movieData.getDirectorsEn()));
            System.out.println("포스터 URL: " + movieData.getPosterUrl());
            System.out.println("관람등급: " + movieData.getWatchGradeNm());
            System.out.println("상영시간: " + movieData.getShowTm());
            System.out.println("제작국가: " + movieData.getNationNm());
            System.out.println("제작상태: " + movieData.getPrdtStatNm());

            System.out.println();
        }
    }
}