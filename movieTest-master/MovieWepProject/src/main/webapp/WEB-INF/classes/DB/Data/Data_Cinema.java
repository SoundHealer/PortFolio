package DB.Data;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import kakaoApi.GeoCodeApi;

public class Data_Cinema {

	String name;
	String address;
	String Area_1;
	String Area_2;
	float location_x;
	float location_y;
	String tel;
	String wep;

	public static void main(String[] agrs) {
		Data_Cinema data = new Data_Cinema("영화관", "경기도 용인시 처인구 역북동 89-18 번지", "010-0000-0000", "WWW.");
		System.out.println(data.toString());
	}

	@Override
	public String toString() {
		return "Cinema [Area_1=" + Area_1 + ", Area_2=" + Area_2 + ", name=" + name + ", location_x=" + location_x
				+ ", location_y=" + location_y + ", address=" + address + ", tel=" + tel + ", wep=" + wep + "]";
	}

	public Data_Cinema(String[] datas) {
		System.out.println("String[]" + datas[0] +", "+datas[1] +", "+datas[2] +", "+datas[3]);
		Data_Cinema data = new Data_Cinema(datas[0], datas[1], datas[2], datas[3]);
		System.out.println("Data_Cinema : " + data.toString());
	}

	public Data_Cinema(String name, String address, String tel, String wep) {
		GeoCodeApi geocode = new GeoCodeApi();
		JSONObject addressJson = geocode.getGecodeAddress(address);
		System.out.println("ddressJson == null : " + addressJson == null);
		if (addressJson == null) {
			System.out.println("주소를 찾을수 없습니다");
			return;
		}
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.wep = wep;
		this.Area_1 = (String) addressJson.get("area_1");
		this.Area_2 = (String) addressJson.get("area_2");
		this.location_x = Float.valueOf((String) addressJson.get("x"));
		this.location_y = Float.valueOf((String) addressJson.get("y"));
		System.out.println("String*4 : " + this.toString());
	}

	public Data_Cinema(String Area_1, String Area_2, String name, float location_x, float location_y, String address,
			String tel, String wep) {

		this.Area_1 = Area_1;
		this.Area_2 = Area_2;
		this.name = name;
		this.location_x = location_x; // 변수명 수정: x -> location_x
		this.location_y = location_y; // 변수명 수정: y -> location_y
		this.address = address;
		this.tel = tel;
		this.wep = wep;
	}

	public Data_Cinema() {
		this.Area_1 = null;
		this.Area_2 = null;
		this.name = null;
		this.location_x = 0.0f; // 기본값으로 초기화
		this.location_y = 0.0f; // 기본값으로 초기화
		this.address = null;
		this.tel = null;
		this.wep = null;
	}

	public float getlocation_x() { // 메서드명 수정: getlocation_x -> getLocation_x
		return location_x;
	}

	public void setlocation_x(float x) { // 메서드명 수정: setlocation_x -> setLocation_x
		this.location_x = x;
	}

	public float getlocation_y() { // 메서드명 수정: getlocation_y -> getLocation_y
		return location_y;
	}

	public void setlocation_y(float y) { // 메서드명 수정: setlocation_y -> setLocation_y
		this.location_y = y;
	}

	public String getArea1() {
		return Area_1;
	}

	public void setArea1(String Area_1) {
		this.Area_1 = Area_1;
	}

	public String getArea2() {
		return Area_2;
	}

	public void setArea2(String Area_2) {
		this.Area_2 = Area_2;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getWep() {
		return wep;
	}

	public void setWep(String wep) {
		this.wep = wep;
	}

	public class geocodeAddress {

		String apikey = "84469BB6-6E08-399F-9408-C587A010AAA1";
		String searchType = "parcel";
		String epsg = "epsg:4326";

		public JSONObject getGecodeAddress(String address) {
			StringBuilder sb = new StringBuilder("https://api.vworld.kr/req/address");
			sb.append("?service=address");
			sb.append("&request=getCoord");
			sb.append("&format=json");
			sb.append("&crs=" + epsg);
			sb.append("&key=" + apikey);
			sb.append("&type=" + searchType);
			sb.append("&address=" + URLEncoder.encode(address, StandardCharsets.UTF_8));

			JSONObject result = new JSONObject();

			try {
				URL url = new URL(sb.toString());
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(url.openStream(), StandardCharsets.UTF_8));

				JSONParser jspa = new JSONParser();
				JSONObject jsob = (JSONObject) jspa.parse(reader);
				System.out.println(jsob.toString());
				JSONObject jsrs = (JSONObject) jsob.get("response");
				JSONObject jsResult = (JSONObject) jsrs.get("result");
				JSONObject jspoitn = (JSONObject) jsResult.get("point");

				result.put("x", jspoitn.get("x"));
				result.put("y", jspoitn.get("y"));

				JSONObject jsRefined = (JSONObject) jsrs.get("refined");
				JSONObject jsStructure = (JSONObject) jsRefined.get("structure");

				result.put("level1", jsStructure.get("level1"));
				result.put("level2", jsStructure.get("level2"));

				System.out.println(result);// 사용시 반대로 사용
				// System.out.println(jspoitn.get("y"));
			} catch (IOException | ParseException e) {
				throw new RuntimeException(e);
			}
			return result;
		}

		public geocodeAddress() {

		}
	}

}
