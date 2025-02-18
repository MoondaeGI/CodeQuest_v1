<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<title>회원가입</title>
<style>
* {
	box-sizing: border-box;
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
}

body {
	background: #f4f7f8;
	display: flex;
	justify-content: center;
	align-items: center;
    min-height: 100vh;
    overflow-y: auto;
}

.container {
	width: 460px;
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	text-align: center;
}

.headline h2 {
	font-size: 22px;
	font-weight: bold;
	color: dodgerblue;
	margin-bottom: 15px;
}

fieldset {
	border: 2px solid dodgerblue;
	border-radius: 6px;
	padding: 15px;
	margin-bottom: 15px;
	text-align: left;
}

legend {
	font-size: 16px;
	font-weight: bold;
	color: dodgerblue;
}

.input-group {
	display: flex;
	gap: 10px;
	align-items: center;
}

input {
	width: 100%;
	padding: 10px;
	margin-top: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
	transition: 0.3s;
}

input:focus {
	border: 1px solid dodgerblue;
	outline: none;
	box-shadow: 0 0 5px rgba(30, 144, 255, 0.5);
}

input[disabled] {
	background: #e9ecef;
}

.buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 15px;
}

.buttons button, .postcode-btn, .id-check-btn {
	flex: 1;
	padding: 12px;
	margin: 5px;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: 0.3s;
}

.buttons button:first-child, .id-check-btn {
	background: dodgerblue;
	color: white;
}

.buttons button:first-child:hover, .id-check-btn:hover {
	background: #0056b3;
}

.buttons button:last-child {
	background: lightgray;
	color: black;
}

.buttons button:last-child:hover {
	background: gray;
	color: white;
}

.postcode-btn {
	background: dodgerblue;
	color: white;
	padding: 12px;
	font-size: 14px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	white-space: nowrap;
	transition: 0.3s;
}

.postcode-btn:hover {
	background: #0056b3;
}

.error {
	border: 2px solid red;
	background-color: #ffecec;
}

.success {
	border: 2px solid green;
	background-color: #eaffea;
}

.id-check-container {
	display: flex;
	gap: 5px;
}

#idi {
	flex: 3;
}

.id-check-btn {
	flex: 1;
	padding: 10px;
	font-size: 14px;
	border-radius: 6px;
	white-space: nowrap;
}

.input-group {
	display: flex;
	gap: 10px;
	align-items: center;
	justify-content: space-between;
	width: 100%;
}

#idi {
	flex: 3;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
}

.id-check-btn {
	flex: 1;
	padding: 12px;
	font-size: 14px;
	background: dodgerblue;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s, transform 0.1s;
	white-space: nowrap;
}

.id-check-btn:hover {
	background: #0056b3;
	transform: scale(1.05);
}

@media ( max-width : 480px) {
	.input-group {
		flex-direction: column;
		gap: 5px;
	}
	.id-check-btn {
		width: 100%;
		padding: 10px;
	}
}
</style>
</head>

