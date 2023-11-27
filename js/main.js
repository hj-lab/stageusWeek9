
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

//모달창 닫기
var closeModalBtn = document.getElementById("xImg");

closeModalBtn.onclick = function(){
    modal.style.display = "none";
};

// 1~12월 버튼 생성
for(i=1; i<13; i++){ 
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

// 모달창에서 일정 추가 버튼 -> 현재 시간 default로 하기 위해
var today = new Date();   
var addHour = document.getElementById("addHour")
addHour.value = ('0' + today.getHours()).slice(-2);

}


// 캘린더 메인에 출력 관련
var calendarParent = document.getElementById("calendar")
var modal = document.getElementById("modal")

for(var i=0; i<5; i++){
    var newRow = calendarParent.insertRow()
        for(var j=0; j<7; j++){
            var newCell = newRow.insertCell()

            if(i<4){
                newCell.innerHTML = i*7 + (j+1)

                newCell.onclick = function(){
                    modal.style.display = "block"
                    displayDate(this)
                }
            }
            else{
                if(j == 0){
                    newCell.id = "day29"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                        displayDate(this)
                    }
                }
                else if(j == 1){
                    newCell.id = "day30"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                        displayDate(this)
                    }
                }
                else if(j == 2){
                    newCell.id = "day31"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                        displayDate(this)
                    }
                }
                else{
                    newCell.innerHTML = ""
                }
            }
        } 
}

// 모달창 맨 위에 날짜 나타내는 함수 (onclick에 부여)
function displayDate(id){
    var modalYear = document.getElementById("modalYear")
    var year = document.getElementById("year").value
    modalYear.innerHTML = year

    var modalMonth = document.getElementById("modalMonth")
    var month = document.getElementById("month").value
    modalMonth.innerHTML = month

    var modalDay = document.getElementById("modalDay")
    var day = id.innerHTML
    modalDay.innerHTML = day
}
// 년도 조절 함수 (좌,우 버튼)
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
            day29.innerHTML = 29;
            day30.innerHTML = 30;
            day31.innerHTML = "";
        }
        else if(lastday == 31){
            
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
   // console.log("monthfunc 실행, result 월은 "+result); 

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
    var hour = document.getElementById("addHour");
    var hourValue = parseInt(document.getElementById("addHour").value); 

    if(hourValue < 23){
        hour.value = hourValue + 1;
    }
    else{
        hourValue -= 23;
        hour.value = hourValue;
    }

}

function hourDown(){
    var hour = document.getElementById("addHour");
    var hourValue = parseInt(document.getElementById("addHour").value);
    
    if(hourValue > 0){
        hour.value = hourValue - 1;
    }
    else{
        hourValue += 23;
        hour.value = hourValue;
    }
}

function minuteDown(){ // 왜안내려가
    var minute = document.getElementById("addMinute");
    var minuteValue = parseInt(document.getElementById("addMinute").value);
    console.log("현재 minutevalue는"+minuteValue);
    if(minuteValue > 0){
        if(minuteValue-5 == 5){
            minute.value = "05"; 
        }
        else if(minuteValue-5 == 0){
            minute.value = "00"
        }
        else{
        minute.value = minuteValue - 5;
        }
    }
    else{ //minuteValue <=0 일때
        minuteValue += 55;
        minute.value = minuteValue
    }
}

function minuteUp(){
    var minute = document.getElementById("addMinute");
    var minuteValue = parseInt(document.getElementById("addMinute").value);
    
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