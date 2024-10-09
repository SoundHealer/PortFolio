package boxOffice;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class KoficApi {
    private static final String API_KEY = "9cbf70ef669df368261f74e63c81b28c";
    private static final String BASE_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";

    public static List<datamovie> fetchDataByPage(String targetDt, int page) {
        HttpClient httpClient = HttpClients.createDefault();
        List<datamovie> movieDataList = new ArrayList<>();

        try {
            String apiUrl = BASE_API_URL + "?key=" + API_KEY + "&targetDt=" + targetDt + "&page=" + page;
            HttpGet httpGet = new HttpGet(apiUrl);
            HttpResponse response = httpClient.execute(httpGet);

            if (response.getStatusLine().getStatusCode() == 200) {
                String json = EntityUtils.toString(response.getEntity());
                JSONObject jsonObject = new JSONObject(json);
                JSONObject boxOfficeResult = jsonObject.getJSONObject("boxOfficeResult");
                JSONArray weeklyBoxOfficeList = boxOfficeResult.getJSONArray("weeklyBoxOfficeList");

                for (int i = 0; i < weeklyBoxOfficeList.length(); i++) {
                    JSONObject movieData = weeklyBoxOfficeList.getJSONObject(i);

                    datamovie data = new datamovie();
                    data.setRank(movieData.getString("rank"));
                    data.setMovieNm(movieData.getString("movieNm"));
                    data.setMovieCd(movieData.getString("movieCd"));
                    data.setOpenDt(movieData.getString("openDt"));
                    data.setSalesAcc(movieData.getString("salesAcc"));
                    data.setSalesShare(movieData.getString("salesShare"));
                    data.setAudiCnt(movieData.getString("audiCnt"));
                    data.setAudiInten(movieData.getString("audiInten"));
                    data.setAudiAcc(movieData.getString("audiAcc"));
                    data.setScrnCnt(movieData.getString("scrnCnt"));
                    data.setShowCnt(movieData.getString("showCnt"));
                    data.setShowCnt(movieData.getString("salesAmt"));//매출액

                    movieDataList.add(data);
                }
            } else {
                System.err.println("API 요청 실패: " + response.getStatusLine().getReasonPhrase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movieDataList;
    }
}