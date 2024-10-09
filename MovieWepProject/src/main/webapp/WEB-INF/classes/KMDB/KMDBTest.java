package KMDB;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class KMDBTest{
	
	public static String Condition(String Key,String value) throws IOException {

		return ("&" + URLEncoder.encode(Key,"UTF-8") + "=" + URLEncoder.encode(value,"UTF-8"));
    }
	
	public static void main(String[] args) throws IOException  {
        StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
        //이미지 항목 posters
        urlBuilder.append(Condition("ServiceKey","B40IP5NLA4A22KX077TM"));
        urlBuilder.append(Condition("detail","Y"));
//        urlBuilder.append(Condition("title","봉준호"));
        urlBuilder.append(Condition("query","곡성"));
//        urlBuilder.append(Condition("nation","대한민국"));
//        urlBuilder.append(Condition("title","고향무정"));
        urlBuilder.append(Condition("nation","대한민국"));

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

        // JSON 파싱

        // 출력
        System.out.println(responseJson);
        
        JSONParser parser = new JSONParser();
		try
		{
			//파싱할 문자열 지정 후 json object로 형변환 
			JSONObject obj = (JSONObject)parser.parse(responseJson);
			
			// 몇개의 오브젝트가 들어있는가?
			System.out.println("오브젝트의 갯수 : "+obj.size());
			
			// key set 받아오기 
			Set key = obj.keySet();
			
			// Iterator 설정
			Iterator<String> iter = key.iterator();

			while(iter.hasNext())
			{
				String keyname = iter.next();
				Object result = obj.get(keyname);
				
				if(obj.get(keyname) instanceof JSONObject) {
					System.out.print("JSONObject : ");
				} else if (result instanceof org.json.simple.JSONArray){
					org.json.simple.JSONArray jsonArray = (org.json.simple.JSONArray)result;
					result = jsonArray.get(0);
					System.out.print("JSONArray[" + jsonArray.size() + "] : ");
				} else {
					System.out.print(result.getClass() + " : ");
				}
				System.out.println("key : "+keyname + "\t\tvalue : "+result);
			}
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
    }
	public String getJsonData_KMDB()  {
		String result = "";
		try {
        StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
        //이미지 항목 posters
        urlBuilder.append(Condition("ServiceKey","B40IP5NLA4A22KX077TM"));
        urlBuilder.append(Condition("detail","Y"));
        urlBuilder.append(Condition("title","고향무정"));
        urlBuilder.append(Condition("nation","대한민국"));

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

        result = sb.toString();
		} catch(IOException e) {
			result = "IOException";
		} catch(Exception e) {
			result = "Exception";
		}
        return result;
    }
}
