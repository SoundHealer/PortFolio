// JavaScript 코드
document.addEventListener("DOMContentLoaded", function() {
	// 각 하위 메뉴 항목을 클릭했을 때 해당 페이지로 이동
	const submenuLinks = document.querySelectorAll(".submenu a");
	submenuLinks.forEach(link => {
		link.addEventListener("click", function(event) {
			event.preventDefault(); // 기본 동작(링크 이동) 방지
			const pageUrl = this.getAttribute("href");
			window.location.href = pageUrl; // 클릭한 항목의 링크로 이동
		});
	});
});
function getPosition(name) {
	var element = document.getElementById(name);
	var rect = element.getBoundingClientRect();
	return {
		top : rect.top,
		left : rect.left,
		bottom : rect.bottom,
		left : rect.left
	}
}

// JavaScript 코드   보여주기 위한 자바스크립트 코드 이걸 kdmb 영화 검색 api가 적용되어야 하기 때문에 필히 수정해야 한다.
document.addEventListener("DOMContentLoaded", function() {
	const searchInput = document.getElementById("searchInput");
	const searchButton = document.getElementById("searchButton");
	const searchResults = document.getElementById("searchResults");

	searchButton.addEventListener("click", function() {
		const searchTerm = searchInput.value;

		// 검색어가 비어 있지 않은 경우에만 검색을 실행
		if (searchTerm.trim() !== "") {
			// 여기에서 검색 결과를 가져오고 표시하는 코드를 작성하세요.
			// 서버 측 언어(PHP, Node.js 등)를 사용하여 검색 결과를 가져올 수 있습니다.
			// 가져온 결과를 HTML로 동적으로 생성하여 searchResults 영역에 추가합니다.
			// 아래는 예시 코드입니다.
			
			// 예시: 검색어를 서버로 보내고 JSON 형식의 결과를 받는다고 가정
			fetch(`search_movies.php?term=${searchTerm}`)
				.then(response => response.json())
				.then(data => {
					// 검색 결과를 HTML로 생성
					let html = "";
					data.forEach(movie => {
						html += `
							<div class="card">
								<img src="${movie.poster}" class="card-img-top" alt="${movie.title} 포스터">
								<div class="card-body">
									<h5 class="card-title">${movie.title}</h5>
									<p class="card-text">감독: ${movie.director}</p>
									<!-- 여기에 더 많은 영화 정보를 추가하세요. -->
								</div>
							</div>
						`;
					});
					// 검색 결과를 표시할 영역에 추가
					searchResults.innerHTML = html;
				})
				.catch(error => {
					console.error("검색 오류:", error);
					// 검색 오류 처리 코드를 추가하세요.
				});
		}
	});
});

// JavaScript 코드 보여주기 위한 자바스크립트 코드 이걸 kdmb 박스오피스 순위와 api가 적용되어야 하기 때문에 필히 수정해야 한다.


/* JavaScript를 사용하여 하위 메뉴 표시 */
document.addEventListener("DOMContentLoaded", function () {
	const menuItems = document.querySelectorAll(".nav-item");

	menuItems.forEach(function (menuItem) {
		menuItem.addEventListener("mouseenter", function () {
			this.querySelector(".submenu").style.display = "block";
		});

		menuItem.addEventListener("mouseleave", function () {
			this.querySelector(".submenu").style.display = "none";
		});
	});
});

document.addEventListener("DOMContentLoaded", function() {
	//특정 위치에 지도 소환
	const map = new google.maps.Map(document.getElementById("map"), {
		center: { lat: 37.7749, lng: -122.4194 }, // 임의 위치 지정
		zoom: 13 // 줌 레벨 조정
	});

	// 영화관 마커 더하기 예시
	const theaterMarker = new google.maps.Marker({
		position: { lat: 37.7749, lng: -122.4194 }, // 극장 위치 지정
		map: map,
		title: "부평cgv" // 영화관 이름
	});

	//필요한 더 많은 마커 더하기
	// You can fetch theater data from an API and loop through the data to create markers
});



