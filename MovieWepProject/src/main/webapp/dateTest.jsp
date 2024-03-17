<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>API 결과 출력</title>
    <script>
        function fetchAPI() {
            var xhr = new XMLHttpRequest();
            var url = 'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&nation=대한민국';
            
            // 서비스 키와 다른 매개변수 추가
            var queryParams = '?' + encodeURIComponent('ServiceKey') + "=" + encodeURIComponent('B40IP5NLA4A22KX077TM');

            xhr.open('GET', url + queryParams);
            xhr.onreadystatechange = function () {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        // API 호출이 성공하면 결과를 출력
                        var response = JSON.parse(this.responseText);
                        var resultDiv = document.getElementById('apiResult');
                        resultDiv.innerHTML = 'API 결과: ' + JSON.stringify(response);
                    } else {
                        // API 호출이 실패한 경우 에러 메시지 출력
                        alert('API 호출 실패. 상태 코드: ' + this.status);
                    }
                }
            };
            xhr.send('');
        }
    </script>
</head>
<body>
    <h1>API 결과 출력</h1>
    <button onclick="fetchAPI()">API 호출</button>
    <div id="apiResult"></div>
</body>
</html>
