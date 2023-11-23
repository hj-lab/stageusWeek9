
window.onload = function(){
// 날짜 처리 관련 변수
var current = new Date();
var currentYear = current.getFullYear();
var currentMonth = current.getMonth()+1;

var year = document.getElementById("year");
year.value = currentYear;

var month = document.getElementById("month");
month.value = currentMonth; //월은 0~11로 표기되기 때문에 실제로는 +1 해줘야함

var showMonth = "month"+parseInt(currentMonth);
// 현재 페이지에 오늘 날짜의 월에 해당하는 일 수 표기하기 위해
lastday(showMonth);

}

// // 모달창 관련 변수
// var modal = document.getElementById("modal");
// var openModalBtn = document.getElementById("scheduleBox");
// var closeModalBtn = document.getElementById("xImg");

// // 모달창 열기
// openModalBtn.onclick = function(){
//     modal.style.display = "block";
// };
// // 모달창 닫기
// closeModalBtn.onclick = function(){
//     modal.style.display = "none";
// };


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

var calendarParent = document.getElementById("calendar")
for(var i=0; i<5; i++){
    var newRow = calendarParent.insertRow()

    var newCell1 = newRow.insertCell(0)
    var newCell2 = newRow.insertCell(1)
    var newCell3 = newRow.insertCell(2)
    var newCell4 = newRow.insertCell(3)
    var newCell5 = newRow.insertCell(4)
    var newCell6 = newRow.insertCell(5)
    var newCell7 = newRow.insertCell(6)

    if(i<4){
        newCell1.innerHTML = i*7+1
        newCell2.innerHTML = i*7+2
        newCell3.innerHTML = i*7+3
        newCell4.innerHTML = i*7+4
        newCell5.innerHTML = i*7+5
        newCell6.innerHTML = i*7+6
        newCell7.innerHTML = i*7+7
    }
    else{
        newCell1.id = "day29"
        newCell2.id = "day30"
        newCell3.id = "day31"
        newCell4.id = ""
        newCell5.id = ""
        newCell6.id = ""
        newCell7.id = ""
        
       
    }

}


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


// 월 버튼을 클릭했을때 month1 형식으로 인자 전달 (id자리에)
function lastday(id){ // 각 월의 마지막 날짜 계산하는 함수

    var reg = /[^0-9]/g;
    var result = id.replace(reg, ""); // 각 월 c추출
    

    var day29 = document.getElementById("day29");
    var day30 = document.getElementById("day30");
    var day31 = document.getElementById("day31");

    var calendarParent = document.getElementById("calendar")
    var lastday = new Date(2023, result, 0).getDate();

    if(result != 2){
        
        
        if(lastday == 30){
            console.log("lastday함수 호출. 마지막 일은 "+lastday)
            day29.innerHTML = 29;
            day30.innerHTML = 30;
            day31.innerHTML = "";
        }
        else if(lastday == 31){
            console.log("lastday함수 호출. 마지막 일은 "+lastday)
            day29.innerHTML = 29
            day30.innerHTML = 30
            day31.innerHTML = 31
        }
    }
    else if(result == 2){
        day29.innerHTML = ""
        day30.innerHTML = ""
        day31.innerHTML = ""
    }
    
}

function monthfunc(id){ //현재 페이지 month 출력함수
    var month = document.getElementById("month");

    
    
    var reg = /[^0-9]/g;
    var result = id.replace(reg, ""); // 각 월 추출
    console.log("monthfunc 실행, result 월은 "+result); 

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
            e.preventDefault(); //고유 동작 중단시킴
            e.stopPropagation(); // 상위 element로의 이벤트 전파를 중단시킴
            }
    );
                
}


function closeNav(){
    document.getElementById("navBar").style.display = "none";
    document.querySelector("#dimmed").remove();

    console.log("closeNave 실행");
}