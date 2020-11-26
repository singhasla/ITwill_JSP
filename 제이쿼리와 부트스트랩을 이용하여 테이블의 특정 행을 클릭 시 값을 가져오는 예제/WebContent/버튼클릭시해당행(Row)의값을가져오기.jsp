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
        <table id="example-table-2" width="100%" class="table table-bordered table-hover text-center">
            <thead>
                <tr>
                    <th>No. </th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>버튼</th>
                </tr>
            </thead>
            <tbody>                
                <tr>
                    <td>1</td>
                    <td>user04</td>
                    <td>맥크리</td>
                    <td>sunset@gmail.com</td>
                    <td><input type="button" class="checkBtn" value="클릭" /></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>user05</td>
                    <td>메르시</td>
                    <td>Mercy@naver.com</td>
                    <td><input type="button" class="checkBtn" value="클릭" /></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>user06</td>
                    <td>한조</td>
                    <td>trolling@gmail.com</td>
                    <td><input type="button" class="checkBtn" value="클릭" /></td>
                </tr>
            </tbody>
        </table>
        <div class="col-lg-12" id="ex2_Result1" ></div> 
        <div class="col-lg-12" id="ex2_Result2" ></div> 
    </div>
 
 
        <br><br>
 
 
    <script>
 
        // 버튼 클릭시 Row 값 가져오기
        $(".checkBtn").click(function(){ 
            
//         	버튼을 클릭하면 이벤트가 발생하고 Script가 실행된다. 
//         	먼저 문자열을 담을 변수 str과 배열을 선언한다. 
//         	다음으로 클릭 된 버튼을 checkBtn이란 변수에 담는다.
            var str = ""
            var tdArr = new Array();    // 배열 선언
            var checkBtn = $(this);
            
            
//        여기서는 parent( )를 이용해 버튼 checkBtn의 부모를 찾는다. 
//        checkBtn은 <td> 안에 있으므로 checkBtn의 부모는 td가 된다. 
//        여기서 다시 한번 부모를 찾게 되면 tr이 되고 이것은 현재 버튼이 클릭된 행이 된다.
//        클릭된 tr을 찾았으면 아래에 있는 children( )을 이용해 td를 찾는다.
            // checkBtn.parent() : checkBtn의 부모는 <td>이다.
            // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
            var tr = checkBtn.parent().parent();
            var td = tr.children();
          
            
//        tr.text( )을 이용하면 해당 행의 모든 값을 가져올 수 있다. 
//        td 값을 각각 가져오려면 td.eq(인덱스) 를 이용하면 된다.
            
            console.log("클릭한 Row의 모든 데이터 : "+tr.text());
            
            var no = td.eq(0).text();
            var userid = td.eq(1).text();
            var name = td.eq(2).text();
            var email = td.eq(3).text();
            
            
            // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
            td.each(function(i){    
                tdArr.push(td.eq(i).text());
            });
            
            console.log("배열에 담긴 값 : "+tdArr);
            
 
            str +=    " * 클릭된 Row의 td값 = No. : <font color='red'>" + no + "</font>" +
                    ", 아이디 : <font color='red'>" + userid + "</font>" +
                    ", 이름 : <font color='red'>" + name + "</font>" +
                    ", 이메일 : <font color='red'>" + email + "</font>";        
            
            $("#ex2_Result1").html(" * 클릭한 Row의 모든 데이터 = " + tr.text());        
            $("#ex2_Result2").html(str);    
        });
    
 
    </script>
 
 
</body>
</html>

