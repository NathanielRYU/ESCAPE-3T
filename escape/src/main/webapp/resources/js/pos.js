/**
 * WEBPOS JS 파일이라고
 */

function isEmpty(obj){
		let check = true;
		if(obj.value == ""){
			check = false;
		}
		return check;
	}
	
function makeForm(fname, faction, fmethod){
	const form = document.createElement("form");
	if(fname != ""){form.setAttribute("name", fname);}
	form.setAttribute("action", faction);
	form.setAttribute("method", fmethod);
	return form;
}

function makeInputElement(type, name, value, placeholder){
	const input = document.createElement("input");
	input.setAttribute("type", type);
	input.setAttribute("name", name);
	if(value != ""){input.setAttribute("value", value);}
	if(placeholder != ""){input.setAttribute("placeholder", placeholder);}
	
	return input;
}

function accessOut(seCode, emCode) {

		location.href = "AccessOut?seCode=" + seCode + "&emCode" + emCode;

}

function getAjaxJson(action, data, fn) {
		const ajax = new XMLHttpRequest();

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				window[fn](JSON.parse(ajax.responseText));
				alert(ajax.responseText);
			}
		};
		ajax.open("post", action, true);
		ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		ajax.send(data);
	}
	
	
function goodsInfoCtl(pgoCode){
	const action = "GetGoods";
	const goodsCode = document.getElementsByName(pgoCode)[0];
	
	if(goodsCode.value != ""){
		if(!compareGoCode(goodsCode.value, "record")){
			const data = JSON.stringify({goCode:goodsCode.value});
			getAjaxJson2("mgr/SearchGoods", data, "addGoods")
		}
	}else {
		alert("다시해라인간아");
	}
	goodsCode.value = "";
	goodsCode.focus();
}

