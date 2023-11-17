var modal = document.getElementById("modal");
var openModalBtn = document.getElementById("scheduleBox");
var closeModalBtn = document.getElementById("xImg");
// 모달창 열기
openModalBtn.onclick = function(){
modal.style.display = "block";
// document.body.style.overflow = "hidden"; // 스크롤바 제거
};
// 모달창 닫기
closeModalBtn.onclick = function(){
modal.style.display = "none";
// document.body.style.overflow = "auto"; // 스크롤바 보이기
};


var current = new Date();
var currentYear = current.getFullYear();
var currentMonth = current.getMonth()+1;

var year = document.getElementById("year");
year.value = currentYear;

console.log("현재년도는 "+currentYear);

var month = document.getElementById("month");
month.value = currentMonth; //월은 0~11로 표기되기 때문에 실제로는 +1 해줘야함

// 현재 페이지에 오늘 날짜의 월에 해당하는 일 수 표기하기 위해
var showMonth = "month"+parseInt(currentMonth);
lastday(showMonth);


function yearDown(){ 
    var year = document.getElementById("year");
    var yearValue = document.getElementById("year").value;
    year.value = parseInt(yearValue) - 1;
}

function yearUp(){
    var year = document.getElementById("year");
    var yearValue = document.getElementById("year").value;
    year.value = parseInt(yearValue) + 1;
}



for(i=1; i<13; i++){ // 1~12월 버튼 생성
    var newBtn = document.createElement("INPUT");
    newBtn.setAttribute("type", "button");
    var monthBtnParent = document.getElementById("monthBtnParent");
    var month = document.getElementById("month");
    

    newBtn.value = i+"월";
    newBtn.className = "monthBtn";
    newBtn.id = "month"+i;

    newBtn.onclick = function(){
        lastday(this.id);
        monthfunc(this.id);
    }
    

    monthBtnParent.appendChild(newBtn);
}

function lastday(id){ // 각 월의 마지막 날짜 계산하는 함수

    var reg = /[^0-9]/g;
    var result = id.replace(reg, ""); // 각 월 c추출
    console.log(result); 

    var day29 = document.getElementById("day29");
    var day30 = document.getElementById("day30");
    var day31 = document.getElementById("day31");

    if(result == 2){
        day29.innerHTML = "";
        day30.innerHTML = "";
        day31.innerHTML = "";
    }
    else{
    var lastday = new Date(2023, result, 0).getDate();
    console.log(lastday.toLocaleString()); // 각 월의 마지막 날짜

        if(lastday == 30){
            day29.innerHTML = 29;
            day30.innerHTML = 30;
            day31.innerHTML = "";
        }
        else if(lastday == 31){
            day29.innerHTML = 29;
            day30.innerHTML = 30;
            day31.innerHTML = 31;
        }
    }
}

function monthfunc(id){ //현재 페이지 month 출력함수
    var month = document.getElementById("month");
    
    var reg = /[^0-9]/g;
    var result = id.replace(reg, ""); // 각 월 추출
    console.log(result); 

    month.value = parseInt(result);

}



function modifySchedule(){ // 수정 버튼 누를시
    if(document.getElementById('comment1').disabled == true){
        document.getElementById('comment1').removeAttribute("disabled");   

        // disabled = false가됨 = 수정할 수 있는 상태
        console.log("modify 실행 ");

        document.getElementById("hideUpBtn").style.visibility = "visible";
         document.getElementById("hideDownBtn").style.visibility = "visible";
   
    }
    else if(document.getElementById('comment1').disabled == false){
        document.getElementById('comment1').setAttribute('disabled',true);

        //disable = true가됨 = 수정불가 상태
        console.log("block 실행");

        document.getElementById("hideUpBtn").style.visibility = "hidden";
         document.getElementById("hideDownBtn").style.visibility = "hidden";
    }
    
}

function hourUp(){
    var hour = document.getElementById("hour");
    var hourValue = parseInt(document.getElementById("hour").value);
    
    if(hourValue < 23){
        hour.value = hourValue + 1;
    }
    else{
        hourValue -= 23;
        hour.value = hourValue;
    }

}

function hourDown(){
    var hour = document.getElementById("hour");
    var hourValue = parseInt(document.getElementById("hour").value);
    
    if(hourValue > 0){
        hour.value = hourValue - 1;
    }
    else{
        hourValue += 23;
        hour.value = hourValue;
    }
}

function minuteDown(){ // 왜안내려가
    var minute = document.getElementById("minute");
    var minuteValue = parseInt(document.getElementById("minute").value);
    console.log("현재 minutevalue는"+minuteValue);
    if(minuteValue > 0){
        if(minuteValue-5 == 5){
            console.log(minuteValue);
            minute.value = "05"; 
        }
        else if(minuteValue-5 == 0){
            minute.value = "00";
        }
        else{
        minute.value = minuteValue - 5;

        console.log(minuteValue);
        }
    }
    else{ //minuteValue <=0 일때
        minuteValue += 60;
    

        console.log("실행"+minuteValue);
    }
}

function minuteUp(){
    var minute = document.getElementById("minute");
    var minuteValue = parseInt(document.getElementById("minute").value);
    
    if(minuteValue < 60){
        if(minuteValue+5 == 5){
            minute.value = "05";
        }
        else if(minuteValue+5 == 60){
            minute.value = "00";
        }
        else{
        minute.value = minuteValue + 5;
        }
    }
    else{
        minuteValue -= 60;
    }
    
}

function openNav(){
    document.getElementById("navBar").style.display = "block";
    console.log("openNav 실행");

    var div = document.createElement("div");
        div.id = "dimmed";
        document.body.append(div);
          
        var dimmed = document.querySelector("#dimmed");
        dimmed.addEventListener("scroll wheel", function (e) {
            // 문서 스크롤시, 마우스 휠 내릴시
            e.preventDefault(); //고유 동작 중단시킴
            e.stopPropagation(); // 상위 element로의 이벤트 전파를 중단시킴
            // return false;
            }
        );
                
}


function closeNav(){
    document.getElementById("navBar").style.display = "none";
    document.querySelector("#dimmed").remove();

    console.log("closeNave 실행");
}