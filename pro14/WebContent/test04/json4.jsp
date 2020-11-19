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
				//	- JSON배열의 요소에 JSON객체를 저장한 후 다시 배열에 접근하여 JSON객체의 속성값을 얻어 출력
				var jsonStr = '{	"members":[{"name":"박지성","age":30,"gender":"male"},'
				                    	     +'{"name":"김연아","age":20,"gender":"female"},'
				                    	     +'{"name":"손흥민","age":25,"gender":"male"}]	}';	//"name":"value", ...
				
				
				//json.parse()메소드
				//	- parse()메소드는 String객체를 JSON Object객체로 변환해서 반환해주는 역할을 함
				var jsonInfo = JSON.parse(jsonStr);
				
				var output = "회원정보<br>";
				
				output+="==========<br>";
				
				for(var i in jsonInfo.members){
					output+="이름:"+ jsonInfo.members[i].name + "<br>";
					output+="나이:"+ jsonInfo.members[i].age + "<br>";
					output+="성별:"+ jsonInfo.members[i].gender + "<br>";
					
					output+="==========<br>";	
				}
				
				//아래의 <div>요소 영역에 출력json4.jsp
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