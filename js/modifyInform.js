
         function idCheckEvent(){
            window.open("modifyIdCheckAction.jsp", "idCheck", "width=500 height=200")
        }

        function checkEvent(event){
            console.log("check이벤트 실행")

            var id = document.getElementById("idValue")
            var pw = String(document.getElementById("pwValue").value)
            var pwCheck = String(document.getElementById("pwCheckValue").value)
            var name = String(document.getElementById("nameValue").value)
            var tel = String(document.getElementById("telValue").value)
            
            var rank = document.getElementsByName("rank")
            var department = document.getElementsByName("department")
            var rankCount = rank.length
            var departmentCount = department.length
            var rankValid = 0
            var departmentValid = 0

      
            var numberPattern = /[0-9]/g;   //숫자
            var charPattern = /[a-zA-Z]/g;	 //문자 
            var blankPattern = /\s/g;  //공백
            var telPattern = /[^0-9]/g; // 전화번호에 숫자가 아닌 것이 들어갈 경우  

            // rank, department 체크박스 예외처리
            for(var i=0; i<rankCount; i++){
                if(rank[i].checked == true){ // 둘 다 체크 안됐으면 valid가 0 -> valid가 0이면 안넘어가게 예외처리
                    rankValid++
                    console.log("rank가 true")
                }
                else if(rank[i].checked == false){
                    console.log("rank가 false")
                }
               
            }

            for(var i=0; i<departmentCount; i++){
                if(department[i].checked == true){ // 둘 다 체크 안됐으면 valid가 0 -> valid가 0이면 안넘어가게 예외처리
                    departmentValid++
                }
            }
            // 체크박스 예외처리 끝

            //id 예외처리 시작
            if(id.search(/\s/) != -1){ // != -1 공백이 있으면 (search = 해당하는 문자가 있으면 첫번쨰값 숫자가져오고 없으면 -1 반환 )
                alert("id에 공백이 들어가면 안됩니다.")
                console.log(id.search(/\s/))
                event.preventDefault()
                return false //페이지 넘김 막음  
            } 
            else if(id.length = 0){
                alert("id를 입력하십시오.")
                event.preventDefault()
                return false //페이지 넘김 막음
            }
            else if(id.length < 4 || id.length > 11){
                alert("id를 4~11자로 입력하십시오.")
                event.preventDefault()
                return false
            }
            // pw 예외처리
            else if(pw.search(/\s/) != -1){
            alert("비밀번호에 공백이 들어가면 안됩니다.")
            event.preventDefault();
            return false
            }
            else if(pw.length = 0){
                alert("pw를 입력하십시오.")
                event.preventDefault()
                return false //페이지 넘김 막음
            }
            else if(!numberPattern.test(pw) || !charPattern.test(pw) || pw.length<8 || pw.length>15){
            alert("공백 제외 영문자, 숫자 포함 8~15자이어야합니다.")
            event.preventDefault();
            return false
        }
        else if(pw != pwCheck){
            alert("비밀번호 확인이 틀렸습니다.")
            event.preventDefault();
            return false 

        }
        // 이름 예외처리
        else if(name.search(/\s/) != -1){ 
            alert("이름에 공백이 들어가면 안됩니다.")
            event.preventDefault();
            return false //페이지 넘김 막음
            
         } 
         else if(name.length = 0){
            alert("이름을 입력하십시오.")
            event.preventDefault()
            return false //페이지 넘김 막음
        }
         else if(name.length <2 || name.length > 30){
            alert("2~30자 이내의 이름을 입력하십시오.")
            event.preventDefault();
            return false
         }
         //전화번호 예외
         else if(tel.search(/\s/) != -1){ 
            alert("전화번호에 공백이 들어가면 안됩니다.")
            event.preventDefault();
            return false //페이지 넘김 막음
            
         } 
         else if(tel.length = 0){
            alert("전화번호를 입력하십시오.")
            event.preventDefault()
            return false //페이지 넘김 막음
        }
         else if(telPattern.test(tel)){
            alert("전화번호에 숫자만 입력하십시오.")
            event.preventDefault();
            return false
         }
         else if(rankValid == 0){
            alert("직급을 선택하십시오.")
            event.preventDefault()
            return false
         }
         else if(departmentValid == 0){
            alert("부서를 선택하십시오.")
            event.preventDefault()
            return false
         }
        else{ //이상이 없을 시에
            console.log("성공함")
            document.myform.onsubmit
            return true
        }
    }