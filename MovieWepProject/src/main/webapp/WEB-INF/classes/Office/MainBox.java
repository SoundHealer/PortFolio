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

public class MainBox {

	private static final String API_KEY = "e7f29f3a771e33fd7d52149b8b31761c";
	private static final String BASE_API_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
	private static final String API_URL = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp";
	private static final String KMDB_API_KEY = "25QF8GG6G9R22N50D3X4"; // 여기에 KMDB API 키를 넣으세요

	public static List<MainBoxCtor> fetchDataByDate(String targetDt) {
		HttpClient httpClient = HttpClients.createDefault();
		List<MainBoxCtor> movieDayDataList = new ArrayList<>();

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
					String movieTitle = movieData.getString("movieNm");
					String releaseDt = movieData.getString("openDt"); 

					String[] data = searchMoviePoster(movieTitle, releaseDt);

					String posterUrl = data[0];
					String DOCID = data[1];

					MainBoxCtor Daydata = new MainBoxCtor();
					Daydata.setRank(movieData.getString("rank"));
					Daydata.setMovieNm(movieTitle);
					Daydata.setOpenDt(releaseDt);
					Daydata.setPosterUrl(posterUrl);
					Daydata.setMovieDOCID(DOCID);

					movieDayDataList.add(Daydata);
				}
			} else {
				System.err.println("API 호출 오류: " + response.getStatusLine().getReasonPhrase());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return movieDayDataList;
	}

	public static String[] searchMoviePoster(String query, String releaseDt) throws IOException {

		String[] result = { "", "" };

		String encodedQuery = URLEncoder.encode(query, "UTF-8");
		String encodedReleaseDt = URLEncoder.encode(releaseDt, "UTF-8");

		String apiUrl = API_URL + "?ServiceKey=" + KMDB_API_KEY + "&collection=kmdb_new&title=" + encodedQuery
				+ "&releaseDts=" + encodedReleaseDt + "&detail=Y&listCount=" + 1; // 결과를 1개만 가져오기 위해 1로 설정

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
			return result;
		}

		JsonArray results = data.get(0).getAsJsonObject().getAsJsonArray("Result");

		if (results == null || results.size() == 0) {
			System.out.println("검색 결과가 없습니다.");
			return result;
		}

		JsonObject firstResult = results.get(0).getAsJsonObject();

		JsonElement postersElement = firstResult.get("posters");
		try {
			if (postersElement != null && postersElement.isJsonPrimitive()) {
				String postersValue = postersElement.getAsString();
				String[] posterUrls = postersValue.split("\\|");
				if (posterUrls.length > 0) {
					result[0] = posterUrls[0];
					// return posterUrls[0];
				}
			}
		} catch (Exception e) {
			result[0] = "";
		}
		try {
			JsonElement movieSeqElement = firstResult.get("DOCID");
			if (movieSeqElement != null) {
				if (movieSeqElement.isJsonPrimitive()) {
					String movieSeqValue = movieSeqElement.getAsString();
					System.out.println(movieSeqValue);
					result[1] = movieSeqValue;
				}
			}
		} catch (Exception e) {
			result[1] = "";
		}

		return result;
	}

	public static void main(String[] args) throws IOException {
		List<MainBoxCtor> movieDataList = fetchDataByDate("20231025");

		for (MainBoxCtor movieData : movieDataList) {
			System.out.println("랭킹: " + movieData.getRank());
			System.out.println("영화 제목: " + movieData.getMovieNm());
			System.out.println("개봉일: " + movieData.getOpenDt());
			System.out.println("포스터 URL: " + movieData.getPosterUrl());
			System.out.println("포스터 DOCID: " + movieData.getMovieDOCID());
			System.out.println();
		}
	}
}
