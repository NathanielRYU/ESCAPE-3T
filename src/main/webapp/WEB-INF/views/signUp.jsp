<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입초기페이지</title>
</head>
<script src="resources/js/resource.js"></script>
<script src="resources/js/signUp.js"></script>
<style>
@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-weight: 400;
	font-style: normal;
}

button {
	background-color: transparent;
}

#basic {
	font-family: 'Pretendard-Regular';
	position: absolute;
	height: 95%;
	width: 99.6%;
}

#top {
	font-family: 'Pretendard-Regular';
	height: 7%;
	width: 99.6%;
	background-color: #292929;
}

#logo {
	margin: 1% 0% 2% 2%;
	width: 12.5%;
	height: 3%;
	position: absolute;
}

#search {
	width: 44.5%;
	height: 2.3%;
	position: absolute;
	top: 1%;
	left: 26%;
}

#searchFont {
	border: 2px solid #FFCD36;
	font-size: 20pt;
	padding: 1.2% 20% 0% 15%;
	margin-left: 1%;
}

#searchZoom {
	padding: 0% 1% 1% 1%;
	font-size: 15pt;
	position: absolute;
	top: 55%;
	left: 62%;
	border: 0 solid black;
	background-color: white;
	cursor: pointer;
	color: #767F86;
}

#searchZoom:hover {
	cursor: pointer;
	font-weight: bold;
}

#box1 {
	width: 35.5%;
	height: 3.4%;
	position: absolute;
	top: 2.2%;
	left: 57.5%;
}

#login1 {
	width: 28.3%;
	height: 43%;
	margin-left: 22%;
	float: left;
	color: #ebedec;
	font-size: 10pt;
}

#notice {
	width: 15%;
	height: 43%;
	margin-left: 5%;
	float: left;
	color: #ebedec;
	font-size: 10pt;
}

#shop {
	width: 15%;
	height: 43%;
	margin-left: 5.8%;
	float: left;
	color: #ebedec;
	font-size: 10pt;
}

.top_menu {
	font-family: 'Pretendard-Regular';
	font-size: 150%;
	cursor: pointer;
}

#list {
	width: 4.4%;
	height: 4.8%;
	position: absolute;
	top: 1.3%;
	left: 93.5%;
	background-color: #a2a9af;
}

#mid1 {
	font-family: 'Pretendard-Regular';
	width: 98.8%;
	height: 86.9%;
}

#line1 {
	border: 3px solid #292929;
	margin: 0.3% 0% 0% 0%;
	background-color: #1C1F88;
}

#login2 {
	width: 15%;
	height: 4.5%;
	margin: 3% 0% 0% 10.7%;
}

.login2 {
	font-family: TmonMonsori;
	font-size: 20pt;
	color: #292929;
	font-weight: bold;
	position: absolute;
	top: 24%
}

#home {
	width: 3%;
	height: 4%;
	position: absolute;
	right: 17%;
	top: 25%;
}

.home {
	font-family: TmonMonsori;
	font-size: 140%;
	color: #CBCBCB;
	cursor: pointer;
}

#arrow {
	width: 3%;
	height: 4%;
	position: absolute;
	right: 15%;
	top: 25%;
}

#login2-1 {
	width: 6%;
	height: 4%;
	position: absolute;
	right: 10.5%;
	top: 25%;
}

.login2-1 {
	font-family: TmonMonsori;
	font-size: 140%;
	color: #000000;
}

#line2 {
	border: 1px solid #292929;
	margin: 5% 10.5% 1% 10.5%;
	background-color: #1C1F88;
}

#mid2 {
	font-family: 'Pretendard-Regular';
	position: absolute;
	top: 15%;
	left: 50%;
	width: 50%;
	height: 10%;
}

#mid1 {
	font-family: 'Pretendard-Regular';
	height: 75%;
}

#memberlogin_btn {
	font-family: 'Pretendard-Regular';
	box-shadow: 3px 3px 10px #566270;
	width: 50%;
	height: 20%;
	padding: 2%;
	text-align: left;
	margin: 1% 0% 1% 25%;
	background-color: #292929;
	position: ablsolute;
	top: 20%;
	left: 10%;
	color: #ebedec;
	cursor: pointer;
}

