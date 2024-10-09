package kakaoApi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class geocodeAddress {
	
	String apikey = "84469BB6-6E08-399F-9408-C587A010AAA1";
	String searchType = "parcel";
	String searchAddr = "용마공원로 9길 29";
	String epsg = "epsg:4326";
	
	public static void main(String[] args) {
		new geocodeAddress();
	}
	
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
		
		try{
		    URL url = new URL(sb.toString());
		    BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream(), StandardCharsets.UTF_8));

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

		    System.out.println(result);//사용시 반대로 사용
		    System.out.println(jspoitn.get("y"));
		} catch (IOException | ParseException e) {
		    throw new RuntimeException(e);
		} finally {
			return result;
		}
	}
	
	public geocodeAddress() {
		
	}
}
