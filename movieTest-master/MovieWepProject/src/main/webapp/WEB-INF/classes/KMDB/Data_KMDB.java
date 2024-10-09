package KMDB;
//삭제
//String jsonFilePath = "C:\\Users\\gusrl\\Desktop\\tt.json";
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Data_KMDB {
	public static void main(String[] args) {
		// JSON 파일 경로 설정
		String jsonFilePath = "C:\\Users\\gusrl\\Desktop\\tt.json";

		Data_KMDB data = new Data_KMDB();
		KMDBTest test = new KMDBTest();
		String stringJsonData = test.getJsonData_KMDB();
		data.jsonData(stringJsonData);

	}

	public String getKeyName(String key) {
		String[] keyValues = { "Codes", "CommCodes", "directors", "plots", "ratings", "staffs", "vods" ,"actors"};
		String[] keyValue = { "Code", "CommCode", "director", "plot", "rating", "staff", "vod" ,"actor"};
		for (int i = 0; i<keyValues.length; i++) {
			if (keyValues[i].equals(key)) {
				return keyValue[i];
			}
		}
		return "";
	}

	public JSONObject resultJSONArray(Object item) {
	    JSONObject result = new JSONObject(); // result 객체 초기화
	    
	    if (item instanceof JSONObject) {
	        JSONObject jsonItem = (JSONObject) item;

	        for (Object key : jsonItem.keySet()) {
	            Object value = jsonItem.get(key);

	            if (!(value instanceof JSONObject)) {
	                // JSON 객체가 아닌 키-값 쌍인 경우에만 result에 추가
	                result.put(key, value);
	            }else {
	            	JSONObject objecteData = (JSONObject)value;
	            	String newKey = getKeyName((String)key);
	            	Object valuew = objecteData.get(newKey);
	            	result.put(newKey, valuew);
	            }
	        }
	    }
	    return result;
	}

	public void jsonData(String path) {

		try {
			// 파일 읽기
			

			// JSON 파서 생성
			JSONParser jsonParser = new JSONParser();

			// JSON 파일 파싱
			JSONObject jsonObject = (JSONObject) jsonParser.parse(path);

			// "Data" 배열 가져오기
			JSONArray dataArray = (JSONArray) jsonObject.get("Data");

			if (dataArray != null && dataArray.size() > 0) {
				// "Data" 배열의 첫 번째 요소 가져오기
				JSONObject firstDataObject = (JSONObject) dataArray.get(0);

				// "Result" 키의 값을 가져오고 JSON 배열로 형변환
				JSONArray resultArray = (JSONArray) firstDataObject.get("Result");

				// JSON 배열의 항목들을 Java 리스트로 변환
				List<JSONObject> resultList = new ArrayList<>();
				for (Object item : resultArray) {
					if (item instanceof JSONObject) {

						resultList.add(resultJSONArray(item));
					}
				}

				// 결과 확인
				for (JSONObject resultItem : resultList) {
					System.out.println(resultItem.toJSONString());
				}
			} else {
				System.out.println("Data 배열이 비어 있습니다.");
			}

			// 파일 닫기
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
