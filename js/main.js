
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

    newBtn.onclick = function (event) {
        var clickedBtnValue = event.target.value;
        lastday(event.target.id);
        location.href = "../action/monthSelectAction.jsp?month=" + clickedBtnValue;
    }

    monthBtnParent.appendChild(newBtn);
}

// 모달창에서 일정 추가 버튼 -> 현재 시간 default로 하기 위해
// var today = new Date();   
// var addHour = document.getElementById("addHour")
// addHour.value = ('0' + today.getHours()).slice(-2);

}


// 캘린더 메인에 출력 관련
var calendarParent = document.getElementById("calendar")
var modal = document.getElementById("modal")


// 일정 삭제시
window.addEventListener('message', () =>{
    const deleteBtns = document.querySelectorAll('.deleteBtnClass')
    const modifyBtns = document.querySelectorAll('.modifyBtnClass')
    const contents = document.querySelectorAll('.contentClass')
    const timeInput = document.querySelectorAll('.timeInputClass')
                    
    console.log(deleteBtns)
    console.log(contents)

    deleteBtns.forEach(function(btn, index) {
        btn.addEventListener('click', function() {
            console.log("삭제 버튼이 클릭되었습니다.");

            const contentValue = contents[index].value;

            console.log(contentValue)


            location.href = "../action/deleteScheduleAction.jsp?content="+contentValue;
        });
    });


    modifyBtns.forEach(function(btn, index){
        btn.addEventListener('click', function(){
            if(modifyBtns[index].value == "수정"){
                console.log("수정 버튼")
            modifyBtns[index].value = "등록"
            contents[index].removeAttribute("disabled");

            timeInput[index].removeAttribute("disabled");
            }
            else{
                
                const time = timeInput[index].value;
                const contentValue = contents[index].value;
                const contentIdx = contents[index].id;

                console.log(contentIdx)
                location.href = "../action/modifyScheduleAction.jsp?time="+time+"&content="+contentValue+"&idx="+contentIdx;
            }

            
        })
    })
})

for(var i=0; i<5; i++){
    var newRow = calendarParent.insertRow()
        for(var j=0; j<7; j++){
            var newCell = newRow.insertCell()

            if(i<4){
                newCell.innerHTML = i*7 + (j+1)
                newCell.id = "day"+(i+1)

                newCell.onclick = function(){
                    modal.style.display = "block"
                     var dateValues = displayDate(this)
                     var myDay = dateValues.day
                    window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=-100, top=-100,  scrollbars=no,status=no,toolbar=no,menubar=no,resizeable=no,location=no")
                }
            }
            else{
                if(j == 0){
                    newCell.id = "day29"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                        var dateValues = displayDate(this)
                        var myDay = dateValues.day
                        window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                    }
                }
                else if(j == 1){
                    newCell.id = "day30"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                         var dateValues = displayDate(this)
                         var myDay = dateValues.day
                        window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                    }
                }
                else if(j == 2){
                    newCell.id = "day31"

                    newCell.onclick = function(){
                        modal.style.display = "block"
                         var dateValues = displayDate(this)
                         var myDay = dateValues.day
                        window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                    }
                }
                else{
                    newCell.innerHTML = ""
                }
            }
        } 

        
}

function sendDataToJsp(dateValues){
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    // form.setAttribute('action', 'displayScheduleAction.jsp'); // 데이터를 전달할 JSP 페이지

    var hiddenFieldYear = document.createElement('input');
    hiddenFieldYear.setAttribute('type', 'hidden');
    hiddenFieldYear.setAttribute('name', "year");// 전달할 데이터의 이름 설정
    hiddenFieldYear.setAttribute('value', dateValues.year); 
    
    var hiddenFieldMonth = document.createElement('input');
    hiddenFieldMonth.setAttribute('type', 'hidden');
    hiddenFieldMonth.setAttribute('name', "month");
    hiddenFieldMonth.setAttribute('value', dateValues.month); 
    
    var hiddenFieldDay = document.createElement('input');
    hiddenFieldDay.setAttribute('type', 'hidden');
    hiddenFieldDay.setAttribute('name', "day");
    hiddenFieldDay.setAttribute('value', dateValues.day); 
    
    form.appendChild(hiddenFieldYear);
    form.appendChild(hiddenFieldMonth);
    form.appendChild(hiddenFieldDay);
    
    document.body.appendChild(form);

    form.submit();
   
}

// 모달창 맨 위에 날짜 나타내는 함수 (onclick에 부여)
function displayDate(id){
    var modalYear = document.getElementById("modalYear")
    var year = document.getElementById("year").value
    modalYear.value = year

    var modalMonth = document.getElementById("modalMonth")
    var month = document.getElementById("month").value
    modalMonth.value = month

    var modalDay = document.getElementById("modalDay")
    var day = id.innerHTML
    modalDay.value = day

    console.log("modalYear : "+modalYear.value)
    
    return {
        year : year,
        month : month,
        day : day
    }
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


function modifySchedule(myvalue){ // 수정 버튼 누를시
    // visible 상태일때 클릭하면 form 제출 jsp 로 넘어가도록 하자

    // 이전 형제 요소인 input type="text" 가져옴
    // 얘네 jsp로 보내기
    var siblingInput = myvalue.previousElementSibling 
    var siblingInputValue = siblingInput.value

    console.log("siblinginputvalue는 "+siblingInputValue)

    if(siblingInput.disabled == true){
        siblingInput.removeAttribute("disabled");   
        siblingInput.style.visibility ="visible";
    }
    else if(siblingInput.disabled == false){
        siblingInput.setAttribute('disabled',true);
        //disable = true가됨 = 수정불가 상태
        console.log("block 실행");
        // 닫을때 실행
        location.href = 'modifyScheduleAction.jsp?modifySchedule='+siblingInputValue
    }

    
}


function deleteSchedule(myvalue){
    var siblingInput = myvalue.previousElementSibling.previousElementSibling // 2개전으로 바꿔야함 ! 이전 요소는 수정 버튼임
    var siblingInputValue = siblingInput.value

    location.href = 'deleteScheduleAction.jsp?deleteSchedule='+siblingInputValue
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