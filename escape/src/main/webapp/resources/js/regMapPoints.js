//카테고리 버튼 클릭 시 div 변화
function changeFilter(i){
		
	if(i==1){
		document.getElementById("filterGenre2").style.display = "none";
		document.getElementById("filterFish2").style.display = "none";
		document.getElementById("filterGenre3").style.display = "none";
		document.getElementById("filterFish3").style.display = "none";
		const genre = document.getElementById("filterGenre"+i);
		const fish = document.getElementById("filterFish"+i);
		
		genre.style.display = "";
		fish.style.display="";
	
	}else if(i==2){
		document.getElementById("filterGenre1").style.display = "none";
		document.getElementById("filterFish1").style.display = "none";
		document.getElementById("filterGenre3").style.display = "none";
		document.getElementById("filterFish3").style.display = "none";
		const genre = document.getElementById("filterGenre"+i);
		const fish = document.getElementById("filterFish"+i);
		
		genre.style.display = "";
		fish.style.display="";
	}else{
		document.getElementById("filterGenre1").style.display = "none";
		document.getElementById("filterFish1").style.display = "none";
		document.getElementById("filterGenre2").style.display = "none";
		document.getElementById("filterFish2").style.display = "none";
		const genre = document.getElementById("filterGenre"+i);
		const fish = document.getElementById("filterFish"+i);
		
		genre.style.display = "";
		fish.style.display="";
	}
	
}

const theme = document.getElementsByClassName("select_btn_themespan");
const genre = document.getElementsByClassName("select_btn_genrespan");
alert(genre.length);
const fish = document.getElementsByClassName("select_btn_fishspan");
function addEvent() {
	
        for (var i = 0; i < theme.length; i++) {
          theme[i].addEventListener("click", handleClick1);
        }
  
		for (var i = 0; i < genre.length; i++) {
          genre[i].addEventListener("click", handleClick2);
        }

		for (var i = 0; i < fish.length; i++) {
          fish[i].addEventListener("click", handleClick3);
        }
      }

      addEvent();

//카테고리 클릭 시 className 변경
  function handleClick1(event) {
      console.log(event.target);
      

      console.log(event.target.classList);

      if (event.target.classList[1] === "_value") {
        event.target.classList.remove("_value");
      } else {
        for (var i = 0; i < theme.length; i++) {
          theme[i].classList.remove("_value");
        }

        event.target.classList.add("_value");
      }
  }
//장르 클릭 시 className 변경
  function handleClick2(event) {
      console.log(event.target);
      // console.log(this);
      // 콘솔창을 보면 둘다 동일한 값이 나온다

      console.log(event.target.classList);

      if (event.target.classList[1] === "_value") {
        event.target.classList.remove("_value");
      } else {
        for (var i = 0; i < theme.length; i++) {
          genre[i].classList.remove("_value");
        }

        event.target.classList.add("_value");
      }
  }

//어종 클릭 시 className 변경
  function handleClick3(event) {
      console.log(event.target);
      // console.log(this);
      // 콘솔창을 보면 둘다 동일한 값이 나온다

      console.log(event.target.classList);

      if (event.target.classList[1] === "_value") {
        event.target.classList.remove("_value");
      } else {
        for (var i = 0; i < theme.length; i++) {
          fish[i].classList.remove("_value");
        }
		
        event.target.classList.add("_value");
      }
  }
/* 낚시터 등록*/
function insFishing(){
   const pFpMaCfCode = document.getElementsByName("bigType")[0].value;
   const pFpCaCode = document.getElementsByName("smallType")[0].value;
   const pFpTitle = document.getElementsByName("title")[0].value;

}