package boxOffice;

import java.io.*;
import java.net.*;
import java.util.*;
import java.time.LocalDate;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class LoadBoxOffice {

	private static final String API_KEY = "e7f29f3a771e33fd7d52149b8b31761c";
	

	public static String Condition(String Key, String value) throws IOException {

		return ("&" + URLEncoder.encode(Key, "UTF-8") + "=" + URLEncoder.encode(value, "UTF-8"));
	}

	public static void main(String[] args) throws IOException {
		LoadBoxOffice load = new LoadBoxOffice();
		load.getBoxOfficeData("20231025",true);
	}
	public void getBoxOfficeData(String date, boolean isDaily) {
		String type = (isDaily)? "dailyBoxOfficeList" : "weeklyBoxOfficeList";
		String api_url = (isDaily)? "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?" : "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?";
		
		try {
			StringBuilder urlBuilder = new StringBuilder(api_url);
			// 이미지 항목 posters
			urlBuilder.append(Condition("key", API_KEY));
			urlBuilder.append(Condition("targetDt", date.replace("-","")));

			System.out.println("전체 URL : " + urlBuilder.toString());

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");

			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();

			String responseJson = sb.toString();

			JSONParser parser = new JSONParser();

			JSONObject obj = (JSONObject) parser.parse(responseJson);

			BoxOfficeData d = new BoxOfficeData();
			JSONObject objResult = ((JSONObject) obj.get("boxOfficeResult"));
			org.json.simple.JSONArray objList = ((org.json.simple.JSONArray) objResult.get(type));
			// System.out.println(objList.get(0));
			ArrayList<BoxOfficeData> datas = d.resultBoxOfficeData(objList);

			for (BoxOfficeData data : datas) {
				System.out.println(data.toString());
			}
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
