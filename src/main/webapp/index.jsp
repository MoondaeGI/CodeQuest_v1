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
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	width: 100%;
	max-width: 1660px;
	height: 100%;
	max-height: 1024px;
	display: flex;
	flex-direction: column;
	align-items: center;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.15);
	border-radius: 10px;
	background: url('/allback.jpg') no-repeat center;
	background-size: cover;
}

.header, .footer {
	width: 100%;
	height: 80px;
	background: #1e201d;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 20px;
	color: #b4c28a;
	font-family: "Press Start 2P", serif;
	font-weight: 400;
	font-style: normal;
	font-size: 12px;
}

.navi {
	display: flex;
	align-items: center;
	width: 100%;
	justify-content: space-between;
}

.logo {
	font-size: 24px;
	color: #b4c28a;
}

.navi ul {
	list-style: none;
	display: flex;
	gap: 20px;
}

.navi ul li {
	padding: 10px 15px;
	background: white;
	color: #debe85;
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s ease-in-out;
}

.navi ul li:hover {
	background: #81a5bf;
	color: white;
}

/* 로그인 정보 */
.logbox {
	display: none;
	padding: 10px;
	font-weight: bold;
	color: white;
}

/* 본문 */
.body {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
	gap: 5%;
}

/* 게임 리스트 (가로 스크롤 복구) */
.gameList {
	display: flex;
	overflow-x: auto;
	gap: 20px;
	padding: 10px;
	width: 70%;
	scroll-snap-type: x mandatory;
	white-space: nowrap;
	min-height: 320px;
	font-family: "Press Start 2P", serif;
	font-weight: 400;
	font-style: normal;
	font-weight: 400;
}

.gameList h3 {
	font-size: 16px;
	margin: 10px;
}

.gameList p {
	font-size: 14px;
	margin: 10px;
}

.gameList::-webkit-scrollbar {
	height: 8px;
}

.gameList::-webkit-scrollbar-thumb {
	background: #007bff;
	border-radius: 10px;
}

.gameList::-webkit-scrollbar-track {
	background: #ddd;
	border-radius: 10px;
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
	padding: 10px;
	background-size: cover;
}

.game button:hover {
	transform: scale(1.2);
}

.loginbox {
	width: 15%;
	background: url('/login.jpg') no-repeat center;
	background-size: 10 10;
	padding: 20px;
	border-radius: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	min-height: 320px;
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
	margin: 10px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

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
	margin: 3px;
}

.loginbox>.loginBtn {
	font-family: "Jua", serif;
	font-weight: 400;
	font-style: normal;
}

.loginBtn:hover {
	background: #919190
}

.login-links {
	margin: 20px;
}

.boardlist {
	width: 60%;
	height:25%;
	background: url('/boardback.jpg') no-repeat center;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
	text-align: center;
	color:white;
	margin-bottom: 60px;
}
</style>
</head>
<body>
	<div class="container">

		<div class="header">
			<div class="navi">
				<div class="logo">Team CodeQuest</div>
				<ul>
					<li>Home</li>
					<li>Game</li>
					<li>Board</li>
					<li>Service</li>
				</ul>
			</div>
			<%@ include file="logbox.jsp"%>
		</div>

		<!-- 본문 -->
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
					<button></button>
				</div>
			</div>

			<div class="loginbox">
				<h2>로그인</h2>
				<input type="text" id="userId" placeholder="아이디"> <input
					type="password" id="userPw" placeholder="비밀번호">
				<a href="/member/login.do"><button id="loginBtn">로그인</button> </a>
				<div class="login-links">
					<a href="/member/addForm.do">회원가입</a><br>
					<br> <a href="/member/findMember.do">ID/PW 찾기</a>
				</div>
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

		<!-- 푸터 -->
		<div class="footer">© 2025 Team CodeQuest. All rights reserved.</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#loginBtn").click(function() {
				let userId = $("#userId").val();
				let userPw = $("#userPw").val();
				if (userId && userPw) {
					$(".logbox").fadeIn().find("#username").text(userId);
					$(".loginbox").fadeOut();
				} else {
					alert("아이디와 비밀번호를 입력하세요!");
				}
			});
		});
	</script>
</body>
</html>
