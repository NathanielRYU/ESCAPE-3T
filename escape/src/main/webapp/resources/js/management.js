/**
 * 
 */
function mouseOver(obj) {
	let styleName = (obj.id == "mgr") ? "mgrOver" : "saleOver";
	obj.className = styleName;
}
function mouseLeave(obj) {
	obj.className = "divButton";
}
function moveServices(action, pSeCode, pEmCode) {
	const form = makeForm("", action, "post");
	const seCode = makeInputElement("hidden", "seCode", pSeCode, "");
	const emCode = makeInputElement("hidden", "emCode", pEmCode, "");
	form.appendChild(seCode);
	form.appendChild(emCode);

	document.body.appendChild(form);
	form.submit();
}
let publicIp;


function getPublicIp(pIp) {
	publicIp = pIp.ip;
}

function isEmpty(obj) {
	let check = true;
	if (obj.value == "") {
		check = false;
	}
	return check;
}

function makeForm(fname, faction, fmethod) {
	const form = document.createElement("form");
	if (fname != "") { form.setAttribute("name", fname); }
	form.setAttribute("action", faction);
	form.setAttribute("method", fmethod);
	return form;
}

function makeInputElement(type, name, value, placeholder) {
	const input = document.createElement("input");
	input.setAttribute("type", type);
	input.setAttribute("name", name);
	if (value != "") { input.setAttribute("value", value); }
	if (placeholder != "") { input.setAttribute("placeholder", placeholder); }

	return input;
}



function authentication() {

	const form = document.getElementsByName("login")[0];

	const hidden = makeInputElement("hidden", "publicIp", publicIp, "")
	form.appendChild(hidden)


	const userData = [];
	const message = ["INSERT SECODE", "INSERT EMCODE", "INSERT EMPASSWORD", "UNABLE TO GET PUBLICIP"]

	userData[0] = document.getElementsByName("seCode")[0];
	userData[1] = document.getElementsByName("emCode")[0];
	userData[2] = document.getElementsByName("emPassWord")[0];
	userData[3] = document.getElementsByName("publicIp")[0];


	/* 3. form 생성 */
	//const form = document.createElement("form");
	//form.setAttribute("action", "Access");
	//form.setAttribute("method", "post");

	/* 4. 데이터의 유효성 검사*/
	for (let index = 0; index < userData.length; index++) {
		if (!isEmpty(userData[index])) {
			alert(message[index]);
			return;
		} else {
			//form.appendChild(userData[index]);
		}
	}
	//const f = document.body.appendChild(form);

	/* 5. 서버 전송 */
	form.submit();
}
/* 1. 서버와의 통신 제어
 *  - HTML 개체의 제어 : FORM의 동적 생성
 * 2. 데이터의 유효성 검사
 * 3. AJAX + JSON
 */
function accessOut(seCode, emCode) {
	location.href = "AccessOut?seCode=" + seCode + "&emCode=" + emCode + "&publicIp=" + publicIp;
}
function getList(action, pseCode, pemCode) {
	
	//const userData = "seCode=" + pseCode + "&emCode=" + pemCode;
	//getAjaxJson(action, userData, "empList");
	
	let jsonData=[];
	jsonData.push({seCode:pseCode, emCode:pemCode});
	const clientData = JSON.stringify(jsonData);
	alert(clientData)
	fromJsonToJson(action, clientData, "empList", false);

}

function getList1(action, pseCode, pemCode) {

	const userData = "seCode=" + pseCode + "&emCode=" + pemCode;

	getAjaxJson1(action, userData, "memList");

}

function getList2(action, pseCode, pemCode) {

	let jsonData=[];
	jsonData.push({seCode:pseCode, emCode:pemCode});
	const clientData = JSON.stringify(jsonData);
	alert(clientData)
	fromJsonToJson(action, clientData, "goodsList", false);

}

function openModal(obj){
   let container = document.getElementById("container");
   container.style.filter = "alpha(Opacity=50)"
   container.style.display = "block";
}

function closeModal(){
   let container = document.getElementById("container");
   container.style.display = "none";
}

function getEmpForm(action, pseCode) {
	
	//const userData = "seCode=" + pseCode + "&emCode=" + pemCode;
	//getAjaxJson(action, userData, "empList");
	
	let jsonData=[];
	jsonData.push({seCode:pseCode});
	const clientData = JSON.stringify(jsonData);
	alert(clientData)
	fromJsonToJson(action, clientData, "RegEmpForm", false);

}

function RegEmpForm(jsonData) {

		let data = '<table>';
		data += '<input type="text" name="seCode" value="'+ jsonData[0].seCode +'" placeholder = readOnly />';
		data += '<input type="text" name="emCode" value="'+ jsonData[0].emCode +'" placeholder = readOnly />';
		data += '<input type="text" name="emName" placeholder="직원이름" />';
		data += '<input type="test" name="emPassWord" placeholder="비밀번호" />';
		data += '<input type="test" name="clsCode" placeholder="네깟놈의위치" />';
		data += '<input type="button" value="직원등록" onClick="sendRegEmp()"/>';
		data += '</table>';
	
		document.getElementById("ajaxData").innerHTML = data;
		//getList('mgr/EmpList',jsonData[0].seCode, jsonData[0].emCode);
	}