.triangle {
	float: right;
	width: 0px;
	height: 0px;
	border-top: 10px solid transparent;
	border-left: 10px solid #ebedec;
	border-bottom: 10px solid transparent;
	border-right: 10px solid transparent;
}

#login_type {
	position: absolute;
	top: 33%;
	left: 8%;
	width: 80%;
	height: 30%;
}

#storelogin_btn {
	font-family: 'Pretendard-Regular';
	box-shadow: 3px 3px 10px #566270;
	width: 50%;
	height: 20%;
	padding: 2%;
	text-align: left;
	margin: 1% 0% 1% 25%;
	background-color: #292929;
	position: ablsolute;
	top: 20%;
	left: 10%;
	color: #ebedec;
	cursor: pointer;
}

#bottom {
	font-family: 'Pretendard-Regular';
	border: 3px solid #292929;
	width: 99.6%;
	height: 19%;
	position: absolute;
	bottom: 0%;
}
</style>
<body>
	<form name="logInForm" action="LogInMember" method="post">
		<div id="basic">
			<div id="top">
				<div id="logo" /></div>
				<div id="search">
					<input id="searchFont" type="text" name="" placeholder="" /><input
						id="searchZoom" type="button" value="SEARCH" />
				</div>
				<div id="box1">
					<div id="login1">
						<span class="top_menu" onClick="getNewPage('memberLogIn')" >로그인/</span><span class="top_menu"  onClick="getNewPage('signUp')">회원가입</span>
					</div>
					<div id="notice">
						<span class="top_menu" onClick="">공지사항</span>
					</div>
					<div id="shop">
						<span class="top_menu" onClick="">장바구니</span>
					</div>
				</div>
				<img id="list" src='resources/images/list.png' />
			</div>

			<div id="mid1">
				<div id="line1"></div>
				<div id="login2">
					<span class="login2">회원가입 (SIGNUP)</span>
				</div>
				<div id="home">
					<span class="home" onClick="getNewPage('basic')">홈</span>
				</div>
				<div id="arrow">
					<span class="home">></span>
				</div>
				<div id="login2-1">
					<span class="login2-1">회원가입</span>
				</div>
				<div id="line2"></div>

				<div id="login_type">
					<div id="memberlogin_btn">
						<div class="login_type1" onClick="getNewPage('addMember')">
							<span>사용자 가입<br></span>
							<div class="triangle"></div>
							<span>일반적으로 장비 대여 또는 캠핑,낚시 장소를 찾으시는 분이 가입하는 유형</span>
						</div>
					</div>
					<div id="storelogin_btn">
						<div class="login_type2" onClick="getNewPage('addStore')">
							<span>업체 가입<br></span>
							<div class="triangle"></div>
							<span>캠핑장, 낚시터 및 장비 대여 서비스 업체를 운영하고 계시는 분이 가입하는 유형</span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="bottom">
			<div id="store_name">
				<span class="end">여기가 좋을 지도¿</span>
			</div>
			<div id="cs_number">
				<div id="cs">
					<span class="end">CS NUMBER</span>
				</div>
				<div id="number">
					<span class="end">1644 - 3681</span>
				</div>
			</div>
			<div id="nate1">
				<span class="nate">21968 인천광역시 연수구 원인재로 81(동춘동, 삼성럭키아파트)
					㈜CHILDNATE｜대표이사 : NATE</span>
			</div>
			<div id="nate2">
				<span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수
					1655호｜개인정보 보호책임자 : NATE</span>
			</div>
			<div id="nate3">
				<span class="nate">문의 : handaeng1220@gmail.com</span>
			</div>
			<div id="nate4">
				<span class="nate">㈜CHILDNATE의 사전 서면동의 없이 여기 좋을 지도 사이트(PC,
					모바일, 앱)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</span>
			</div>
		</div>
		
	</form>
</body>
</html>