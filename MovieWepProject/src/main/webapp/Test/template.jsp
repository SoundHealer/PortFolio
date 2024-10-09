<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>JSP with JavaScript</title>
<script>
	$(document).ready(function() {
		$(".dataList").on("focus", function() {
			var $this = $(this);
			var allElements = $(".dataList").not($this); // 현재 포커스된 요소를 제외한 다른 요소들
			allElements.each(function() {
				var listName = $(this).attr('class').split(" ")[1];
				console.log("선택 항목["+$this.val()+"]: " + listName);
			});
		});
	});
</script>
</head>
<body>
	<input type="text" class="dataList list1">
	<input type="text" class="dataList list2">
	<input type="text" class="dataList list3">
</body>
</html>
