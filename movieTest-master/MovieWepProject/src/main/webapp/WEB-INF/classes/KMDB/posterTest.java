package KMDB;

//삭제
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONObject;
import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;

public class posterTest {

	public static void main(String args[]) {
		posterTest p = new posterTest();
		String docid = "K28826";
		String type = docid.substring(0, 1);
		String id = docid.substring(1);
		System.out.println(p.getPostUrl("https://www.kmdb.or.kr/db/kor/detail/movie/"+type+"/"+id+"/own/image"));// https://www.kmdb.or.kr/db/kor/detail/movie/K/28826/own/image

	}

	public String getPostUrl(String url) {

		String result = "";
		ArrayList<String> strs = new ArrayList<String>();
		try {
			// 웹 페이지 URL
//            String url = "https://www.kmdb.or.kr/db/kor/detail/movie/K/22859"; // 원하는 웹 페이지 URL로 변경

			// Jsoup을 사용하여 웹 페이지를 가져옴
			Document document = Jsoup.connect(url).get();

			// System.out.println(document.toString());

			Elements els = document.getElementsByClass("mImg1");
			els.forEach(el -> {
				strs.add(el.toString());
//                System.out.println(el);

			});
			result = getUrl(strs);
//        	System.out.println(getUrl(strs));

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public String getUrl(ArrayList<String> strs) {
		String result = "";
		for (String str : strs) {
			if (str.contains("<div class=\"mImg1\">")) {
				result = str;
				break;
			}
		}
		ArrayList<String> removeList = new ArrayList<String>();
		removeList.add("\n");
		removeList.add("<div class=\"mImg1\">");
		removeList.add("</div>");
		removeList.add("<span style=\"background-image: url(");
		removeList.add(")\"></span>");
		removeList.add("\'");
		for (String str : strs) {
			String regex = "url\\('([^']*)'\\)";

			// 패턴을 컴파일
			Pattern pattern = Pattern.compile(regex);

			// 입력 문자열에서 일치하는 부분 찾기
			Matcher matcher = pattern.matcher(str);

			// 일치하는 부분이 있다면 값을 가져오기
			if (matcher.find()) {
				String url = matcher.group(1);
				System.out.println(url);
			}
		}

		return result.trim();
	}

	public String getKMDBUrl(String title) {
		String result = "";

		return result;
	}

	public String getApiOfTitle(String title, boolean loadDetail) throws IOException {

		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");

		// 이미지 항목 posters

		String detail = (loadDetail == true) ? "Y" : "N";

		urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=B40IP5NLA4A22KX077TM");
		urlBuilder.append("&" + URLEncoder.encode("detail", "UTF-8") + "=" + URLEncoder.encode(detail, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("title", "UTF-8") + "=" + URLEncoder.encode(title, "UTF-8"));

//	        System.out.println("전체 URL : " + urlBuilder.toString());

		URL url = new URL(urlBuilder.toString());

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");

//		        System.out.println("Response code: " + conn.getResponseCode());

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

		// JSON 파싱
		JSONObject jsonObject = new JSONObject(responseJson);

		// 출력
//	        System.out.println(jsonObject);
//	        System.out.println(jsonObject.get("Data"));

		return jsonObject.toString();
	}

}
