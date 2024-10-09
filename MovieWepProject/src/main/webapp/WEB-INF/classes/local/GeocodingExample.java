package local;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;

public class GeocodingExample {
    public static void main(String[] args) {
        // Google Maps Geocoding API 키
        String apiKey = "YOUR_API_KEY_HERE";

        // 주소 문자열
        String address = "1600 Amphitheatre Parkway, Mountain View, CA";

        // GeoApiContext 생성
        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey(apiKey)
                .build();

        try {
            // 주소를 위도와 경도로 변환
            GeocodingResult[] results = GeocodingApi.geocode(context, address).await();
            if (results != null && results.length > 0) {
                LatLng location = results[0].geometry.location;
                double latitude = location.lat;
                double longitude = location.lng;

                System.out.println("위도: " + latitude);
                System.out.println("경도: " + longitude);
            } else {
                System.out.println("주소를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