function sendRegEmp(){
		let action = "mgr/RegEmp";
		
		const pseCode = document.getElementsByName("seCode")[0].value;
		const pemCode = document.getElementsByName("emCode")[0].value;
		const pemName = document.getElementsByName("emName")[0].value;
		const pemPassWord = document.getElementsByName("emPassWord")[0].value;
		const pclsCode = document.getElementsByName("clsCode")[0].value;
		
		let jsonData=[];
		jsonData.push({seCode:pseCode,emCode:pemCode,emName:pemName,emPassWord:pemPassWord,clsCode:pclsCode});
		const clientData = JSON.stringify(jsonData);
		alert(clientData);
		
		fromJsonToJson(action, clientData, "empList", false);
	}

let golist;
function goodsList(list) {
	golist = list;
	
	/* ajaxData 영역 초기화*/
   let alist = document.getElementById("ajaxData"); 
   while(alist.hasChildNodes()){
      alist.removeChild(list.lastChild);
   }
	
	let ajaxData = document.getElementById("ajaxData");
	let div;
	
	for(idx=0; idx<list.length; idx++){
		 div = document.createElement("div");
		 div.setAttribute("onClick", "dispGoods(" + idx + ")");
		 let span1 = document.createElement("span");
		 span1.innerText = list[idx].goCode;
		 div.appendChild(span1);
	     let span2 = document.createElement("span");
		 span2.innerText = list[idx].goName;
		 div.appendChild(span2);
		 let span3 = document.createElement("span");
		 span3.innerText = list[idx].goCost;
		 div.appendChild(span3);
		 let span4 = document.createElement("span");
		 span4.innerText = list[idx].goPrice;
		 div.appendChild(span4);
	     let span5 = document.createElement("span");
		 span5.innerText = list[idx].goStocks;
		 div.appendChild(span5);
	     let span6 = document.createElement("span");
		 span6.innerText = list[idx].goDiscount;
		 div.appendChild(span6);
		 let span7 = document.createElement("span");
		 span7.innerText = list[idx].goStatus;
		 ajaxData.appendChild(div)
		}
	}

function dispGoods(idx){
	let mheader = document.getElementById("mheader");
	let mbody = document.getElementById("mbody");
	let command = document.getElementsByName("command")[0];
	
	/* command.button 셋팅*/
	command.setAttribute("onClick", "updGoodsInfo("+ idx +")");
	command.setAttribute("value", "상품정보수정요청");
		
	/* Modal Header 교체*/
	mheader.innerText = golist[idx].goName+ "상세정보";
	/* Table 생성 */
	let obj = "<table>";
	    obj += "<tr><td>"+ golist[idx].goCode + "</td><td>상품명</td><td colspan='3'>" + golist[idx].goName + "</td></tr>";
		obj += "<tr><td><img src='resources/"+ golist[idx].goImgLoc +"'></td><td>매입가격</td><td>" + golist[idx].goCost + "</td><td>판매가격</td><td>" + golist[idx].goPrice + "</td></tr>";
		obj += "<tr><td>"+ (golist[idx].goStatus=="S"? "판매중":golist[idx].goStatus=="D"? "판매불가":"일시품절") +"</td><td>할인율</td><td>" + golist[idx].goDiscount + "</td></tr>";
		obj += "</table>";
	mbody.innerHTML = obj;
	openModal();
}

function updGoodsInfo(idx){
	/*form정보 갱신*/
	let form = document.getElementsByName("dynamicFormData")[0];
	form.setAttribute("action", "mgr/UpdGoodsInfo");
	form.setAttribute("method", "post");
	form.setAttribute("enctype", "multipart/form-data");
	
	/* 파일정보 가져오기*/
	let files = document.getElementsByName("file")[0].files;
	let extensions = files[0].type.substring(files[0].type.indexOf("/")+1);
	alert(files[0].type);
	
	let formData = new FormData(form);
	formData.append("goCode",golist[idx].goCode);
	formData.append("goName",golist[idx].goName);
	formData.append("goCost",golist[idx].goCost);
	formData.append("goPrice",golist[idx].goPrice);
	formData.append("goStatus",golist[idx].goStatus);
	formData.append("goDiscount",golist[idx].goDiscount);
	formData.append("goImgLoc",files.length>0?golist[idx].goCode + "." + extensions:golist[idx].goImgLoc);
	formData.append("goStocks",golist[idx].goStocks);
	
	fromJsonToJson1(form.getAttribute("action"), formData, "completeUpdGoodsInfo", false);
}

function completeUpdGoodsInfo(serverData){
	alert(serverData);
	closeModal();
}

