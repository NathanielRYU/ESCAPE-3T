<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Id/Password찾기</title>
</head>
<link rel="stylesheet" type="text/css" href="resources/css/findIdPassword.css" />
<script src="resources/js/resource.js"></script>
<script src="resources/js/signUp.js"></script>
<body>
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
					<span class="login2">아이디/패스워드 찾기 (FIND ID/PASSWORD)</span>
				</div>
				
				<div id="home">
					<span class="home" onClick="getNewPage('basic')">홈</span>
				</div>
				<div id="arrow">
					<span class="home">></span>
				</div>
				<div id="login2-1">
					<span class="login2-1">아이디/패스워드 찾기</span>
				</div>
				<div id="line2"></div>
				
				<div id="login_type">
					<div id="search1">
						<div id="searchMember">
							<span onClick="getNewPage('findMemberInfo')">사용자</span>
						</div>
					
						<div id="searchStore">
							<span onClick="getNewPage('findStoreInfo')">업체</span>
						</div>
					</div>
					
					<div id="memberlogin_btn">
						<div class="login_type1" onClick="getNewPage('findStoreId')">
							<span>아이디 찾기<br></span>
							<div class="triangle"></div>
							
						</div>
					</div>
					<div id="storelogin_btn">
						<div class="login_type2" onClick="getNewPage('findStorePassword')">
							<span>비밀번호 찾기<br></span>
							<div class="triangle"></div>
							
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
	</form>
</body>
</html>