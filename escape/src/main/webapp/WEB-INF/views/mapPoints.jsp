<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<title>낚시 포인트</title>

</head>

<style>
#place-content:after {
	top: 98.5%;
	transform: translate(-1px, 3px);
	left: 251px;
	border: solid transparent;
	content: " ";
	height: 0;
	width: 0;
	position: absolute;
	pointer-events: none;
	border-color: rgba(56, 77, 157, 0);
	border-top-color: white;
	border-width: 25px;
	margin-left: -48px;
}
</style>

<link rel="stylesheet" type="text/css" href="resources/css/mapPoints.css" />
<script src="resources/js/resource.js"></script>
<body onLoad="getCampingList('C001', '1000'),getCampingPage('1','10','C001', '1000'),chooseCampingList('1','10','C001','1000'),init('${objName}')"/>

	<div id="basic">
		<div id="top">
			<div id="logo" onClick="getNewPage('basic')">여기가 좋을 지도¿</div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" onMouseOver="changeColor1(this)" onMouseOut="changeColor2(this)"/></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" onClick="getNewPage('memberLogIn')" >로그인/</span><span class="top_menu" onClick="getNewPage('commonSignUp')">회원가입</span></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
			<img id="list" src='resources/images/list.png'/>
		</div>
		
		<div id="mid">
			<div id="leftList">
				<div id="listFilter"><input id="insert" type="button" value="등록" onClick=""/>
					<label for="job"></label> 
		<select id="job" name="job" size="1">
			<option value="">전체</option>
			<option value="조회순">조회순</option>
			<option value="조아요순">좋아요순</option>
			<option value="조아요순">찜순</option>
		</select>
					</div>
					
					<div id="listPoints">
						<div id="mySideStore" onClick="delrecord();getCampingList('C003', '1000');getCampingPage('1','10','C003', '1000');chooseCampingList('1','10','C003','1000');">카라반</div>
						<div id="fishingPoint" onClick="delrecord();getCampingList('C002', '1000');getCampingPage('1','10','C002', '1000');chooseCampingList('1','10','C002','1000');">클램핑</div>
						<div id="camping" onClick="delrecord();getCampingList('C001', '1000');getCampingPage('1','10','C001', '1000');chooseCampingList('1','10','C001','1000');">캠핑</div>
						<div id="glamping" onClick="">낚시 포인트</div>
						<div id="caravan" onClick="">내 주변 업체</div>
					</div>
					
					<div id="listButton">
						<ul id="campingPage">
                		</ul>
					</div>
				<div id="campingList" class="container">	
				</div>
			</div>
			<div id="rightview" class="shadow">
			</div>
			
   	 	<div id="map"></div>
    		
     
		</div>
				
				
				
		
		
		
		<div id="bottom">
         <div id="bottom_store">여기가 좋을 지도¿</div>
         <div id="bottom_store2">CS NUMBER : 1644 - 3681｜사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</div>
         <div id="bottom_store3">문의 : handaeng1220@gmail.com</div>
      </div>
		
	</div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=83c735083178ecf82197f105cee12951&libraries=services"></script>