function memList(list) {

	let data = '<table>';

	data += '<td>회원코드</td>';
	data += '<td>회원이름</td>';
	data += '<td>회원번호</td>';
	data += '<td>회원등급</td>';


	for (let i = 0; i < list.length; i++) {
		data += '<tr><td>' + list[i].mmCode + '</td>';
		data += '<td>' + list[i].mmName + '</td>';
		data += '<td>' + list[i].mmNum + '</td>';
		data += '<td>' + list[i].mmCls + '</td></tr>';
	}
	
	data += '</table>';
		document.getElementById("ajaxData").innerHTML = data;
	}
	

	function empList(list) {
		

		let data = '<table>';

		data += '<td>매장코드</td>';
		data += '<td>매장이름</td>';
		data += '<td>직원코드</td>';
		data += '<td>직원명</td>';
		data += '<td>직급</td>';


		for (let i = 0; i < list.length; i++) {
			data += '<tr><td>' + list[i].seCode + '</td>';
			data += '<td>' + list[i].seName + '</td>';
			data += '<td>' + list[i].emCode + '</td>';
			data += '<td>' + list[i].emName + '</td>';
			data += '<td>' + list[i].clsCode + '</td></tr>';
		}

		data += '</table>';
		document.getElementById("ajaxData").innerHTML = data;
	}
	
	function fromJsonToJson(action, data, fn, content) {
      let ajax = new XMLHttpRequest();
      ajax.onreadystatechange = function() {
         if (ajax.readyState == 4 && ajax.status == 200) {
	        alert(ajax.responseText);
            window[fn](JSON.parse(ajax.responseText));

               //document.getElementById("ajaxData").innerHTML = serverData;
         }
      };

      ajax.open("post", action, true);
	  if(content){
		ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded; charset=utf-8");
	}else{
		ajax.setRequestHeader("Content-type","application/json; charset=utf-8");
	}
      ajax.send(data);
   }
   
	function fromJsonToJson1(action, data, fn, content) {
      let ajax = new XMLHttpRequest();
      ajax.onreadystatechange = function() {
         if (ajax.readyState == 4 && ajax.status == 200) {
	        alert(ajax.responseText);
            window[fn](ajax.responseText);

               //document.getElementById("ajaxData").innerHTML = serverData;
         }
      };

      ajax.open("post", action, true);
	  if(content){
		ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded; charset=utf-8");
	}
      ajax.send(data);
   }

   function getAjaxJsonUsingJquery(action, clientData, fn) {
      $.ajax({
         async : true,
         type : "post",
         url : action,
         data : clientData,
		 processData: false,
         contentType : "application/x-www-form-urlencoded; charset=utf-8",
         dataType : "json",
         success : function(jsonObject){
            alert("AJAX 통신 성공으로 서버 데이터가 도착했습니다.");
            alert(JSON.stringify(jsonObject));
            window[fn](jsonObject);
         },
         beforeSend : function(){
            // AJAX 통신 요청 전 호출되는 이벤트
            alert("AJAX 통신을 시작합니다.");
         },
         complete : function(){
            // AJAX 통신이 완료 될 때 호출되는 이벤트
            alert("AJAX 통신을 종료합니다.");
         },
         err : function(error){
            // 통신 실패시 호출되는 이벤트
            alert("AJAX 통신실패했습니다.");
         },
         timeout : 10000
      });
   }
	
	
	function getAjaxJson1(action, data, fn) {
		let ajax = new XMLHttpRequest();

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				window[fn](JSON.parse(ajax.responseText));
				alert(ajax.responseText);
			}

		};

		ajax.open("post", action, true);
		ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8")
		/*send 하기 전엔 state값 2, status 값은 없음*/
		ajax.send(data);/*send 누르면 state가 3으로 변함*/
	}
	
	function getAjaxJson2(action, data, fn) {
		let ajax = new XMLHttpRequest();

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				window[fn](JSON.parse(ajax.responseText));
				alert(ajax.responseText);
			}

		};

		ajax.open("post", action, true);
		ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8")
		/*send 하기 전엔 state값 2, status 값은 없음*/
		ajax.send(data);/*send 누르면 state가 3으로 변함*/
	}

	function activate(obj, idx) {
		const emPassword = document.getElementsByName("emPassword")[idx];
		const work = document.getElementsByName("work")[idx];
		const updBtn = document.getElementsByName("updBtn")[idx];
		if (obj.value == "수정") {
			obj.value = "수정취소";
			emPassword.readOnly = false;
			work.disabled = false;
			updBtn.disabled = false;
		} else {
			obj.value = "수정";
			emPassword.readOnly = true;
			work.disabled = true;
			updBtn.disabled = true;
		}
	}

	function activate1(obj, idx) {
		const mmNumber = document.getElementsByName("mmNumber")[idx];
		const work = document.getElementsByName("work")[idx];
		const updBtn = document.getElementsByName("updBtn")[idx];
		if (obj.value == "수정") {
			obj.value = "수정취소";
			mmNumber.readOnly = false;
			work.disabled = false;
			updBtn.disabled = false;
		} else {
			obj.value = "수정";
			mmNumber.readOnly = true;
			work.disabled = true;
			updBtn.disabled = true;
		}
	}



	function modEmpForm() {
		getAjaxData("ModEmpForm", "");
	}

	function modMemForm() {
		getAjaxData("ModMemForm", "");
	}

	function init(objName) {
      let container = document.getElementById("container");
      container.style.display = "none";
      if (objName != "") {
         document.getElementById(objName).onClick();
      }
   }
