<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta charset="utf-8">
    <title>낚시 포인트</title>
   
</head>
<link rel="stylesheet" type="text/css" href="resources/css/mapPoints.css" />
<script src="resources/js/resource.js"></script>
<body>

	<div id="basic">
		<div id="top">
			<div id="logo"/></div>
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
					<label for="job">필터링</label> 
		<select id="job" name="job" size="1">
			<option value="">눌러봅시당</option>
			<option value="조회순">조회순</option>
			<option value="조아요순">조아요순</option>
		</select>
					</div>
					<div id="listPoints">
						<div id="mySideStore" onClick="">카라반</div>
						<div id="fishingPoint" onClick="">클램핑</div>
						<div id="camping" onClick="">캠핑</div>
						<div id="glamping" onClick="">낚시 포인트</div>
						<div id="caravan" onClick="">내 주변 업체</div>
					</div>
				<div id="campingList">
				</div>
			</div>
			
			
   	 	<div id="map"></div>
    		
     
		</div>
				
				
				
		
		
		
		<div id="bottom">
			<div id="store_info"><span class="end">여기가 좋을 지도¿ CS NUMBER : 1644 - 3681</span></div>
			<div id="nate2"><span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</span></div>
			<div id="nate3"><span class="nate">문의 : handaeng1220@gmail.com</span></div>
		</div>
		
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=83c735083178ecf82197f105cee12951&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   		mapOption = {
        center: new kakao.maps.LatLng(37.503743, 126.720769), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
   		};  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    	infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    		searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        		if (status === kakao.maps.services.Status.OK) {
            		var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
            		detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
            
           			 var content = '<div class="bAddr">' +
                  				   '<span class="title">법정동 주소정보</span>' + 
                            		detailAddr + 
        	                	   '</div>';

            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(mouseEvent.latLng);
            marker.setMap(map);

            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
        		}   
    		});
		});

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
    	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
    	// 좌표로 행정동 주소 정보를 요청합니다
 	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}

		function searchDetailAddrFromCoords(coords, callback) {
    	// 좌표로 법정동 상세 주소 정보를 요청합니다
    	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
    		if (status === kakao.maps.services.Status.OK) {
        		var infoDiv = document.getElementById('centerAddr');

        		for(var i = 0; i < result.length; i++) {
            	// 행정동의 region_type 값은 'H' 이므로
            		if (result[i].region_type === 'H') {
                	infoDiv.innerHTML = result[i].address_name;
                	break;
            		}
        		}
    		}    
		}
</script>

</body>

</html>