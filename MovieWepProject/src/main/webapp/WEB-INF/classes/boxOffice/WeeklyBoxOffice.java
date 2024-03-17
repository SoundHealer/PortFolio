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

public class WeeklyBoxOffice {
    private static final String API_KEY = "9cbf70ef669df368261f74e63c81b28c"; // ���⿡ KOFIC API Ű�� ��������.
    private static final String BASE_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";

    public static List<datamovie> fetchWeeklyDataByWeek(String targetWeek) {
        HttpClient httpClient = HttpClients.createDefault();
        List<datamovie> movieWeeklyDataList = new ArrayList<>();

        try {
            String apiUrl = BASE_API_URL + "?key=" + API_KEY + "&targetDt=" + targetWeek;
            HttpGet httpGet = new HttpGet(apiUrl);
            HttpResponse response = httpClient.execute(httpGet);

            if (response.getStatusLine().getStatusCode() == 200) {
                String json = EntityUtils.toString(response.getEntity());
                JSONObject jsonObject = new JSONObject(json);
                JSONObject boxOfficeResult = jsonObject.getJSONObject("boxOfficeResult");
                JSONArray weeklyBoxOfficeList = boxOfficeResult.getJSONArray("weeklyBoxOfficeList");

                for (int i = 0; i < weeklyBoxOfficeList.length(); i++) {
                    JSONObject movieData = weeklyBoxOfficeList.getJSONObject(i);

                    datamovie weeklyData = new datamovie();
                    weeklyData.setRank(movieData.getString("rank"));
                    weeklyData.setMovieNm(movieData.getString("movieNm"));
                    weeklyData.setMovieCd(movieData.getString("movieCd"));
                    weeklyData.setOpenDt(movieData.getString("openDt"));
                    weeklyData.setSalesAcc(movieData.getString("salesAcc"));
                    weeklyData.setSalesShare(movieData.getString("salesShare"));
                    weeklyData.setAudiCnt(movieData.getString("audiCnt"));
                    weeklyData.setAudiInten(movieData.getString("audiInten"));
                    weeklyData.setAudiAcc(movieData.getString("audiAcc"));
                    weeklyData.setScrnCnt(movieData.getString("scrnCnt"));
                    weeklyData.setShowCnt(movieData.getString("showCnt"));
                    weeklyData.setSalesAmt(movieData.getString("salesAmt"));
                    weeklyData.setSalesInten(movieData.getString("salesInten"));

                    movieWeeklyDataList.add(weeklyData);
                }
            } else {
                System.err.println("API ��û ����: " + response.getStatusLine().getReasonPhrase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movieWeeklyDataList;
    }
}

