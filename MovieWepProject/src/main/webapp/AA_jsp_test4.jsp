<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JavaScript 링크 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
>
<title>테이블 데이터 검색</title>
</head>
<body>
	<%
	for (int i = 0; i < 10; i++) {
	%>
	<div class="BtnCountShowDiv">
		<button class="btn btn-primary incrementButton" data-message="증가버튼">증가</button>
		<button class="btn btn-primary decrementButton" data-message="감소버튼">감소</button>
		<p class="counter">0</p>
	</div>
	<%
	}
	%>
	<script>
	$(document).ready(function() {
	    // 각 버튼과 카운터를 선택
	    var incrementButtons = $('.incrementButton');
	    var decrementButtons = $('.decrementButton');
	    var counters = $('.counter');

	    // 카운터를 독립적으로 관리하기 위한 클로저 함수
	    function createCounter() {
	        var counter = 0; // 초기 카운터 값
	        return function(increment) {
	            if (increment) {
	                counter++; // 증가
	            } else {
	                counter--; // 감소
	            }
	            return counter; // 카운터 값 반환
	        };
	    }

	    // 각 버튼에 대한 클로저 함수 생성
	    var counterFunctions = [];
	    for (var i = 0; i < incrementButtons.length; i++) {
	        counterFunctions.push(createCounter());
	    }

	    // 증가 버튼 클릭 시 해당 버튼에 대한 카운터 업데이트
	    incrementButtons.click(function() {
	        var buttonIndex = incrementButtons.index(this);
	        var counterFunction = counterFunctions[buttonIndex];
	        var updatedCounter = counterFunction(true); // 증가
	        var counter = counters.eq(buttonIndex);
	        counter.text(updatedCounter);
	    });

	    // 감소 버튼 클릭 시 해당 버튼에 대한 카운터 업데이트
	    decrementButtons.click(function() {
	        var buttonIndex = decrementButtons.index(this);
	        var counterFunction = counterFunctions[buttonIndex];
	        var updatedCounter = counterFunction(false); // 감소
	        var counter = counters.eq(buttonIndex);
	        counter.text(updatedCounter);
	    });
	});
	</script>
</body>
</html>
