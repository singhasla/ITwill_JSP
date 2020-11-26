<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- jQuery  -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
    <!-- bootstrap JS -->
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    
    <!-- bootstrap CSS -->
    <link href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    
 
 
</head>
 
<body>
    
    <br><br>
 
    <div class="row">
    
        <button type="button" class="btn btn-outline btn-primary pull-right" id="selectBtn">선택</button>
        <table id="example-table-3" width="100%" class="table table-bordered table-hover text-center">
            <thead>
                <tr>
                    <th>선택</th>
                    <th>No. </th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody>                
                <tr>
                    <td><input type="checkbox" name="user_CheckBox" ></td>
                    <td>1</td>
                    <td>user07</td>
                    <td>NC소프트</td>
                    <td>nc@gmail.com</td>
                
                </tr>
                <tr>
                    <td><input type="checkbox" name="user_CheckBox" ></td>
                    <td>2</td>
                    <td>user08</td>
                    <td>넥슨</td>
                    <td>donson@naver.com</td>
                    
                </tr>
                <tr>
                    <td><input type="checkbox" name="user_CheckBox" ></td>
                    <td>3</td>
                    <td>user09</td>
                    <td>넷마블</td>
                    <td>net@gmail.com</td>
                </tr>
            </tbody>
        </table>
        <div class="col-lg-12" id="ex3_Result1" ></div> 
        <div class="col-lg-12" id="ex3_Result2" ></div> 
    </div>
    
    <br><br>
 
    <script>
    
    
        // 상단 선택버튼 클릭시 체크된 Row의 값을 가져온다.
        $("#selectBtn").click(function(){ 
//         	먼저 2개의 배열을 선언하였다. 
//         	rowData는 행의 값을 모두 담을 배열이고, 
//         	tdArr은 각각 td의 값을 담을 배열이다. 
//         	다음으로 체크된 체크박스를 가져와 checkbox라는 변수에 담는다.
        	var rowData = new Array();
            var tdArr = new Array();
            var checkbox = $("input[name=user_CheckBox]:checked");
            
             //체크된 체크박스의 수만큼 반복문을 실행 하여 
             //체크된 체크박스 값을 가져온다
            checkbox.each(function(i) {
    
                // checkbox.parent() : checkbox의 부모는 <td>이다.
                // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
                var tr = checkbox.parent().parent().eq(i);
                var td = tr.children();
                
                // 체크된 row의 모든 값을 배열에 담는다.
                rowData.push(tr.text());
                
                // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
                var no = td.eq(1).text()+", "
                var userid = td.eq(2).text()+", ";
                var name = td.eq(3).text()+", ";
                var email = td.eq(4).text()+", ";
                
                // 가져온 값을 배열에 담는다.
                tdArr.push(no);
                tdArr.push(userid);
                tdArr.push(name);
                tdArr.push(email);
                
                //console.log("no : " + no);
                //console.log("userid : " + userid);
                //console.log("name : " + name);
                //console.log("email : " + email);
            });
            
            $("#ex3_Result1").html(" * 체크된 Row의 모든 데이터 = "+rowData);    
            $("#ex3_Result2").html(tdArr);    
        });
    
    </script>
 
 
</body>
</html>


