<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 로그인 후 마이페이지</title>
</head>
<script src="resources/js/resource.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/topBottom.css" />
<link rel="stylesheet" type="text/css" href="resources/css/medium.css" />
<style>
#logOutButton{
width :30%
}
</style>
<body onLoad="init('${objName}'),initPage('${msg}')">
	
		<div id="basic">
			<div id="top">
				<div id="logo"/></div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" /></div>
				
				<div id="box1">
		 			<div id="login1"><span class="top_menu" >${userInfo.mmId}님 안녕하세요</span></div>
		 			<div id="logOutButton"><input type = "button" value= "로그아웃" onClick="logOutMember('${userInfo.mmId}','${sessionInfo.publicIp}','${userInfo.mmCode}')"/></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
				<img id="list" src='resources/images/list.png'/>
			</div>
		
			<div id="mid">
				<div id="line1"></div>
				<div id="box2">
					<div id="fishing"><span onClick="">낚시장소</span></div>
					<div id="fishingtip"><span onClick="">노하우TIP</span></div>
					<div id="camping"><span onClick="">캠핑장소</span></div>
					<div id="camping_rental"><span onClick="">캠핑대여</span></div>
					<div id="fishing_rental"><span onClick="">낚시대여</span></div>
					<div id="fishing_community"><span onClick="">대어자랑</span></div>
					<div id="rental"><span onClick="">대여업체</span></div>
					<div id="camping_community"><span onClick="">캠핑커뮤</span></div>
				</div>
				<div id="line2"></div>
				<div id="pop">
					<div id="pop_notice">공지사항</div>
					<div id="pop_community">커뮤니티</div>
				</div>
				<div id="rank"><span>주간랭킹TOP5</span></div>
				<div id="rank_list">
					<div ></div>
					<div></div>
					<div></div>
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