<body>
	<div class="container">
		<div class="headline">
			<h2>회원가입</h2>
		</div>
		<form action="/member/add.do" id="signupForm" method="post">
			<fieldset>
				<legend> * 아이디 / 패스워드</legend>
				<div class="input-group">
					<input type="text" name="id" id="id" placeholder="아이디를 입력하세요">
					<button type="button" class="id-check-btn" id="idCheck">ID 중복 체크</button>
				</div>
				<span id="result_id"></span> 
				<input type="password" name="pw" id="pw" placeholder="패스워드를 입력하세요"> 
				<span id="result_pw"></span> 
				<input type="password" name="pwr" id="pwr" placeholder="패스워드를 다시 입력하세요">
				<span id="result_pwr"></span> 
			</fieldset>

			<fieldset>
				<legend> * 이름 / 전화번호 / 이메일</legend>
				<input type="text" name="name" id="name" placeholder="이름을 입력하세요">
				<span id="result_name"></span> 
				<div class="input-group">
					<input type="text" name="ssnFront" id="ssnFront"
						placeholder="주민등록번호 앞자리" maxlength="6"> <span>-</span> <input
						type="text" name="ssnBack" id="ssnBack" placeholder="주민등록번호 뒷자리"
						maxlength="1">
				</div>
				<input type="text" name="phone" id="phone" placeholder="전화번호를 입력하세요">
				<span id="result_phone"></span> 
				<input type="text" name="email" id="email" placeholder="이메일을 입력하세요">
				<span id="result_email"></span> 
			</fieldset>

			<fieldset>
				<legend>주소</legend>
				<div class="input-group">
					<input type="text" name="postcode" id="postcode" placeholder="우편번호"
						readonly>
					<button type="button" class="postcode-btn" id="searchbnt">우편번호
						검색</button>
				</div>
				<input type="text" name="address1" id="address1"
					placeholder="주소를 입력하세요" readonly> <input type="text"
					name="address2" id="address2" placeholder="상세주소를 입력하세요">
			</fieldset>
			<input type="text" placeholder="*는 필수입력사항임." readonly>

			<div class="buttons">
				<button type="submit">가입하기</button>
				<button type="reset">초기화</button>
			</div>
		</form>
	</div>

	<script>
		//Enter 키 입력 방지
		$("#signupForm").on("keydown",function(event) {
			if (event.key === "Enter" || event.keyCode === 13 || event.which === 13) {
				event.preventDefault();
			}
		});
		//ID 중복체크
		$("#idCheck").on("click", function() {
        	if($("#id").val()== "") {
				alert("아이디를 먼저 입력해주세요.");
				return false;
			}
			$.ajax({
				url : "/member/idCheck.do",
				data : {
					id : $("#id").val()
				},
				method : "GET",
				dataType : "text"
			}).done(function(resp) {
				if (resp.trim() === "exist") {
			        $("#result_id").css({"color": "red", "font-size": "12px"}).html("이미 사용중인 ID입니다.");
				} else {
			        $("#result_id").css({"color": "green", "font-size": "12px"}).html("사용가능한 ID입니다.");
				}
			}).fail(function(xhr, status, error) {
				console.error("AJAX 요청 실패:", error);
			});
		});
		$("#ssnFront").on("input", function() {
			let val = $(this).val().replace(/\D/g, "");
			$(this).val(val);
			if (val.length === 6) {
				$("#ssnBack").focus();
			}
		});
		//다음POST API
		$("#searchbnt").on("click", function() {
			new daum.Postcode({
				oncomplete : function(data) {
					$("#postcode").val(data.zonecode);
					$("#address1").val(data.roadAddress);
					$("#address2").focus();
				}
			}).open();
		});
		//회원가입 정규식 유효성 검사
		$("#id").on("keyup", function() {
		    let regex = /^[a-z0-9_]{8,20}$/;
		    let vali = regex.exec($(this).val());
		    if (vali == null) {
		        $("#result_id").css({"color": "red", "font-size": "12px"}).html("ID는 영어소문자,숫자 8자리이상 20자리이하로 작성해주세요.");
		        id_val = false;
		    } else {
		        console.log("유효한 ID:", $(this).val());
		        $("#result_id").css({"color": "green", "font-size": "12px"}).html("유효한 ID입니다.");
		        id_val = true;
		    }
		});
		
		$("#pw").on("keyup", function() {
		    let regex = /^[A-Za-z0-9_]{8,}$/;
		    let vali = regex.exec($(this).val());
		    if (vali == null) {
		        $("#result_pw").css({"color": "red", "font-size": "12px"}).html("유효하지 않는 PW입니다.");
		        pw_val = false;
		    } else {
		        console.log("유효한 PW:", $(this).val());
		        $("#result_pw").css({"color": "green", "font-size": "12px"}).html("유효한 PW 입니다.");
		        pw_val = true;
		    }
		});
		
		$("#pwr").on("keyup", function(e) {
		    if ($("#pw").val() === $(this).val()) {
		        $("#result_pwr").css({"color": "green", "font-size": "12px"}).html("패스워드 일치!");
		        
		    } else {
		        $("#result_pwr").css({"color": "red", "font-size": "12px"}).html("패스워드 일치하지 않음!");
		        pw_val = false;
		    }
		});
		
		$("#name").on("keyup", function() {
		    let regex = /^[가-힣]{2,5}$/;
		    let vali = regex.exec($(this).val());
		    if (vali == null) {
		        $("#result_name").css({"color": "red", "font-size": "12px"}).html("유효하지 않는 이름입니다.");
		        name_val = false;
		    } else {
		        console.log("유효한 이름:", $(this).val());
		        $("#result_name").css({"color": "green", "font-size": "12px"}).html("유효한 이름 입니다.");
		        name_val = true;
		    }
		});
		
		$("#phone").on("keyup", function() {
		    let regex = /^010[ -]?\d{4}[ -]?\d{4}$/;
		    let vali = regex.exec($(this).val());
		    if (vali == null) {
		        $("#result_phone").css({"color": "red", "font-size": "12px"}).html("유효하지 않는 전화번호입니다.");
		        tel_val = false;
		    } else {
		        $("#result_phone").css({"color": "green", "font-size": "12px"}).html("유효한 전화번호 입니다.");
		        tel_val = true;
		    }
		});
		
		$("#email").on("keyup", function() {
		    let regex = /^[A-Za-z0-9_]+@[A-Za-z0-9]+\.[a-zA-Z]{3,4}$/;
		    let vali = regex.exec($(this).val());
		    if (vali == null) {
		        $("#result_email").css({"color": "red", "font-size": "12px"}).html("유효하지 않는 이메일입니다.");
		        email_val = false;
		    } else {
		        console.log("유효한 이메일:", $(this).val());
		        $("#result_email").css({"color": "green", "font-size": "12px"}).html("유효한 이메일 입니다.");
		        email_val = true;
		    }
		});
		
		//회원가입 submit 전 유효성 검사
		$("#signupForm").on("submit", function(event) {
			if(!$("#id").val()) {
				alert("ID는 필수 입력사항입니다.");
				$("#id").focus();
				return false;
			} 
			//else if(!$("#idCheck").val()) {
			//	alert("ID중복검사는 필수 진행사항입니다.");
			//	$("#idCheck").focus();
			//	return false;
			//} 
			else if(!$("#pw").val()) {
				alert("PW는 필수 입력사항입니다.");
				$("#pw").focus();
				return false;
			} else if(!$("#pwr").val()) {
				alert("PW는 필수 입력사항입니다.");
				$("#pwr").focus();
				return false;
			} else if(!$("#name").val()) {
				alert("이름은 필수 입력사항입니다.");
				$("#name").focus();
				return false;
			} else if(!$("#ssnFront").val()) {
				alert("주민등록번호는 필수 입력사항입니다.");
				$("#ssnFront").focus();
				return false;
			} else if(!$("#ssnBack").val()) {
				alert("주민등록번호는 필수 입력사항입니다.");
				$("#ssnBack").focus();
				return false;
			} else if(!$("#phone").val()) {
				alert("전화번호는 필수 입력사항입니다.");
				$("#phone").focus();
				return false;
			} else if(!$("#email").val()) {
				alert("이메일은 필수 입력사항입니다.");
				$("#email").focus();
				return false;
			}
			
		    if (!(id_val && pw_val && name_val && tel_val && email_val)) {
		        alert("입력한 값 중 유효하지 않은 항목이 있습니다. 다시 확인해주세요.");
		        return false;
		    }

		});
		
		
	</script>
</body>

</html>