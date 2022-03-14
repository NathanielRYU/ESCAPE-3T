<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<script src="resources/js/resource.js"></script>
<script src="resources/js/logIn.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/logInDisplay.css" />
<link rel="stylesheet" type="text/css" href="resources/css/topBottom.css" />
<script>

function mouseOver(obj){
   let styleName = (obj.id == "login_type")? "searchOver1" : "searchOver2";
   obj.className = styleName;
    obj.style.color = "#FFCD36";
   }
function mouseLeave(obj){
   let fColor = (obj.id == "login_type")? "#FFCD36" : "#000000";
   obj.className = "divButton";
   obj.style.color = fColor;
   }
   
</script>

<body onLoad = "getPublic()">
<form name="logInForm" action="LogInMember" method="post">
		<div id="basic">
			<div id="top">
				<div id="logo"/></div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" /></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" onClick="getNewPage('memberLogIn')" >로그인/</span><span class="top_menu"  onClick="getNewPage('signUp')">회원가입</span></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
				<img id="list" src='resources/images/list.png'/>
			</div>

			
			<div id="mid1">
				<div id="line1"></div>
				<div id="login2">
				<span class="login2">로그인 (LOGIN)</span>
				<span class="home" onClick="getNewPage('basic')">홈</span>
				<span class="home1">></span>
				<span class="login2-1">로그인</span>
				</div>
				
				<div id="line2"></div>
					<div id="login_type">
						<div id="memberlogin_btn"><div id="login_type1" class="divButton" onClick="getNewPage('memberLogIn')" >회원 로그인</div></div>
						<div id="storelogin_btn" ><div id="login_type2" class="divButton" onClick="getNewPage('storeLogIn')" >업체 로그인</div></div>
					</div>
					<div id="input">
						<div id="id"><input class="input_id" type="text" name="mmId" placeholder="ID" /></div>
						<div id="pw"><input class="input_pw" type="password" name="mmPassword" placeholder="PW" /></div>
						<div id="find" onClick=""><span id="id_pw_find"><a href="">아이디/비밀번호 찾기</a></span></div>		
						<div id="login3"onClick="logInStore()">로그인</div>
						<div id="join" onClick="getNewPage('signUp')">회원가입</div>
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