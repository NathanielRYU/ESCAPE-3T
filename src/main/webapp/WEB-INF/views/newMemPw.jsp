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
	position:absolute; 
	height:93%;
	width:97.8%;
	}
	
#top {
	font-family: 'Pretendard-Regular';
	height:7.7%;
	width:99.6%;
	background-color:#292929;
	}
	

#logo {
	margin: 1% 0% 2% 2%;
	width:12.5%;
	height:3%;
	position:absolute;
	}
#search {
	width:44.5%;
	height:2.3%;
	position:absolute; top:1.1%;
	left:26%;
	}
	
#searchFont{
	border:2px solid #FFCD36;
	font-size:20pt;
	padding: 1.2% 20% 0% 15%;
	margin-left:1%;
	}

#searchZoom{
	padding: 0% 1% 1% 1%;
	font-size:15pt;
	position:absolute; top:58%; left:62%; 
	border:0 solid black;
	background-color:white;
	color:#767F86;
	
	}
#searchZoom.divButton{
	cursor :pointer;
}	
#searchZoom.divButton:hover{
	cursor :pointer;
	font-weight: bold;
}	

#box1 {
	width:35.5%;
	height:3.4%;
	position:absolute; top:2.8%;
	left:57.5%;
	}
		
#login1 {
	width:28.3%;
	height:43%;
	margin-left:22%;
	float: left;
	color:#ebedec;
	font-size:10pt;
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
	font-family:TmonMonsori;
	font-size: 12pt;
	cursor : pointer;
	}

#list {
	width:4.4%;
	height:7.7%;
	position:absolute;
	left:93.5%;
	background-color:#a2a9af;
	cursor : pointer;
	}

#mid1 {
	font-family: 'Pretendard-Regular';
	width: 98.8%;
	height: 86.9%;
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
	right: 28%;
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
	right: 26%;
	top: 25%;
}

#login2-1 {
	width: 6%;
	height: 4%;
	position: absolute;
	right: 22%;
	top: 25%;
}

.login2-1 {
	font-family: TmonMonsori;
	font-size: 140%;
	color: #CBCBCB;
	cursor: pointer;
}

#arrow2 {
	width: 3%;
	height: 4%;
	position: absolute;
	right: 20%;
	top: 25%;
}

#find {
	width: 10%;
	height: 4%;
	position: absolute;
	right: 11.5%;
	top: 25%;
}

.find {
	font-family: TmonMonsori;
	font-size: 140%;
	color: #000000;
}

#line2 {
	border: 1px solid #292929;
	margin: 5% 10.5% 1% 10.5%;
	background-color: #1C1F88;
}

#mid1 {
	font-family: 'Pretendard-Regular';
	width: 98.8%;
	height: 86.9%;
}

#inputId {
	width: 10%;
	height: 2%;
	position: absolute;
	left: 26.25%;
	top: 37%;
	box-shadow: 3px 3px 10px #566270;
	background-color: #292929;
	color: #ebedec;
	padding: 1%;
	text-align:center;
	
}

#inputName {
	width: 10%;
	height: 2%;
	position: absolute;
	left: 26.25%;
	top: 44%;
	box-shadow: 3px 3px 10px #566270;
	background-color: #292929;
	color: #ebedec;
	padding: 1%;
	text-align:center;
}

#inputNewPw {
	width: 10%;
	height: 2%;
	position: absolute;
	left: 26.25%;
	top: 51%;
	box-shadow: 3px 3px 10px #566270;
	background-color: #292929;
	color: #ebedec;
	padding: 1%;
	text-align:center;
}

#inputCheckPw {
	width: 10%;
	height: 2%;
	position: absolute;
	left: 26.25%;
	top: 58%;
	box-shadow: 3px 3px 10px #566270;
	background-color: #292929;
	color: #ebedec;
	padding: 1%;
	text-align:center;
}

#typeId {
	width: 35%;
	height: 1.6%;
	position: absolute;
	left: 38.25%;
	top: 37%;
	box-shadow: 3px 3px 10px #566270;
	color: #292929;
	padding: 1%;
	text-align:left;
}

#typeName {
	width: 35%;
	height: 1.6%;
	position: absolute;
	left: 38.25%;
	top: 44%;
	box-shadow: 3px 3px 10px #566270;
	color: #292929;
	padding: 1%;
	text-align:left;
}

