<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- jQuery  -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
 
<body>
 
    <br><br>
 
    아이디 : <input type="text" id="id1" > , 비밀번호 : <input type="text" id="pw1" ><br><br>
    아이디 : <input type="text" id="id2" > , 비밀번호 : <input type="text" id="pw2" ><br><br>
 
    <button id="changeBtn">JSON 변환</button><br><br>
 
    <strong> :: 출력결과 :: </strong><br><br>
    <div id="result"></div>
 
    <script>
 
        $("#changeBtn").click(function(){ 
            
            // 배열을 선언한다.
            var dataArr = new Array();
 
            
            for(var i=1; i<=2; i++){
                 
                // 객체 생성
                var dataObj = new Object();
                
                // 객체에 input 값을 담는다.
                dataObj.id = $("#id"+i).val();
                dataObj.pw = $("#pw"+i).val();
                    
                // 배열 생성된 객체 삽입
                dataArr.push(dataObj) ;
            }
 
            // json 형태의 문자열로 만든다.
            var jsonData = JSON.stringify(dataArr);
 
            $("#result").html(jsonData);    
        });
    </script>
 
</body>
</html>


