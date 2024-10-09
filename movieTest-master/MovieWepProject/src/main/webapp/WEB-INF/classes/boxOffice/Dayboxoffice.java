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

public class Dayboxoffice {
    private static final String API_KEY = "e7f29f3a771e33fd7d52149b8b31761c";
    private static final String BASE_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";

    public static List<datamovie> fetchDataByDate(String targetDt) {
        HttpClient httpClient = HttpClients.createDefault();
        List<datamovie> movieDayDataList = new ArrayList<>();

        try {
            String apiUrl = BASE_API_URL + "?key=" + API_KEY + "&targetDt=" + targetDt;
            HttpGet httpGet = new HttpGet(apiUrl);
            HttpResponse response = httpClient.execute(httpGet);

            if (response.getStatusLine().getStatusCode() == 200) {
                String json = EntityUtils.toString(response.getEntity());
                JSONObject jsonObject = new JSONObject(json);
                JSONObject boxOfficeResult = jsonObject.getJSONObject("boxOfficeResult");
                JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");

                for (int i = 0; i < dailyBoxOfficeList.length(); i++) {
                    JSONObject movieData = dailyBoxOfficeList.getJSONObject(i);

                    datamovie Daydata = new datamovie();
                    Daydata.setRank(movieData.getString("rank"));//����
                    Daydata.setMovieNm(movieData.getString("movieNm"));//��ȭ��
                    Daydata.setMovieCd(movieData.getString("movieCd"));//��ȭ��ǥ�ڵ�
                    Daydata.setOpenDt(movieData.getString("openDt"));//������
                    Daydata.setSalesAcc(movieData.getString("salesAcc"));//���������
                    Daydata.setSalesShare(movieData.getString("salesShare"));//�ش����� ������ �����Ѿ� ��� �ش� ��ȭ�� �������
                    Daydata.setAudiCnt(movieData.getString("audiCnt"));//�ش��� ������
                    Daydata.setAudiInten(movieData.getString("audiInten"));//���� ��� ������ ����
                    Daydata.setAudiAcc(movieData.getString("audiAcc"));//���� ������
                    Daydata.setScrnCnt(movieData.getString("scrnCnt"));//�ش����� ��ũ�� �󿵼�
                    Daydata.setShowCnt(movieData.getString("showCnt"));//�󿵵� Ƚ��
                    Daydata.setSalesAmt(movieData.getString("salesAmt"));//�����
                    Daydata.setSalesInten(movieData.getString("salesInten"));//�����
                   
                    movieDayDataList.add(Daydata);
                }
            } else {
                System.err.println("API ��û ����: " + response.getStatusLine().getReasonPhrase());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movieDayDataList;
    }
    
}