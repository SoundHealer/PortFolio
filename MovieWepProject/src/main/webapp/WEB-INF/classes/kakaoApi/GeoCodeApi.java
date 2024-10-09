package kakaoApi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class GeoCodeApi {

    private static String GEOCODE_URL="http://dapi.kakao.com/v2/local/search/address.json?query=";
    private static String GEOCODE_USER_INFO="KakaoAK " + "a3138b5db7f6811a7a1e1783dd7720e3"; 
    
    public JSONObject getGecodeAddress(String address) {
    	URL obj;
    	JSONObject result = new JSONObject();
        try{
            //인코딩한 String을 넘겨야 원하는 데이터를 받을 수 있다.
            String address_UTF8 = URLEncoder.encode(address, "UTF-8");
            
            obj = new URL(GEOCODE_URL+address_UTF8);
			
            HttpURLConnection con = (HttpURLConnection)obj.openConnection();
            
            //get으로 받아오면 된다. 자세한 사항은 카카오개발자센터에 나와있다.
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization",GEOCODE_USER_INFO);
            con.setRequestProperty("content-type", "application/json");
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setDefaultUseCaches(false);
			
            Charset charset = Charset.forName("UTF-8");
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), charset));
            
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
			
            //response 객체를 출력해보자
            
            JSONParser parser = new JSONParser();

			JSONObject obj1 = (JSONObject) parser.parse(response.toString());
            Object documentsObj = obj1.get("documents");
            org.json.simple.JSONArray documentsArray = (org.json.simple.JSONArray)documentsObj;
            System.out.println("documentsArray 사이즈 : " + documentsArray.size());
            Object road_addressObj = documentsArray.get(0);
            JSONObject road_addressJSONObject = (JSONObject)road_addressObj;
            JSONObject road_address = (JSONObject) road_addressJSONObject.get("road_address");
            
            String area_1 = (String)road_address.get("region_1depth_name");
            String area_2 = (String)road_address.get("region_2depth_name");
            String x = (String)road_address.get("x");
            String y = (String)road_address.get("y");

            result.put("area_1",area_1);
            result.put("area_2",area_2);
            result.put("x",x.substring(0, 6));
            result.put("y",y.substring(0, 6));
            
			
		} catch (Exception e) {
			System.out.println("에러 발생" + e.getMessage());
			e.printStackTrace();
			return null;
		}
        System.out.println("getGecodeAddress : " + result.toString());
        return result;
	}
    public static void main(String[] args) {
		
        URL obj;
	
        try{
            //인코딩한 String을 넘겨야 원하는 데이터를 받을 수 있다.
            String address = URLEncoder.encode("경기도 광주시 도척면 534 번지 곤지암리조트 제1주차장", "UTF-8");
            
            obj = new URL(GEOCODE_URL+address);
            System.out.println(obj.toString());
            HttpURLConnection con = (HttpURLConnection)obj.openConnection();
            
            //get으로 받아오면 된다. 자세한 사항은 카카오개발자센터에 나와있다.
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization",GEOCODE_USER_INFO);
            con.setRequestProperty("content-type", "application/json");
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setDefaultUseCaches(false);
			
            Charset charset = Charset.forName("UTF-8");
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), charset));
            
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
			
            //response 객체를 출력해보자
            
            JSONParser parser = new JSONParser();

			JSONObject obj1 = (JSONObject) parser.parse(response.toString());
            Object documentsObj = obj1.get("documents");
            org.json.simple.JSONArray documentsArray = (org.json.simple.JSONArray)documentsObj;
            Object road_addressObj = documentsArray.get(0);
            JSONObject road_addressJSONObject = (JSONObject)road_addressObj;
            JSONObject road_address = (JSONObject) road_addressJSONObject.get("road_address");
            String area_1 = (String)road_address.get("region_1depth_name");
            String area_2 = (String)road_address.get("region_2depth_name");
            String x = (String)road_address.get("x");
            String y = (String)road_address.get("y");
            System.out.println("area_1 : " + area_1);
            System.out.println("area_2 : " + area_2);
            System.out.println("x : " + x);
            System.out.println("y : " + y);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
