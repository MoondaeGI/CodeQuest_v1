<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Jua&family=Press+Start+2P&display=swap"
	rel="stylesheet">
<title>Responsive Game Portal</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	display: flex;
	width: 100%;
	height: 100%;
	justify-content: center;
	align-items: center;
	background: url('/allback.jpg') no-repeat center;
	background-size: cover;
}

.container {
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.header, .footer {
	background: #1e201d;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 20px;
	color: #b4c28a;
	font-family: "Press Start 2P", serif;
	font-weight: 400;
	font-style: normal;
	width: 100%;
}

.header {
	height: 80px;
	padding: 20px;
	position: relative;
}

.footer {
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	margin-top: 50px;
}

.header>.navi>.logo {
	font-size: 20px;
}

.navi {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.menu {
	list-style: none;
	display: flex;
	gap: 20px;
}

.menu li {
	padding: 10px 15px;
	background: #717171;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	text-shadow: 0 1px 0 black, -1px 2px 0 black, 1px 4px 0 black, 0 3px 0
		black;
}

.menu li:hover {
	background: #3c3b39;
	color: white;
}

.main-content {
	display: flex;
	width: 100%;
	justify-content: space-between;
	align-items: flex-start;
	margin-top: 20px;
}

/* ✅ 오른쪽 영역 (로그인 박스 + 랭킹보드) */
.right-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start; /* ✅ 상단 정렬 문제 해결 */
	flex: 1;
	min-width: 300px;
}

/* ✅ 본문 (게임 리스트 + 게시판) */
.body {
	width: 70%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

/* ✅ 로그인 박스 */
.loginbox {
	width: 80%; background : url('/login.jpg') no-repeat center;
	background-size: cover;
	padding: 10px;
	border-radius: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	font-family: "Jua", serif;
	margin-bottom: 50px;
	margin-top: 80px;
	background: url('/login.jpg') no-repeat center; background-size : cover;
	padding : 10px; border-radius : 20px; box-shadow : 0 0 10px rgba( 0, 0,
	0, 0.1); text-align : center; font-family : "Jua", serif; margin-bottom
	: 50px; margin-top : 80px;
	margin-right: 75px;
}

/* ✅ 로그인 버튼 및 입력 필드 배치 */
.loginbox h2 {
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	margin: 10px;
	color: #2f2b2b;
}

.loginbox input {
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	width: 70%;
	padding: 10px;
	margin: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* ✅ 아이디 / 비밀번호 입력 필드 + 로그인 버튼 정렬 */
.loginbox .input-group {
	display: flex;
	align-items: center;
	gap: 5px;
	justify-content: center;
}

.loginbox .input-group input {
	width: 60%;
	font-size: 13px;
}

.loginbox .input-group button {
	width: 30%;
	height: 40px;
	font-size: 16px;
	background: #5e5d5a;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.3s;
}

.loginbox .input-group button:hover {
	background: #3c3b39;
}

.login-links button {
	margin: 10px;
	border-radius: 10px;
	padding: 8px;
	transition: background 0.3s;
	font-weight: bold;
	background: #717171;
	color: white;
	font-family: "Jua", serif;
	font-size: 17px;
}

.login-links button:hover {
	background: #003f7f;
	transform: scale(1.1);
}

.login-links {
	margin: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* ✅ 로그인 전 랭킹보드 기본 크기 */
.rankingboard {
	width: 80%;
	height: 500px;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	transition: all 0.5s ease-in-out;
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	font-size: 20px;
	margin-top: 30px;
	margin-right: 80px;
}

/* ✅ 로그인 후 랭킹보드 크기 조정 (body의 절반) */
.rankingboard.expanded {
	width: 80%;
	height: 50%;
	padding: 30px;
}

/* ✅ 랭킹 탭 버튼 스타일 */
.ranking-tabs {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-bottom: 10px;
	font-size: 17px;
}

.loginbox h2 {
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	margin: 10px;
	color: #2f2b2b;
}

.tab-btn {
	padding: 8px 12px;
	background: #ddd;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	transition: 0.3s;
	font-family: "Press Start 2P", serif;
	font-weight: 400;
	font-style: normal;
	font-size: 10px;
	margin-top: 10px;
}

.tab-btn.active {
	background: #5e5d5a;
	color: white;
}

/* ✅ 각 게임별 랭킹 리스트 숨김 */
.hidden {
	display: none;
}

.loginBtn:hover {
	background: #919190
}

.logbox-container {
	position: absolute;
	right: 10px;
	bottom: -35px;
}

.rankingboard ul {
	list-style: none;
	padding: 0;
}

.rankingboard li {
	padding: 5px;
	font-size: 17px;
}

/* ✅ 게임 리스트 */
.gameList {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 25px;
	padding: 10px;
	width: 90%;
	font-family: "Press Start 2P", serif;
	margin-top: 30px;
		text-shadow: 0 1px 0 #a3a3a3, -1px 2px 0 #a3a3a3, 1px 4px 0 #a3a3a3, 0 3px 0
		#a3a3a3;
}

.game {
	min-width: 280px;
	background: white;
	padding: 15px;
	border-radius: 10px;
	text-align: center;
	scroll-snap-align: start;
	transition: transform 0.3s ease-in-out;
}

.game:hover {
	transform: scale(1.05);
}

.game img {
	width: 100%;
	height: 160px;
	border-radius: 10px;
}

.game h3 {
	margin: 10px;
}

.game p {
	margin: 10px;
}

.game button {
	width: 170px;
	height: 60px;
	padding: 10px;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.3s;
	font-family: "Press Start 2P", serif;
	font-weight: 400;
	font-style: normal;
	background: url('/gamebtn.png') no-repeat center;
	background-size: cover;
}

.game button:hover {
	transform: scale(1.2);
}

.boardlist {
	width: 90%;
	background: url('/board.jpg') no-repeat center;
	background-size: cover;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	color: white;
	margin-top: 20px;
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	font-size: 20px;
	text-shadow: 0 1px 0 black, -1px 2px 0 black, 1px 6px 0 black, 0 3px 0
		black;
}

.boardlist h3 {
	margin-bottom: 20px;
}

.boardlist li {
	margin-bottom: 10px;
}
</style>
</head>


<body>

	<div class="container">

		<!-- ✅ 헤더 -->
		<div class="header">
			<div class="navi">
				<div class="logo">Team CodeQuest</div>
				<ul class="menu">
					<li>Home</li>
					<li>Game</li>
					<li>Board</li>
					<li>Service</li>
				</ul>
			</div>
			<!-- ✅ 로그인 정보 -->
			<div class="logbox-container">
				<%@ include file="logbox.jsp"%>
			</div>
		</div>


		<!-- ✅ 좌우 배치 레이아웃 -->
		<div class="main-content">

			<!-- ✅ 본문 (게임 리스트 + 게시판) -->
			<div class="body">
				<div class="gameList">
					<div class="game">
						<img src="game1.jpg">
						<h3>Game 1</h3>
						<p>RPG</p>
						<button>Play</button>
					</div>
					<div class="game">
						<img src="game2.jpg">
						<h3>Game 2</h3>
						<p>FPS</p>
						<button>Play</button>
					</div>
					<div class="game">
						<img src="game3.jpg">
						<h3>Game 3</h3>
						<p>Action</p>
						<button>Play</button>
					</div>
					<div class="game">
						<img src="game4.jpg">
						<h3>Game 4</h3>
						<p>Adventure</p>
						<button>Play</button>
					</div>
					<div class="game">
						<img src="game5.jpg">
						<h3>Game 5</h3>
						<p>Strategy</p>
						<button>Play</button>
					</div>
					<div class="game">
						<img src="game6.jpg">
						<h3>Game 6</h3>
						<p>Sports</p>
						<button>Play</button>
					</div>
				</div>

				<div class="boardlist">
					<h3>📢 최근 게시물</h3>
					<ul>
						<li>게시글 1</li>
						<li>게시글 2</li>
						<li>게시글 3</li>
					</ul>
				</div>
			</div>

			<!-- ✅ 오른쪽 로그인 + 랭킹보드 -->
			<div class="right-content">
				<div class="loginbox">
					<h2>로그인</h2>

					<div class="input-group">
						<input type="text" id="id" placeholder="아이디"> <input
							type="password" id="pw" placeholder="비밀번호">
						<button id="loginBtn">로그인</button>
					</div>

					<div class="login-links">
						<a href="/member/addForm.do"><button>회원가입</button></a><br> <a
							href="/member/findMember.do"><button>ID/PW 찾기</button></a>
					</div>
				</div>

				<div class="rankingboard">
					<h3>🏆 랭킹 보드</h3>

					<div class="ranking-tabs">
						<button class="tab-btn active" data-game="game1">Game 1</button>
						<button class="tab-btn" data-game="game2">Game 2</button>
						<button class="tab-btn" data-game="game3">Game 3</button>
					</div>

					<div class="ranking-content">
						<ul class="ranking-list" id="game1">
							<li>1위 - 플레이어1 (1200점)</li>
							<li>2위 - 플레이어2 (1100점)</li>
							<li>3위 - 플레이어3 (1050점)</li>
						</ul>
						<ul class="ranking-list hidden" id="game2">
							<li>1위 - 플레이어A (2000점)</li>
							<li>2위 - 플레이어B (1800점)</li>
							<li>3위 - 플레이어C (1750점)</li>
						</ul>
						<ul class="ranking-list hidden" id="game3">
							<li>1위 - 플레이어X (900점)</li>
							<li>2위 - 플레이어Y (850점)</li>
							<li>3위 - 플레이어Z (800점)</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- ✅ 푸터 -->
		<div class="footer">© 2025 Team CodeQuest. All rights reserved.</div>

	</div>

	<script>
		$(document)
				.ready(
						function() {
							// ✅ 랭킹 탭 버튼 클릭 이벤트
							$(".tab-btn").click(function() {
								$(".tab-btn").removeClass("active");
								$(this).addClass("active");

								let gameId = $(this).data("game");
								$(".ranking-list").addClass("hidden");
								$("#" + gameId).removeClass("hidden");
							});

							// ✅ 로그인 처리
							$("#loginBtn")
									.click(
											function() {
												let userId = $("#id").val()
														.trim();
												let userPw = $("#pw").val()
														.trim();

												if (userId === ""
														|| userPw === "") {
													alert("아이디와 비밀번호를 입력하세요!");
													return false;
												}

												$
														.ajax(
																{
																	url : "/member/login.do",
																	method : "POST",
																	data : {
																		id : userId,
																		pw : userPw
																	},
																	dataType : "text"
																})
														.done(
																function(resp) {
																	if (resp
																			.trim() === "success") {
																		$(
																				".loginbox")
																				.fadeOut(
																						function() {
																							let bodyHeight = $(
																									".body")
																									.outerHeight() / 2;
																							$(
																									".rankingboard")
																									.addClass(
																											"expanded")
																									.css(
																											"height",
																											bodyHeight);
																						});

																		$(
																				".logbox-container")
																				.load(
																						"logbox.jsp",
																						function() {
																							$(
																									".logbox")
																									.fadeIn();
																						});
																	} else {
																		alert("로그인 실패. 아이디/비밀번호를 확인하세요.");
																	}
																})
														.fail(
																function(xhr,
																		status,
																		error) {
																	console
																			.log(
																					"로그인 AJAX 실패:",
																					error);
																	console
																			.log("code: "
																					+ request.status)
																	console
																			.log("message: "
																					+ request.responseText)
																	console
																			.log("error: "
																					+ error);
																});
											});
						});
	</script>

</body>
</html>