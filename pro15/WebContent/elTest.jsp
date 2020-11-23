<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>표현언어(EL: Expression Language)로 여러가지 데이터 출력하기</h1>
	
	<h2>
		${100}<br>
		${"안녕하세요"} <br>
		${100 + 1} <br>
		
		<%-- 숫자형태의 문자열과 실제 숫자를 더하면 
				문자열을 자동으로 숫자로 변환하여 더하여 표현언어로 출력 --%>
			${"100" + 1} <br>
		
		<%-- null값과 100을 더하면 100이 출력 --%>
			${"100" + null} <br>
		
		<%-- 문자열과 숫자는 더할 수 없음 --%>
			<%-- ${"100" + "안녕"} <br> --%>
		
		<%-- 문자열끼리는 더하여 출력할 수 없음 --%>
			<%-- ${"안녕" + "하세요"} <br> --%>
		
	</h2>
</body>
</html>