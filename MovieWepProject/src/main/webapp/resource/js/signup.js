function checkSignUpDataJsFile(year,month,day) {
	var form = document.getElementById('userInfoForm');

	var userName = form.userName.value;
	var userId = form.userId.value;
	var userPw = form.userPw.value;
	var checkPassword = form.checkPassword.value;
	var userEmail_1 = form.userEmail_1.value;
	var userEmail_2 = form.userEmail_2.value;
	var birthDay = year + "-" + month + "-" + day;
	var userAddress = form.userAddress.value;
	var Genre_1 = form.Genre_1.value;
	var Genre_2 = form.Genre_2.value;
	var Genre_3 = form.Genre_3.value;
	var Genre_4 = form.Genre_4.value;
	
	var errorMessages = "";
	var data = {
            "userName":userName,
            "userId": userId,
            "userPw": userPw,
            "userEmail": userEmail_1 +'@'+ userEmail_2,
            "birthDay": birthDay,
            "userAddress": userAddress,
            "Genre_1": Genre_1,
            "Genre_2": Genre_2,
            "Genre_3": Genre_3,
            "Genre_4": Genre_4
        };
	// 이름 길이 검사
	//alert("이름 검사");
	if (userName.length < 2 || userName.length > 10) {
		errorMessages = errorMessages + "\n" + "이름은 2글자 이상 10글자 이하여야 합니다.";
	}
	// 이름 유효성 검사
	if (!isValidName(userName)) {
		errorMessages = errorMessages + "\n" + "이름은 특수문자가 포함될 수 없습니다.";
	}

	//alert("아이디 검사");
	// 아이디 길이 검사
	if (userId.length < 8 || userId.length > 20) {
		errorMessages = errorMessages + "\n" + "아이디는 8글자 이상 20글자 이하여야 합니다.";
	}
	// 아이디 유효성 검사
	if (!isValidIdPw(userId)) {
		errorMessages = errorMessages + "\n" + "아이디는 영어와 숫자만 사용할수 있습니다.";
	}

	//alert("패스워드 검사");
	// 패스워드 길이 검사
	if (userPw.length < 8 || userPw.length > 20) {
		errorMessages = errorMessages + "\n" + "패스워드는 8글자 이상 20글자 이하여야 합니다.";
	}
	// 패스워드 유효성 검사
	if (!isValidIdPw(userPw)) {
		errorMessages = errorMessages + "\n" + "패스워드는 영어와 숫자만 사용할수 있습니다.";
	}
	// 패스워드 일치 확인
	if(!(userPw===checkPassword)){
		errorMessages = errorMessages + "\n" + "패스워드가 일치하지 않습니다.";
	}

	//alert("이메일 검사");
	if (!isValidEmail(userEmail_1, userEmail_2)) {
		errorMessages = errorMessages + "\n" + "올바른 이메일 주소 형식이 아닙니다.";
	}

	//alert("날짜 검사");
	if (!isValidBirthDay(birthDay)) {
		errorMessages = errorMessages + "\n" + '잘못된 날짜입니다.';
	}

	if (errorMessages.length > 0) {
		// 에러 메시지를 화면에 표시하거나 다른 방법으로 사용자에게 알릴 수 있습니다.
		alert(errorMessages);
		return false; // 폼 제출을 막음
	}
	var result = -1;
	$.ajax({
        type: "POST",
        url: "SignUp", // 서블릿 경로
        data: JSON.stringify(data), // JSON 형식으로 데이터 전송
        contentType: "application/json",
        async: false, 
        success: function(response) {
            // 서버로부터의 응답 처리
        	result = response.message;
        	
        	//alert(response.message + ":" + result); // 서버의 응답 메시지 출력
        }
    });
	
	if(result == 0) {
		alert("회원가입이 완료되었습니다.");
	} else if(result == 1) {
		alert("사용할수 없는 아이디 입니다.");
		return false;
	} else {
		alert("회원가입에 실패했습니다.");
		return false;
	}
	// DB등록
	return true; // 유효성 검사 통과
}

function isValidEmail(userEmail_1, userEmail_2) {
	var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	return emailPattern.test(userEmail_1 + "@" + userEmail_2);
}

function isValidBirthDay(birthDay) {
	var today = new Date();
	var inputDate = new Date(birthDay);
	return inputDate < today; // 생년월일이 오늘 이후인지 확인
}

function isValidName(inputString) {
	var regex = /^[a-zA-Z0-9가-힣]*$/; // 한글, 영문, 숫자만 허용
	return regex.test(inputString);
}

function isValidIdPw(inputString) {
	var regex = /^[a-zA-Z0-9]*$/; // 영문, 숫자만 허용
	return regex.test(inputString);
}

function checkPassword_f(){
	var guideTextBox = document.getElementById("passwordGuide");
	var userPw = document.getElementById('userPw').value;
	var checkPassword = document.getElementById('checkPassword').value;
    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	if(userPw !== checkPassword){
        guideTextBox.innerHTML = '패스워드가 일치하지 않습니다.';
        guideTextBox.style.display = 'block';
        guideTextBox.style.color = "red";
    }else{
    	guideTextBox.innerHTML = '패스워드가 일치합니다.';
        guideTextBox.style.display = 'none';
        guideTextBox.style.color = "blue";
    }
}
function idcheck_f() {
	const button = document.getElementById('idCheck_btn');
	const input = document.getElementById("userId");
	button.style.backgroundColor = "blue"; // 색상 변경
	button.style.color = "white"; // 글자색 변경
	button.style.borderRadius = "5px";
	button.value = "확인됨";
	input.disabled = true;
}
function updateGenreList() {
    const datalist = document.getElementById('genre');

    // 모든 입력란의 값을 모으기
    const inputs = document.querySelectorAll('input[list="genre"]');
    const inputValues = Array.from(inputs).map(input => input.value);

    // 모든 옵션을 다시 보이도록 설정
    for (let i = 0; i < datalist.options.length; i++) {
        datalist.options[i].disabled = false;
    }

    // 다른 모든 입력란에서 입력된 값을 비활성화
    inputs.forEach((input, index) => {
        const otherInputs = inputValues.slice();
        otherInputs.splice(index, 1); // 현재 입력을 제외

        otherInputs.forEach(otherValue => {
            for (let j = 0; j < datalist.options.length; j++) {
                if (datalist.options[j].value === otherValue) {
                    datalist.options[j].disabled = true;
                }
            }
        });
    });
}
function inputEmail_2(){
	var userEmail2 = document.getElementById('userEmail_2');
	if (userEmail2.value === '직접입력') {
        // "직접입력"을 선택한 경우 텍스트 상자 값을 공백으로 설정
		userEmail2.placeholder = '직접입력';
		userEmail2.value = '';
    }
}