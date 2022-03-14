<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<script src="resources/js/resource.js"></script>
<script src="resources/js/signUp.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/topBottom.css" />
<style type="text/css">
 div.container{
    }
 
      div.insert{
    }
 
    div.create{
    width: 800px;
    text-align: center;
    padding: 30px;
    border-bottom: 1px solid black;
    margin: auto;
    }
 
    table{
    height: 300px;
    width:80%;
    border-top: 3px solid black;
    margin-right: auto;
    margin-left: auto;
    }
 
    td{
    border-bottom: 1px dotted black;
    }
 
    caption{
    text-align: left;
    }
 
    .col1 {
    background-color: #292929;
    padding: 10px;
    text-align: right;
    font-weight: bold;
    font-size: 0.8em;
    color: #FFCD36;
    }
 
    .col2 {
    text-align: left;
    padding: 5px;
    }
 
    .but1 {
    height: 25px;
    width: 80px;
    color: white;
    background-color: #292929;
    border-color: #292929;
    }
 
    .but2 {
    height: 27px;
    width: 120px;
    color: white;
    background-color: #292929;
    border-color: #292929;
    }
 
    .but3 {
    height: 35px;
    width: 150px;
    background-color: white;
    border: 2px solid #292929;
    }
 
    .but4{
    height: 35px;
    width: 150px;
    background-color: white;
    border: 2px solid #292929;
    }
    
    .but1:hover {
    background-color: #292929;
    color: #FFCD36;
    border: 2px solid #292929;
    }
 
    .but2:hover {
    background-color: #292929;
    color: #FFCD36;
    border: 2px solid #292929;
    }
 
    .but3:hover {
    background-color: #292929;
    color: #FFCD36;
    border: 2px solid #292929;
    }
 
    .but4:hover {
    background-color: #292929;
    color: #FFCD36;
    border: 2px solid #292929;
    }
    
    p{
    font-size: 0.7em;
    }
 
    .g{
    font-size: 0.7em;
    }
 
    .c{
    font-size: 0.7em;
    }
 
    .a{
    font-size: 0.7em;
    }
    
    .num{
    color: red;
    }
    
    #checkIdMessage{
	font-size : 5pt;
	color : red;
	}	
</style>


<body>
	
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

			 
      <div class="container">
    <div class="insert">
    
        <table>
    <caption><h2>회원가입 (Join Membership)</h2></caption>
    
    <tr>
    	
        <td class="col1">아이디</td>
        <td class="col2">
            <input type="text" name="srId" id="srId" maxlength="15">
            <input class='but1' type="button" value="중복확인" onclick="checkStoreId()">
            <span id="checkIdMessage">${msg}</span>
        </td>
    </tr>
    <tr>
        <td class="col1">비밀번호</td>
        <td class="col2">
            <input type="password" id="pwd" name="pwd" maxlength="16">
            <p>※비밀번호는<span class="num">문자, 숫자의 조합
            10 ~ 16자리</span>로 입력이 가능합니다.</p>
        </td>
    </tr>
    <tr>
        <td class="col1">비밀번호 확인</td>
        <td class="col2">
        	<input type="password" id="pwdCheck"name="pwdCheck" maxlength="16" onchange="comparePassword()">
        	<span id="checkResult" style="font-size: 7pt;" ></span>  				
        </td>
 		 
    </tr>
    <tr>
        <td class="col1">이름</td>
        <td class="col2"><input type="text" id="srName" name="srName" maxlength="5"></td>
    </tr>
    <tr>
        <td class="col1">분류</td>
        <td class="col2">
            <select name="srCfCode">
                <option value="2000" selected>낚시</option>
                <option value="1000">캠핑</option>
                </select>
        </td>
    </tr>
    <tr>
        <td class="col1">업체 주소</td>
        <td class="col2">
            <input id="srPost" name="srPost"  type="text" placeholder="우편번호" readonly><input class='but1' type="button" value="주소찾기" onclick="findAddr()"><br>
  			<input id="srAddress" name="srAddress" style="width:20%" type="text" placeholder="주소" readonly>
        </td>
    </tr>
    <tr>
        <td class="col1">업체 상세 설명</td>
        <td class="col2"><textarea rows="8" cols="100" name="srDetails" id="srDetails" maxlength="400"></textarea><br>
        		
    		
        </td>
    </tr>
    <tr>
        <td class="col1">전화번호</td>
        <td class="col2"><input type="text" id="srNumber" name="srNumber" maxlength="11"></td>
    </tr>
    <tr>
        <td class="col1">이메일</td>
        <td class="col2">
            <input type="text" id="srEmail" name="srEmail">
        </td>
    </tr>
    </table>
    
  </div>
 
  <div class="create">
        <input class="but3" type="button" value="가입취소" onclick="getNewPage('signUp')">
        <input class="but4" type="button" value="회원가입" onclick="storeSignUp()">
  </div>
  </div>

		<div id="bottom">
				<div id="store_info"><span class="end">여기가 좋을 지도¿ CS NUMBER : 1644 - 3681</span></div>
				<div id="nate2"><span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</span></div>
				<div id="nate3"><span class="nate">문의 : handaeng1220@gmail.com</span></div>
			</div>
		</div>
</body>
<script>
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('srPost').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("srAddress").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("srAddress2").value = jibunAddr;
            }
        }
    }).open();
}


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>