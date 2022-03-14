<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면틀</title>
</head>
<script src="resources/js/resource.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/topBottom.css" />
<link rel="stylesheet" type="text/css" href="resources/css/medium.css" />

<body onLoad = "getPublic(),initPage'${msg}">
	
		
		<div id="basic">
			<div id="top">
				<div id="logo"/></div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" onMouseOver="changeColor1(this)" onMouseOut="changeColor2(this)"/></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" onClick="getNewPage('memberLogIn')" >로그인/</span><span class="top_menu" onClick="getNewPage('signUp')">회원가입</span></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
				<img id="list" onClick="openModal(this)" src='resources/images/list.png'/>
			</div>
		   
			<div id="mid">
				<div id="line1"></div>
				<div id="box2">
					<div id="fishing"><span onClick=""><img id="fishing1" src='resources/images/map.png' onMouseOver="this.src='resources/images/fishingPoint1.png'" onmouseout="this.src='resources/images/map.png'"/></span></div>
					<div id="fishingtip"><span onClick=""><img id="fishingtip1" src='resources/images/fishing.png' onMouseOver="this.src='resources/images/fishingKnowHowTip.png'" onmouseout="this.src='resources/images/fishing.png'"/></span></div>
					<div id="camping" ><span onClick="getNewPage('mapPoints')" ><img id="camping1" src='resources/images/tent.png' onMouseOver="this.src='resources/images/camping1.png'" onmouseout="this.src='resources/images/tent.png'"/></span></div>
					<div id="camping_rental"><span onClick=""><img id="camping_rental1" src='resources/images/sleeping-bag.png' onMouseOver="this.src='resources/images/campingEquipment1.png'" onmouseout="this.src='resources/images/sleeping-bag.png'"/></span></div>
					<div id="fishing_rental"><span onClick=""><img id="fishing_rental1" src='resources/images/fishing-baits.png' onMouseOver="this.src='resources/images/fishingEquipment1.png'" onmouseout="this.src='resources/images/fishing-baits.png'"/></span></div>
					<div id="fishing_community"><span onClick=""><img id="fishing_community1" src='resources/images/big-fish.png' onMouseOver="this.src='resources/images/bigFishing1.png'" onmouseout="this.src='resources/images/big-fish.png'"/></span></div>
					<div id="rental"><span onClick=""><img id="rental1" src='resources/images/location.png' onMouseOver="this.src='resources/images/rentalPlace1.png'" onmouseout="this.src='resources/images/location.png'"/></span></div>
					<div id="camping_community"><span onClick=""><img id="camping_community1" src='resources/images/fire.png' onMouseOver="this.src='resources/images/campingKnowHowTip1.png'" onmouseout="this.src='resources/images/fire.png'"/></span></div>
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
			
			<div id="bottom1">
				<div id="store_name"><span class="end">여기가 좋을 지도¿</span></div>
				<div id="cs_number">
					<div id="cs"><span class="end">CS NUMBER</span></div>
					<div id="number"><span class="end">1644 - 3681</span></div>
				</div>
				<div id="nate1"><span class="nate">21968 인천광역시 연수구 원인재로 81(동춘동, 삼성럭키아파트) ㈜CHILDNATE｜대표이사 : NATE</span></div>
				<div id="nate2"><span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</span></div>
				<div id="nate3"><span class="nate">문의 : handaeng1220@gmail.com</span></div>
				<div id="nate4"><span class="nate">㈜CHILDNATE의 사전 서면동의 없이 여기 좋을 지도 사이트(PC, 모바일, 앱)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</span></div>
			</div>
			
			<div class="container" id="container">
			<div id="fishingBox"></div>
			
			<div id="campingBox"></div>
			
			<div id="myPageBox"></div>
			
			<div id="csCenterBox"></div>
			</div>
		</div>
	
</body>
</html>