<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<!--JQuery Setup-->
	<script src="http://code.jquery.com/jquery-3.5.1.js"></script>
	
	<script type="text/javascript">
	
		$(function() {
			
			//id속성값이 checkJson인? <a>요소를 선택해서 가져와서 클릭이벤트 등록
			$("#checkJson").click(function() {
			
				//JSON객체 만들기
				//	- JSON객체 형태의 문자열을 변수에 저장
				//	- 회원정보를 JSON객체 형태의 문자열로 만들어서 저장
				var jsonStr = '{"name":"박지성", "age":25 , "gender":"male", "nickname":"날쌘돌이"}';	//"name":"value", ...
				
				
				//json.parse()메소드
				//	- parse()메소드는 String객체를 JSON Object객체로 변환해서 반환해주는 역할을 함
				var jsonInfo = JSON.parse(jsonStr);
				
				var output = "회원정보<br>";
				
				output+="==========<br>";
				
				output+="이름:"+ jsonInfo.name + "<br>";
				output+="나이:"+ jsonInfo.age + "<br>";
				output+="성별:"+ jsonInfo.gender + "<br>";
				output+="별명:"+ jsonInfo.nickname + "<br>";
					
				//아래의 <div>요소 영역에 출력json3.jsp
				$("#output").html(output);
				
				
				
			});
			
		});
		
	
	</script>
	
</head>
<body>
	<a id="checkJson" style="cursor: pointer;">출력</a> <br><br>
	
	<div id="output"></div>
</body>
</html>