function getAjaxJson2(action, data, fn) {
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

function compareGoCode(){
	let check = false;
	const record = document.getElementsByName("leftup2");

	for(idx=0; idx<record.length; idx++){
		let itemList = record[idx].childNodes;
		const qty = parseInt(itemList[2].innerText);
		if(itemList[6].innerText == goCode){
			itemList[2].innerText = qty + 1;
			itemList[4].innerText = parseInt(itemList[3].innerText) * parseInt(itemList[2].innerText);
		
			check = true;
			orderList();
			break;
		}
	}
	return check;
}


function orderList(){
	const quantity = document.getElementsByName("goQuantity");
	const amount = document.getElementsByName("goAmount");
	const discount = document.getElementsByName("goDiscount");
	
	let sumObj = document.getElementsByName("sum");
	
	let sum = [0,0,0]; 
	for(idx=0; idx<quantity.length; idx++){
		sum[0] += parseInt(quantity[idx].innerText);
		sum[1] += parseInt(amount[idx].innerText);
		sum[2] += parseInt(discount[idx].innerText);
	}
	for(idx=0; idx<sum.length; idx++){
      sumObj[idx].innerText = sum[idx];
}
resetNumber();
}

function regOrder(){
   const amount = document.getElementsByName("goAmount");
   const discount = document.getElementsByName("goDiscount");
   const goPrice = document.getElementsByName("goPrice")
   let price = document.getElementsByName("totPrice");
   
   let sum = [0,0,0];
   
   for(idx=0; idx<amount.length; idx++){
      sum[0] +=parseInt(amount[idx].innerText);
      sum[1] += (parseInt(amount[idx].innerText) * parseInt(discount[idx].innerText) * 1/100);
      sum[2] += (parseInt(amount[idx].innerText) -  (parseInt(amount[idx].innerText) * parseInt(discount[idx].innerText) * 1/100));
   }
   for(idx=0; idx<sum.length; idx++){
      price[idx].innerText = sum[idx];
   }
}

const itemName = ["no","goName","goQuantity","goPrice","goAmount", "goDiscount", "goCode" ];
let no = 0;
let currentRecord = null;

	

function addGoods(jsonData){
	no++;
	const list = document.getElementById("leftup2");
	let record = createDiv("record","record");
	//record.setAttribute("onClick","selectRecord(this)");
	if(jsonData.goStatus == "S" && jsonData != null){
		for(colIdx=0; colIdx<7; colIdx++){
		let item = createDiv(itemName[colIdx],"goods "+itemName[colIdx]);
		item.innerHTML = (colIdx==0)? no :(colIdx==1)? jsonData.goName: (colIdx==2)? jsonData.goQuantity: (colIdx==3)? jsonData.goPrice: (colIdx==4)? jsonData.goQuantity*jsonData.goPrice: (colIdx==5)? jsonData.goDiscount: jsonData.goCode;
		record.appendChild(item);
	} list.appendChild(record);
		
	}else{
		
	}
	orderList();
	regOrder();
}

function selectRecord(obj){
	if(currentRecord != null){
		currentRecord.style.color = "#212121";
		currentRecord = null;
	}
	currentRecord = obj;
	obj.style.color = "#FF007F";
}


/* func createDiv */
function createDiv(name, className){
 	const div = document.createElement("div"); // <div></div>
 	div.setAttribute("name", name); // <div name=""></div>
 	div.setAttribute("class", className);
 	return div;
}

/* Remove Record DIV 
	childElementCount :: 자식요소의 개수
	removeChild()
	  firstChild :: 자식요소 중 첫번째 요소
		lastChild  :: 자식요소 중 마지막 요소
	hasChildNodes() :: 자식노드의 유무 판단 : boolean
*/


/* func delete */
function deleteRecord(objName){
	
	if(currentRecord != null){
		currentRecord.remove();
		no--;
		resetNumber();
	}else{
		const obj = document.getElementById(objName);
		obj.removeChild(obj.lastChild);
		no--;
	}
	currentRecord = null;
	orderList();
	}

function resetNumber(){
	let list = document.getElementById("leftup2").childNodes;
	for(idx=0; idx<list.length; idx++){
		let subList = list[idx].childNodes;
		subList[0].innerText = idx+1;
	}
}


function modQty(qty, objName){

	let childList = null;
	
	if(currentRecord != null){
		childList = currentRecord.childNodes;
	}else{
		const obj = document.getElementById(objName);
		childList = obj.lastChild.childNodes;
	}
	let quantity = parseInt(childList[2].innerText)+qty;
	if(quantity > 0 ){
		childList[2].innerText = quantity;
		childList[4].innerText = parseInt(childList[3].innerText)*quantity;
	}else{
		delRecord(objName);
	}
	regOrder();
	orderList();
}

/* 모든 record 삭제하기*/
function delrecord(){
   let list = document.getElementById("leftup2");
   
   while(list.hasChildNodes()){
      list.removeChild(list.firstChild);
      }
      orderList();
	  regOrder();
}

function payments(action){
   //상품코드 수량
   let list = document.getElementById("leftup3").childNodes;
   if(list.length == 0) return;
   
   /*ClientData 생성
      goCode=1234&goQuantity=2&goCode=M1001&goQuantity=3...
	--> [{goCode:1001, goQty:2}, {goCode:1001, goQty:2}] --> Frontend job
    */
const goCode = document.getElementsByName("goCode");
const goQuantity = document.getElementsByName("goQuantity");
let clientData = [];
for(idx = 0; idx<goCode.length; idx++){
	clientData.push({goCode:goCode[idx].innerText, goQty:goQuantity[idx].innerText})
}
getAjaxJson2("mgr/ReqOrder", JSON.stringify(clientData), "delrecord");
}

function init(msg){
		
		if(msg == "1"){
			alert("주문성공");	
		}else{
			alert("주문실패");
		}
		orderList();
}

/* DOM :: Document Object Model
								 H 
						     |  parentNode
						____ A _____
					 |     |      |    childNodes
					B      C      D		
	 Node Property
	  - parentNode  --> 
		- childNodes  --> |     |      |    childNodes.length
		- firstChild  --> B
		- lastChild   --> D
		- nodeName    --> Element Name
		- nodeType
			  node type : Element Node :: 1
										Attribute Node :: 2  --> X
										Text Node :: 3
				rec = document.getElementById("record");
				   rec.nodeType ==> 1
					 rec.setAttribute("","");  ==> 2
	         rec.innerHTML = "Hoon";  ==> 3
		- nodeValue
			[B-C-D]
		- nextSibling : D     
		- previousSibling : B
		
Node Method
    - appendChild()
    - removeChild()
    - hasChildNode()  --> boolean
    - insertBefore()
    - isEqualNode()  --> boolean
    - replaceChild()
*/









