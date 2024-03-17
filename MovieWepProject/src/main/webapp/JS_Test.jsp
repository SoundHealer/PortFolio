<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meata http-equiv="X-UA-Compatible" content="ie=edge">
<title>apie</title>
</head>
<body>

	<input type="submit" onsubmit="getKakaoData()">
	<script>
		// 필요한 모듈 가져오기
		const fetch = require('node-fetch');

		// Kakao API 정보
		const GEOCODE_URL = "http://dapi.kakao.com/v2/local/search/address.json?query=";
		const GEOCODE_USER_INFO = "KakaoAK a3138b5db7f6811a7a1e1783dd7720e3";

		async
		function getKakaoData() {
			try {
				// 주소를 URI 인코딩
				const address = encodeURIComponent("용마공원로 9길 29");

				// Kakao API 엔드포인트 URL 생성
				const apiUrl = `${GEOCODE_URL}${address}`;

				// API 호출
				const response = await
				fetch(apiUrl, {
					method : "GET",
					headers : {
						Authorization : GEOCODE_USER_INFO,
						"Content-Type" : "application/json",
					},
				});

				// JSON 데이터 파싱
				const data = await
				response.json();

				// JSON 데이터 출력
				console.log(data);
			} catch (error) {
				console.error("API 호출 오류:", error);
			}
		}

		// 함수 호출
		getKakaoData();
	</script>
</body>
</html>