<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>지도</title>
    <style>
        /* 지도를 표시할 요소의 크기를 지정합니다. */
        #map {
            height: 800px;
            width: 100%;
        }
    </style>
    
    <link rel="stylesheet" href="resource/css/styles1.css">
    
</head>
<body>

	<header>
		<div id="top">
		<!-- 다운후 변경 -->
			<jsp:include page="loadFile/top.jsp" /> 
			<jsp:include page="loadFile/menuBar.jsp" />
		</div>
	</header>
	
    <h4>지도</h4>
    <!-- 검색창 추가 -->
    <input type="text" id="locationSearch" placeholder="원하시는 위치를 입력하세요" onkeydown="if(event.keyCode==13){searchLocation()}">
    <button onclick="searchLocation()">검색</button>

    <div id="regionButtons"></div>
    
    <div id="map">
    
    </div>
    
    <footer>
		<div id="bottom">
			<jsp:include page="loadFile/bottom.jsp" />
		</div>
	</footer>

    <script>
        // Google Maps API 키
        const apiKey = 'AIzaSyCFWttU33_ZQvbz5cU1vdkdtcyPL2Tr53U'; // 여기에 본인의 Google Maps API 키를 넣어주세요.
        let map;
        let myLocationMarker;
        let infoWindow;
        let allMarkers = []; // 모든 마커를 저장할 배열
        let circle;

     // 검색 함수 정의
        function searchLocation() {
            const locationSearch = document.getElementById('locationSearch').value.toLowerCase();
            // 검색어가 비어있는 경우, 파란 원 안에 있는 마커만 표시
            if (locationSearch === "") {
                showMarkersInsideCircle(circle, allMarkers);
                return;
            }
            // 검색어와 광역단체 또는 기초단체 정보를 비교하여 필터링
            allMarkers.forEach(marker => {
                const governmentType1 = marker.governmentType1.toLowerCase();
                const governmentType2 = marker.governmentType2.toLowerCase();
                const governmentType3 = marker.governmentType3.toLowerCase();
                const governmentType4 = marker.governmentType4.toLowerCase();

                if (governmentType1.includes(locationSearch) ||
                    governmentType2.includes(locationSearch) ||
                    governmentType3.includes(locationSearch) ||
                    governmentType4.includes(locationSearch)) {
                    marker.setMap(map); // 검색어와 일치하는 경우 마커 표시
                } else {
                    marker.setMap(null); // 검색어와 일치하지 않는 경우 마커 숨김
                }
            });
        }   

        // 버튼을 클릭하여 지역 데이터를 검색하고 표시하는 함수 정의
        function searchByRegion(region) {
            allMarkers.forEach(marker => {
                const governmentType1 = marker.governmentType1.toLowerCase();
                const governmentType2 = marker.governmentType2.toLowerCase();
                const governmentType3 = marker.governmentType3.toLowerCase();
                const governmentType4 = marker.governmentType4.toLowerCase();

                if (governmentType1.includes(region) ||
                    governmentType2.includes(region) ||
                    governmentType3.includes(region) ||
                    governmentType4.includes(region)) {
                    marker.setMap(map); // 선택한 지역과 일치하는 경우 마커 표시
                } else {
                    marker.setMap(null); // 선택한 지역과 일치하지 않는 경우 마커 숨김
                }
            });
        }

        // 모든 마커를 숨기고 원 안에 들어오는 마커만 표시하는 함수
        function showMarkersInsideCircle(circle, markers) {
            markers.forEach(marker => {
                const markerPosition = marker.getPosition();
                const circleCenter = circle.getCenter();
                const markerLatLng = new google.maps.LatLng(markerPosition.lat(), markerPosition.lng());
                const circleLatLng = new google.maps.LatLng(circleCenter.lat(), circleCenter.lng());
                const distance = google.maps.geometry.spherical.computeDistanceBetween(markerLatLng, circleLatLng);

                // 거리와 formattedDistance 값을 콘솔에 출력
                const formattedDistance = (distance / 1000).toFixed(2);
                console.log(`Distance: ${distance} meters, Formatted Distance: ${formattedDistance} km`);

                // 거리가 radius 이내인 경우에만 마커 표시
                if (distance <= circle.getRadius()) {
                    marker.setMap(map);
                } else {
                    marker.setMap(null);
                }
            });
        }

        // 내 위치를 변경할 때마다 마커 표시 업데이트
        function updateMarkersOnLocationChange() {
            google.maps.event.addListener(map, 'dragend', function () {
                showMarkersInsideCircle(circle, allMarkers);
            });
        }

        // Google Maps 초기화 및 내 위치 설정
        function initMap() {
            // 사용자의 현재 위치를 가져오기
            navigator.geolocation.getCurrentPosition((position) => {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;

                // Google Maps 초기화
                map = new google.maps.Map(document.getElementById('map'), {
                    center: { lat, lng }, // 사용자의 현재 위치로 설정
                    zoom: 17, // 초기 줌 레벨
                });

                // 내 위치를 파란색 마커로 표시
                myLocationMarker = new google.maps.Marker({
                    position: { lat, lng },
                    map: map,
                    title: '내 위치',
                    icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
                });

                // 10km 반경의 원을 생성합니다.
                circle = new google.maps.Circle({
                    strokeColor: '#0000FF', // 원의 테두리 색상 (파란색)
                    strokeOpacity: 0.3, // 테두리 투명도
                    strokeWeight: 1, // 테두리 두께
                    fillColor: '#0000FF', // 원의 내부 채우기 색상 (파란색)
                    fillOpacity: 0.05, // 내부 채우기 투명도
                    map: map,
                    center: { lat, lng }, // 원의 중심 좌표
                    radius: 10000, // 반지름
                });

                // InfoWindow 객체 생성
                infoWindow = new google.maps.InfoWindow();

                // 데이터베이스에서 가져온 주소 정보를 사용하여 좌표를 가져와서 마커 생성 및 표시
                <% 
                // CinemaDataAccess 클래스를 사용하여 주소 정보를 읽어옵니다.
                CinemaDataAccess cinemaDataAccess = new CinemaDataAccess();
                List<Cinema> cinemaList = cinemaDataAccess.getAllCinemaData();

        		for (Cinema cinema : cinemaList) {
                %>
                
                    // 주소를 좌표로 변환
                    const address = "<%= cinema.getAddress() %>";
                    const name = "<%= cinema.getName() %>";
                    const callno = "<%= cinema.getCallno() %>";
                    const homepage = "<%= cinema.getWep() %>";
                    
                    // 주소를 좌표로 변환하는 Geocoding API 요청
                    const geocoder = new google.maps.Geocoder();
                    geocoder.geocode({ address: address }, function (results, status) {
                        if (status === 'OK' && results[0]) {
                            const lat = results[0].geometry.location.lat();
                            const lng = results[0].geometry.location.lng();

                            // 마커 생성
                            const marker = new google.maps.Marker({
                                position: { lat, lng },
                                map: map,
                                title: name, // 마커 제목 설정
                            });

                            allMarkers.push(marker); // 모든 마커를 배열에 추가

                            // 마커를 클릭했을 때 InfoWindow에 정보를 표시
                            marker.addListener('click', () => {
                                let content = `<strong>${name}</strong><br>`;
                                content += `주소: ${address}<br>`;
                                content += `전화번호: ${callno}<br>`;
                                content += `홈페이지: <a href="${homepage}" target="_blank">${homepage}</a><br>`;

                                const markerPosition = marker.getPosition();
                                const myLocation = myLocationMarker.getPosition();
                                const distance = google.maps.geometry.spherical.computeDistanceBetween(markerPosition, myLocation);
                                const formattedDistance = (distance / 1000).toFixed(2); // 거리를 킬로미터 단위로 표시 (소수점 2자리까지)

                                content += `내 위치와의 거리: ${formattedDistance} km`;

                                infoWindow.setContent(content);
                                infoWindow.open(map, marker); // 마커 근처에 InfoWindow 열기
                            });
                        } else {
                            console.error('Geocoding 실패: ' + status);
                        }
                    });
                <% } %>

                // 중복 값을 저장할 Set 객체 생성
                const uniqueValues = new Set();

                // 중복 값을 Set에 추가
                markerData.forEach(data => {
                    const rb = data.governmentType1;
                    uniqueValues.add(rb);
                });

                // 중복 값을 제거하고 고유한 값만 버튼으로 생성
                const regionButtonDiv = document.getElementById('regionButtons');
                uniqueValues.forEach(value => {
                    const regionButton = document.createElement('button');
                    regionButton.textContent = value; // 버튼 텍스트 설정
                    regionButton.onclick = function () {
                        searchByRegion(value); // 해당 버튼을 클릭하면 검색 함수 호출
                    };
                    regionButtonDiv.appendChild(regionButton); // 버튼을 div에 추가
                });

                // 초기화 코드가 실행되고 난 후에 마커 표시 업데이트
                showMarkersInsideCircle(circle, allMarkers);
            });

            // 내 위치를 변경할 때마다 마커 표시 업데이트
            updateMarkersOnLocationChange();
        }
    </script>

    <!-- Google Maps JavaScript API를 로드 -->
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFWttU33_ZQvbz5cU1vdkdtcyPL2Tr53U&callback=initMap">
    </script>
</body>
</html>