#typeNewPw {
	width: 35%;
	height: 1.5%;
	position: absolute;
	left: 38.25%;
	top: 51%;
	box-shadow: 3px 3px 10px #566270;
	color: #292929;
	padding: 1%;
	text-align:left;
}

#typeCheckPw {
	width: 35%;
	height: 1.5%;
	position: absolute;
	left: 38.25%;
	top: 58%;
	box-shadow: 3px 3px 10px #566270;
	color: #292929;
	padding: 1%;
	text-align:left;
}

#login_type {
	position: absolute;
	top: 41%;
	left: 6.2%;
	width: 80%;
	height: 60%;
	font-family: 'Pretendard-Regular';
	font-size: 110%;
	font-weight: bold;
}

#loginpage_btn {
	font-family: 'Pretendard-Regular';
	box-shadow: 3px 3px 10px #566270;
	width: 8%;
	height: 4%;
	text-align: center;
	background-color: #292929;
	position:absolute;
	bottom : 25%;
	left: 46.5%;
	color: #ebedec;
	cursor: pointer;  
	padding : 1% 0% 0% 0%;
}



#bottom {
	font-size:7pt;
	font-family: 'Pretendard-Regular';
	width:99.6%;
	height:5%;
	background-color:#595959;
	color:#FFFFFF;
	position:absolute; left:0.2%;
}
</style>
<style>
        #modal {
          display: none;
          position:relative;
          width:100%;
          height:100%;
          z-index:1;
        }
        
        #modal .modal_content {
          width:1000px;
          margin:10px auto;
          padding:80px 10px;
          background:#fff;
          border:2px solid #666;
        }   
</style> 
<body onLoad="init('${objName}')">
	<form name="logInForm" action="LogInMember" method="post">
		<div id="basic">
			<div id="top">
				<div id="logo"/></div>
				<div id="search"><input id="searchFont" type="text"  name="" placeholder="" /><input id="searchZoom" type="button" value="SEARCH"/></div>
				<div id="box1">
		 			<div id="login1"><span class="top_menu" onClick="getNewPage('memberLogIn')">로그인/</span><span
						class="top_menu" onClick="getNewPage('signUp')">회원가입</span></div>
		 			<div id="notice"><span class="top_menu" onClick="">공지사항</span></div>
		 			<div id="shop"><span class="top_menu" onClick="">장바구니</span></div>
				</div>
				<img id="list" src='resources/images/list.png'/>
			</div>
			
			<div id="mid1">
				<div id="line1"></div>
				<div id="login2"><span class="login2">비밀번호 변경 (Change Password)</span></div>
				<div id="home"><span class="home" onClick="">홈</span></div>
				<div id="arrow"><span class="home">></span></div>
				<div id="login2-1"><span class="login2-1">로그인</span></div>
				<div id="arrow2"><span class="home">></span></div>
				<div id="find"><span class="find">비밀번호 변경</span></div>
				<div id="line2"></div>
					
					<div id="inputId"><span>회원아이디</span></div>
					<input id="typeId" readOnly>
					<div id="inputName"><span>회원이름</span></div>
					<input id="typeName" readOnly>
					<div id="inputNewPw"><span>새비밀번호</span></div>
					<input id="typeNewPw">
					<div id="inputCheckPw"><span>새비밀번호 확인</span></div>
					<input id="typeCheckPw">
					
						<div id="loginpage_btn" onClick="">변경하기</div>
				</div>
			
			
			
			<div id="bottom">
				<div id="store_info"><span class="end">여기가 좋을 지도¿ CS NUMBER : 1644 - 3681</span></div>
				<div id="nate2"><span class="nate">사업자 등록번호: 123-81-21968｜통신판매업신고: 연수 1655호｜개인정보 보호책임자 : NATE</span></div>
				<div id="nate3"><span class="nate">문의 : handaeng1220@gmail.com</span></div>
			</div>
		</div>
	</form>
	
	<script>
    document.getElementById("loginpage_btn").onclick = function() {
        document.getElementById("modal").style.display="block";
    }
   
    document.getElementById("modal_close_btn").onclick = function() {
        document.getElementById("modal").style.display="none";
    }   
</script>
</body>
</html>