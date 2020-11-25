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
				//	- JSON객체는 중괄호{}로 둘러싸서 표현한다
				//	- {}안에 실제 값은 name:value를 쌍으로 나열해서 저장한다.
				//	- "name" -> 배열이름
				//	- ["홍길동", "이순신", "임꺽정"]	->	배열
				var jsonStr = '{"name" : ["홍길동", "이순신", "임꺽정"]}';
				
				
				//json.parse()메소드
				//	- parse()메소드는 String객체를 JSON Object객체로 변환해서 반환해주는 역할을 함
				var jsonInfo = JSON.parse(jsonStr);
								// {"name" : ["홍길동", "이순신", "임꺽정"]}	<-- JSON Object객체(''작은따옴표 없음)
				alert(jsonInfo);
				console.log(jsonInfo);	//웹브라우저 F12 -> 웹브라우저의 console탭 확인
				
				
				//JSON.stringify()메소드
				//	- stringify()메소드는 JSON Object객체 데이터를 String객체로 변환해서 반환해주는 역할을 함
				var s = JSON.stringify(jsonInfo);
				alert(s);
				console.log(s);	// '{"name" : ["홍길동", "이순신", "임꺽정"]}'	<-- String객체(''작은따옴표 있음)
					
				var output = "회원이름<br>";
				
				output+="==========<br>";
				
					for(var i in jsonInfo.name){	/* 향상된 포문 for( 각 배열의 인덱스위치값을 저장할 변수 in 배열) */
													/* jsonInfo.name = ["홍길동", "이순신", "임꺽정"] */
						output += jsonInfo.name[i] + "<br>";
													
					}
					
				//아래의 <div>요소 영역에 출력
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