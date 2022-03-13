<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="resources/js/resource.js"></script>
<script src="resources/js/signUp.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/findIdPassword.css" />
<link rel="stylesheet" type="text/css" href="resources/css/topBottom.css" />
<body>
	<div id="basic">
			<div id="top">
				<div id="logo"/></div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" onMouseOver="changeColor1(this)" onMouseOut="changeColor2(this)"/></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" onClick="getNewPage('memberLogIn')" >로그인/</span><span class="top_menu" onClick="getNewPage('signUp')">회원가입</span></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
				<img id="list" src='resources/images/list.png'/>
			</div>
			
			<div id="Mid">
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
			
			<div id="bottom">
        	    <div id="store_info"><span class="end">여기가 좋을 지도¿ CS NUMBER : 1644 - 3681</span></div>
        	    <div id="nate2"><span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</span></div>
         	   <div id="nate3"><span class="nate">문의 : handaeng1220@gmail.com</span></div>
         	</div>
     </div>
</body>
</html>