<script>
	function getAjaxJson(action, data, fn) {
	const ajax = new XMLHttpRequest();
	
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 4 && ajax.status == 200) {
			if(ajax.responseText !=""){
				if(ajax.responseText.indexOf(":")>0){
					window[fn](JSON.parse(ajax.responseText));
				}else{
					window[fn](ajax.responseText);
				}
			}
		}
	};
	ajax.open("post", action, true);
	ajax.setRequestHeader("Content-type","application/json;charset=utf-8");
	ajax.send(data);
}
	//캠핑장리스트 가져오기
	function getCampingList(pCpCaCode, pCpMaCfCode) {
		let jsonData = [];
		jsonData.push({
			cpCaCode : pCpCaCode,
			cpMaCfCode : pCpMaCfCode
		});
		const clientData = JSON.stringify(jsonData);
		getAjaxJson("GetCampingList", clientData, "setPoint");

	}
	//캠핑 : 클릭한 페이지에 해당하는 리스트 불러오기
	function chooseCampingList(pPageNumber, pAmount, pCpCaCode, pCpMaCfCode) {
		let jsonData = [];
		jsonData.push({
			pageNumber : pPageNumber,
			amount : pAmount,
			cpCaCode : pCpCaCode,
			cpMaCfCode : pCpMaCfCode
		});
		const clientData = JSON.stringify(jsonData);
		getAjaxJson("ChooseCampingList", clientData, "getPoint");
	}
	//캠핑 페이지 번호 불러오기
	function getCampingPage(pPageNumber, pAmount, pCpCaCode, pCpMaCfCode) {
		let jsonData = [];
		jsonData.push({
			pageNumber : pPageNumber,
			amount : pAmount,
			cpCaCode : pCpCaCode,
			cpMaCfCode : pCpMaCfCode
		});
		const clientData = JSON.stringify(jsonData);
		getAjaxJson("GetCampingPage", clientData, "alertPage");
	}

	var mapContainer = document.getElementById('map'), // 지도의 중심좌표
	mapOption = {
		center : new kakao.maps.LatLng(37.57437853540586, 126.9767793075412), // 지도의 중심좌표
		level : 9
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var markers = [];

	function setPoint(list) {
		for (let n = 0; n < list.length; n++) {
			geocoder.addressSearch(list[n].maAddress,
					function(result, status) {
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {
								
							// 마커 하나를 지도위에 표시합니다 
							addMarker(new kakao.maps.LatLng(result[0].y,
									result[0].x), list[n].cpName,
									list[n].maAddress, list[n].cpNumber, list[n].cpImage, new kakao.maps.LatLng(parseFloat(result[0].y)+0.11, parseFloat(result[0].x)+0.23));
						}
					});
		}

	}

	var clickedoverlay = null;

	function addMarker(position, name, address, phone, img, wishPos) {
		var imageSrc = 'resources/images/camping.png', // 마커이미지의 주소입니다    
		imageSize = new kakao.maps.Size(28, 28) // 마커이미지의 크기입니다

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize), markerPosition = position

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map : map,
			position : position,
			image : markerImage

		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 생성된 마커를 배열에 추가합니다
		markers.push(marker);

		var overlay = new kakao.maps.CustomOverlay({
			yAnchor : 1.2,
			position : position
		});

		makeOverlay(name, img, phone, address, overlay);

		kakao.maps.event.addListener(marker, 'click', function() {
			if (clickedoverlay) {
				clickedoverlay.setMap(null);
			}
			overlay.setMap(map);
			clickedoverlay = overlay;
			map.setCenter(wishPos);
		});

	}

	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	if (navigator.geolocation) {

		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		navigator.geolocation.getCurrentPosition(function(position) {

			var lat = position.coords.latitude, // 위도
			lon = position.coords.longitude; // 경도

			var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
			message = '<div style="padding:5px;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다

			// 마커와 인포윈도우를 표시합니다
			displayMarker1(locPosition, message);

		});

	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

		var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

		displayMarker1(locPosition, message);
	}

	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker1(locPosition, message) {

		// 마커를 생성합니다
		var marker1 = new kakao.maps.Marker({
			map : map,
			position : locPosition
		});
		map.setCenter(locPosition);
	}

	

	function alertPage(jsonData){
		
		let page = document.getElementById("campingPage");
		let pageInfo = "";
		let startPage = jsonData.startPage-1;
		let endPage = jsonData.endPage + 1;
		if(jsonData.prev != false){
		
		 pageInfo = "<div class='pageInfo_btn_prev'><li onClick =\"delrecord();getCampingPage('"+startPage+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');chooseCampingList('"+startPage+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');\" >이전</li></div>";
		
		}else{
		pageInfo = "<div id='pageInfo_btn_prev_hold'><li>이전</li></div>"
		}
		
		for(i=jsonData.startPage; i<jsonData.endPage+1; i++){
			if(i==jsonData.pageNumber){
			pageInfo += "<div class='pageInfo_btn_selected' style='width:4%;' ><li onClick =\"delrecord();getCampingPage('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');chooseCampingList('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');\">"+i+"</li></div>";	
			}else if(i!==jsonData.pageNumber){
			pageInfo += "<div class='pageInfo_btn' style='width:4%;'><li onClick =\"delrecord();getCampingPage('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');chooseCampingList('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');\">"+i+"</li></div>";
			}
			
		}
		if(jsonData.next != false){
			pageInfo += "<div class='pageInfo_btn_next'><li onClick =\"delrecord();getCampingPage('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');chooseCampingList('"+i+"','10','"+jsonData.cpCaCode+"','"+jsonData.cpMaCfCode+"');\" );'>다음</li></div>";
		}
		page.innerHTML = pageInfo;
		
	}
	/* 모든 record 삭제하기*/
	function delrecord(){
		const div = document.getElementById("campingList");
		while(div.hasChildNodes()){
			div.removeChild(div.firstChild);
	     }
	     
	      
	}
	const columnName = [ "cpImage", "cpName", "maAddress", "haName", "thName","cpNumber" ];
	   let column;
	   let n = 0;
	   let cpList;
	   
	function getPoint(list){
		for (let x = 0; x < list.length; x++) {
			geocoder.addressSearch(list[x].maAddress,
					function(result, status) {
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {
								
							// 마커 하나를 지도위에 표시합니다 
							getLeftCampingList(new kakao.maps.LatLng(result[0].y,
									result[0].x), list[x].cpImage, list[x].cpName,
									list[x].maAddress, list[x].haName, list[x].thName, list[x].cpNumber, new kakao.maps.LatLng(parseFloat(result[0].y)+0.11, parseFloat(result[0].x)+0.23));
						}
					});
		}
		
	}
	   
	function getLeftCampingList(mPos, cpI, cpN, maA, haN, thN, cpNb, wishPos) {
	    const div = document.getElementById("campingList");
		let cpList = createDiv("cpList", "cpList");
		for (let i = 0; i < 6; i++) {
	      	column = createDiv(columnName[i], "cpList " + columnName[i]);
	      	column.innerHTML = (i == 0) ? "<img id='image' src=resources/images/"+cpI+"/>"
	        	: (i == 1) ? cpN
	        		: (i == 2) ? maA
	        			: (i == 3) ? haN
	        				: (i == 4) ? "#"+thN
	        					: "☎"+cpNb;
	       	cpList.appendChild(column);
	            
	        var overlay2 = new kakao.maps.CustomOverlay({
	    		yAnchor : 1.2,
	    		position : mPos
	    	});
	        
	        makeOverlay(cpN, cpI, cpNb, maA, overlay2);
	        cpList.onclick = function() {
	    		if (clickedoverlay) {
	    			clickedoverlay.setMap(null);
	    		}
	    		overlay2.setMap(map);
	    		clickedoverlay = overlay2;
	    		map.setCenter(wishPos);
	    	};
	    }
		div.appendChild(cpList);
	   }

	function createDiv(name, className) {
		const div = document.createElement("div"); // <div></div>
		div.setAttribute("name", name); // <div name=""></div>
		div.setAttribute("class", className);
		return div;
	}
	
	function makeOverlay(name, img, phone, address, overlay){
		var placeContent = document.createElement("div")
		placeContent.className = "place-content"
		placeContent.id = "place-content"
		placeContent.style.cssText = 'background: white; width:100%; height:20%; box-shadow: 3px 3px 10px #566270; border-radius: 5px;';

		var placeHead = document.createElement("div")
		placeHead.className = "place-head"
		placeHead.style.cssText = 'height:20px; background: black; color:white; border: 1px solid black; border-radius: 5px 5px 0px 0px; padding : 10px 10px';

		var placeBody = document.createElement("div")
		placeBody.className = "place-body"
		placeBody.style.cssText = 'width:450px; height:180px; background: white; border: 1px solid white; border-radius: 0px 0px 5px 5px;';

		var placeInfo = document.createElement("div")
		placeInfo.className = "place-info"
		placeInfo.style.cssText = 'background: white; width:300px; height:110px; float:left; margin:10px 0px';

		var placeFooter = document.createElement("div")
		placeFooter.className = "place-footer"
		placeFooter.style.cssText = 'background: white; width:420px; height:30px; float:left; margin:5px 0px 0px 0px; padding:5px 15px'

		var placeName = document.createElement("div")
		placeName.innerHTML = name
		placeName.style.cssText = 'float:left;font-weight:bold;';

		var placeAddImg = document.createElement("img")
	      placeAddImg.style.cssText = 'width:110px; height:110px; background: red; float:left; margin:10px';
	      placeAddImg.src = "resources/images/"+img

		var placePhone = document.createElement("div")
		placePhone.className = "place-phone"
		placePhone.innerHTML = "☎ " + phone
		placePhone.style.cssText = 'color:blue; font-size:10pt;';

		var placeAddress = document.createElement("div")
		placeAddress.className = "place-address"
		placeAddress.innerHTML = address
		placeAddress.style.cssText = ' font-weight:bold;font-size:11pt';

		var placeZoom = document.createElement("div")
		placeZoom.innerHTML = "지도확대"
		placeZoom.className = "place-zoom"
		placeZoom.style.cssText = 'float:right; background: white; color:black; margin: 0px 5px; width:65px; height:24px; border: 1px solid black;font-size:12pt; padding:3px 15px'
		placeZoom.onclick = function() {
			//overlay.setMap(null);
		};
		
		var placeDetail = document.createElement("div")
		placeDetail.innerHTML = "상세정보 열기 >"
		placeDetail.className = "place-desc"
		placeDetail.id = "place1"
		placeDetail.style.cssText = 'float:right; background: white; color:black; width:120px; height:24px; border: 1px solid black; font-size:12pt; padding:3px 10px; display:block;'
		placeDetail.onclick = function openPanel() {
			const element = document.getElementById('rightview');
			element.style.right = '0%';
			const deplace = document.getElementById('deplace1');
			deplace.style.display = "block";
			const place = document.getElementById('place1');
			place.style.display = "none";
		}
		
		var deplaceDetail = document.createElement("div")
		deplaceDetail.innerHTML = "상세정보 닫기 <"
		deplaceDetail.className = "deplace-desc"
		deplaceDetail.id = "deplace1"
		deplaceDetail.style.cssText = 'float:right; background: white; color:black; width:120px; height:24px; border: 1px solid black; font-size:12pt; padding:3px 10px; display:none;'
		deplaceDetail.onclick = function closePanel() {
			const element = document.getElementById('rightview');
			element.style.right = '-33%';
			const place = document.getElementById('place1');
			place.style.display = "block";
			const deplace = document.getElementById('deplace1');
			deplace.style.display = "none";
		};
		
		/* placeUrl.href = place.kakao_url */

		var closeBtn = document.createElement('div');
		closeBtn.innerHTML = 'X';
		closeBtn.style.cssText = 'float:right; background: black; color:white;'
		closeBtn.onclick = function() {
			overlay.setMap(null);
		};

		placeContent.append(placeHead, placeBody)
		placeHead.append(placeName, closeBtn)
		placeBody.append(placeAddImg, placeInfo, placeFooter)
		placeInfo.append(placeAddress, placePhone)
		placeFooter.append(placeDetail,deplaceDetail, placeZoom)
		overlay.setContent(placeContent)
	}
</script>

</body>

</html>