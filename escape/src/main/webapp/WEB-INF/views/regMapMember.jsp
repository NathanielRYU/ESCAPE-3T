<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<title>낚시 포인트</title>

</head>



<link rel="stylesheet" type="text/css" href="resources/css/regMapPoints.css" />
<script src="resources/js/resource.js"></script>
<script src="resources/js/regMapPoints.js"></script>
<body onLoad="addEvent(),init('${objName}')"/>

	<div id="basic">
		<div id="top">
			<div id="logo" onClick="getNewPage('basic')">여기가 좋을 지도¿</div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" class="divButton" type="button" value="SEARCH" onMouseOver="changeColor1(this)" onMouseOut="changeColor2(this)"/></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" >${sessionInfo.mmId}님</span>
		 			<input id="logOutButton" type = "button" value= "로그아웃" onClick="logOutMember('${sessionInfo.mmId}','${sessionInfo.publicIp}','${sessionInfo.mmCode}')"/></div>
		 			
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
			<img id="list" src='resources/images/list.png'/>
		</div>
		
		<div id="mid">
     		<div id="regForm">
     			<div id="regFormBack">>> 낚시 포인트 등록
     				<div id="selectType">
     					<input type="text" id="title" placeholder="게시물 제목 입력" size="20" maxlength="42"/>
     				</div>
     				
     				<div id="selectType2" >
     					<select id="bigType" class="typeClass"name="bigType" size="1" disabled>
							<option value="">대분류</option>
							<option value="1000">캠핑</option>
							<option value="2000" selected>낚시</option>
						</select>
					
						<select id="smallType" class="typeClass"name="smallType" size="1" disabled>
							<option value="">중분류</option>
							<option value="C004" selected>포인트</option>
							<option value="C005">대어자랑</option>
						</select>
					</div>
     			</div>
     			<div id="filterForm">
     				<div id="filterCategory">
     					<h2 class ="filterName">CATEGORY</h2>
     					<button type="button" class="select_btn_themespan"  value="T005" onClick="changeFilter('1')">#민물</button>
     					<button type="button" class="select_btn_themespan"  value="T006" onClick="changeFilter('2')">#바다워킹</button>
     					<button type="button" class="select_btn_themespan"  value="T007" onClick="changeFilter('3')">#바다선상</button>
     				</div>
     				
     				
     				<div id="filterGenre1">
     					<h2 class ="filterName" >GENRE</h2>
     					<button type="button" class="select_btn_genrespan" value="G001">라인|매듭|공통</button>
     					<button type="button" class="select_btn_genrespan" value="G002">배스루어</button>
     					<button type="button" class="select_btn_genrespan" value="G003">쏘가리루어</button>
     					<button type="button" class="select_btn_genrespan" value="G004">가물치루어</button>
     					<button type="button" class="select_btn_genrespan" value="G005">붕어찌낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G006">송어루어</button>
     					<button type="button" class="select_btn_genrespan" value="G007">플라이낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G008">빙어낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G009">원투낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G010">기타</button>
     				</div>
     				
     				<div id="filterGenre2" style="display:none;">
     				<h2 class ="filterName" >GENRE</h2>
     					<button type="button" class="select_btn_genrespan" value="G001">라인|매듭|공통</button>
						<button type="button" class="select_btn_genrespan" value="G010">기타</button>
     					<button type="button" class="select_btn_genrespan" value="G011">광어루어</button>
     					<button type="button" class="select_btn_genrespan" value="G012">쇼어루어</button>
     					<button type="button" class="select_btn_genrespan" value="G013">쇼어생미끼</button>
     					<button type="button" class="select_btn_genrespan" value="G014">쇼어지깅</button>
     					<button type="button" class="select_btn_genrespan" value="G015">삼치루어</button>
     					<button type="button" class="select_btn_genrespan" value="G016">원투낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G017">농어루어</button>
     					<button type="button" class="select_btn_genrespan" value="G018">볼락루어</button>
     					<button type="button" class="select_btn_genrespan" value="G019">전갱이루어</button>
     					<button type="button" class="select_btn_genrespan" value="G020">플랫피싱</button>
     					<button type="button" class="select_btn_genrespan" value="G021">바다찌낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G022">호래기낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G023">쭈꾸미루어</button>
     					<button type="button" class="select_btn_genrespan" value="G024">에깅낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G025">해루질</button>
     					<button type="button" class="select_btn_genrespan" value="G026">빅게임</button>
     				</div>
     					
     				<div id="filterGenre3"  style="display:none;">
						<h2 class ="filterName">GENRE</h2>
     					<button type="button" class="select_btn_genrespan" value="G001">라인|매듭|공통</button>
     					<button type="button" class="select_btn_genrespan" value="G010">기타</button>
     					<button type="button" class="select_btn_genrespan" value="G026">빅게임</button>
     					<button type="button" class="select_btn_genrespan" value="G027">우럭침선</button>
     					<button type="button" class="select_btn_genrespan" value="G028">광어다운샷</button>
     					<button type="button" class="select_btn_genrespan" value="G029">참돔타이라바</button>
     					<button type="button" class="select_btn_genrespan" value="G030">갈치낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G031">외수질</button>
     					<button type="button" class="select_btn_genrespan" value="G032">농어루어</button>
     					<button type="button" class="select_btn_genrespan" value="G033">대구지깅</button>
     					<button type="button" class="select_btn_genrespan" value="G034">열기선상</button>
     					<button type="button" class="select_btn_genrespan" value="G035">쭈꾸미·갑오징어 에깅</button>
     					<button type="button" class="select_btn_genrespan" value="G036">백조기선상</button>
     					<button type="button" class="select_btn_genrespan" value="G037">감성돔카고</button>
     					<button type="button" class="select_btn_genrespan" value="G038">감성돔찌낚시</button>
     					<button type="button" class="select_btn_genrespan" value="G039">한치에깅</button>
     					<button type="button" class="select_btn_genrespan" value="G040">팁런에깅</button>
     					<button type="button" class="select_btn_genrespan" value="G041">방어지깅</button>
     					<button type="button" class="select_btn_genrespan" value="G042">부시리지깅</button>
     					<button type="button" class="select_btn_genrespan" value="G043">삼치루어</button>
     					<button type="button" class="select_btn_genrespan" value="G044">문어선상</button>
     					<button type="button" class="select_btn_genrespan" value="G045">도다리배낚시</button>
     				</div>	
     				<div id="filterFish1">
						<h2 class ="filterName" >FISHTYPE</h2>
     					<button type="button" class="select_btn_fishspan" value="F001">라인│매듭│공통</button>
     					<button type="button" class="select_btn_fishspan" value="F002">배스</button>
     					<button type="button" class="select_btn_fishspan" value="F003">쏘가리</button>
     					<button type="button" class="select_btn_fishspan" value="F004">붕어</button>
     					<button type="button" class="select_btn_fishspan" value="F005">잉어</button>
     					<button type="button" class="select_btn_fishspan" value="F006">가물치</button>
     					<button type="button" class="select_btn_fishspan" value="F007">강준치</button>
     					<button type="button" class="select_btn_fishspan" value="F008">메기</button>
     					<button type="button" class="select_btn_fishspan" value="F009">민물장어</button>
     					<button type="button" class="select_btn_fishspan" value="F010">송어</button>
     					<button type="button" class="select_btn_fishspan" value="F011">빙어</button>
     					<button type="button" class="select_btn_fishspan" value="F012">끄리</button>
     					<button type="button" class="select_btn_fishspan" value="F013">꺽지</button>
     					<button type="button" class="select_btn_fishspan" value="F014">누치</button>
     					<button type="button" class="select_btn_fishspan" value="F015">기타</button>
     				</div>
     				
     				<div id="filterFish2" style="display:none;">
						<h2 class ="filterName">FISHTYPE</h2>
     					<button type="button" class="select_btn_fishspan" value="F001">라인│매듭│공통</button>
     					<button type="button" class="select_btn_fishspan" value="F016">우럭</button>
     					<button type="button" class="select_btn_fishspan" value="F017">광어</button>
     					<button type="button" class="select_btn_fishspan" value="F018">놀래미</button>
     					<button type="button" class="select_btn_fishspan" value="F019">삼치</button>
     					<button type="button" class="select_btn_fishspan" value="F020">농어</button>
     					<button type="button" class="select_btn_fishspan" value="F021">전갱이</button>
     					<button type="button" class="select_btn_fishspan" value="F022">고등어</button>
     					<button type="button" class="select_btn_fishspan" value="F023">볼락</button>
     					<button type="button" class="select_btn_fishspan" value="F024">숭어</button>
     					<button type="button" class="select_btn_fishspan" value="F025">황열기</button>
     					<button type="button" class="select_btn_fishspan" value="F026">열기</button>
     					<button type="button" class="select_btn_fishspan" value="F027">쏨뱅이</button>
     					<button type="button" class="select_btn_fishspan" value="F028">장대</button>
     					<button type="button" class="select_btn_fishspan" value="F029">성대</button>
     					<button type="button" class="select_btn_fishspan" value="F030">전어</button>
     					<button type="button" class="select_btn_fishspan" value="F031">꼬치고기</button>
     					<button type="button" class="select_btn_fishspan" value="F032">감성돔</button>
     					<button type="button" class="select_btn_fishspan" value="F033">뱅에돔</button>
     					<button type="button" class="select_btn_fishspan" value="F034">긴꼬리뱅에돔</button>
     					<button type="button" class="select_btn_fishspan" value="F035">돌돔</button>
     					<button type="button" class="select_btn_fishspan" value="F036">갈치</button>
     					<button type="button" class="select_btn_fishspan" value="F037">참돔</button>
     					<button type="button" class="select_btn_fishspan" value="F038">방어</button>
     					<button type="button" class="select_btn_fishspan" value="F039">부시리</button>
     					<button type="button" class="select_btn_fishspan" value="F040">가자미</button>
     					<button type="button" class="select_btn_fishspan" value="F041">도다리</button>
     					<button type="button" class="select_btn_fishspan" value="F042">자바리</button>
     					<button type="button" class="select_btn_fishspan" value="F043">대구</button>
     					<button type="button" class="select_btn_fishspan" value="F044">민어</button>
     					<button type="button" class="select_btn_fishspan" value="F045">능성어</button>
     					<button type="button" class="select_btn_fishspan" value="F046">다금바리</button>
     					<button type="button" class="select_btn_fishspan" value="F047">백조기</button>
     					<button type="button" class="select_btn_fishspan" value="F048">문어</button>
     					<button type="button" class="select_btn_fishspan" value="F049">무늬오징어</button>
     					<button type="button" class="select_btn_fishspan" value="F050">갑오징어</button>
     					<button type="button" class="select_btn_fishspan" value="F051">쭈꾸미</button>
     					<button type="button" class="select_btn_fishspan" value="F052">한치</button>
     					<button type="button" class="select_btn_fishspan" value="F053">바다장어</button>
     					<button type="button" class="select_btn_fishspan" value="F054">호래기</button>
					<button type="button" class="select_btn_fishspan" value="F015">기타</button>
     				</div>
     				
     				<div id="filterFish3" style="display:none;" >
     					<h2 class ="filterName">FISHTYPE</h2>
     					<button type="button" class="select_btn_fishspan" value="F001">라인│매듭│공통</button>
     					<button type="button" class="select_btn_fishspan" value="F015">기타</button>
     					<button type="button" class="select_btn_fishspan" value="F016">우럭</button>
     					<button type="button" class="select_btn_fishspan" value="F017">광어</button>
     					<button type="button" class="select_btn_fishspan" value="F018">놀래미</button>
     					<button type="button" class="select_btn_fishspan" value="F019">삼치</button>
     					<button type="button" class="select_btn_fishspan" value="F020">농어</button>
     					<button type="button" class="select_btn_fishspan" value="F021">전갱이</button>
     					<button type="button" class="select_btn_fishspan" value="F022">고등어</button>
     					<button type="button" class="select_btn_fishspan" value="F023">볼락</button>
     					<button type="button" class="select_btn_fishspan" value="F025">황열기</button>
     					<button type="button" class="select_btn_fishspan" value="F026">열기</button>
     					<button type="button" class="select_btn_fishspan" value="F027">쏨뱅이</button>
     					<button type="button" class="select_btn_fishspan" value="F028">장대</button>
     					<button type="button" class="select_btn_fishspan" value="F029">성대</button>
     					<button type="button" class="select_btn_fishspan" value="F030">전어</button>
     					<button type="button" class="select_btn_fishspan" value="F032">감성돔</button>
     					<button type="button" class="select_btn_fishspan" value="F033">뱅에돔</button>
     					<button type="button" class="select_btn_fishspan" value="F034">긴꼬리뱅에돔</button>
     					<button type="button" class="select_btn_fishspan" value="F035">돌돔</button>
     					<button type="button" class="select_btn_fishspan" value="F036">갈치</button>
     					<button type="button" class="select_btn_fishspan" value="F037">참돔</button>
     					<button type="button" class="select_btn_fishspan" value="F038">방어</button>
     					<button type="button" class="select_btn_fishspan" value="F039">부시리</button>
     					<button type="button" class="select_btn_fishspan" value="F040">가자미</button>
     					<button type="button" class="select_btn_fishspan" value="F041">도다리</button>
     					<button type="button" class="select_btn_fishspan" value="F042">자바리</button>
     					<button type="button" class="select_btn_fishspan" value="F043">대구</button>
     					<button type="button" class="select_btn_fishspan" value="F044">민어</button>
     					<button type="button" class="select_btn_fishspan" value="F045">능성어</button>
     					<button type="button" class="select_btn_fishspan" value="F046">다금바리</button>
     					<button type="button" class="select_btn_fishspan" value="F047">백조기</button>
     					<button type="button" class="select_btn_fishspan" value="F048">문어</button>
     					<button type="button" class="select_btn_fishspan" value="F049">무늬오징어</button>
     					<button type="button" class="select_btn_fishspan" value="F050">갑오징어</button>
     					<button type="button" class="select_btn_fishspan" value="F051">쭈꾸미</button>
     					<button type="button" class="select_btn_fishspan" value="F052">한치</button>
     					<button type="button" class="select_btn_fishspan" value="F053">바다장어</button>
     					<button type="button" class="select_btn_fishspan" value="F055">붉벤자리</button>
     					
     				</div>
     			</div>	
     					
     					
     				
     			
     			<div id="mapDiv">
     				<h3 id="detail">지도에 정확한 위치를 입력해주세요</h3>
     				<div id="setPost"><input id="maPost" type="text" placeholder="우편번호" readOnly/></div>
     				<div id="setAddress"><input id="maAddress"type="text" placeholder="지번주소" readOnly/></div>
     				<div id="maPoints"></div>
     			</div>
     			
     			<div id="contents">
     				<input type="file" id="putImage" value="사진 첨부" onClick=""/>
     				<div id="contents2"><textarea class="postContents"name="postContents" maxlength="1000" placeholder="내용을 입력해주세요"></textarea></div>
     			</div>
     			
     			<div id="buttonDiv">
     				<button type="button" id="regFp" onClick="insFishing()" >등록</button>
     				<button type="button" id="cancel" onClick="getNewPageMember('${sessionInfo.mmId}','mapPoints')">취소</button>
     			</div>
     		</div>
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


var mapContainer = document.getElementById('maPoints'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    level: 1 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
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

//찾은 우편번호와 주소 입력할 칸
const postCode = document.getElementById('maPost');
const address = document.getElementById('maAddress');
// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                address.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}


</script>

</body>

</html>