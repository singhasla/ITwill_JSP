<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>표현언어의 여러가지 연산자들</title>
</head>
<body>
	<h1>여러가지 비교 연산자</h1>
	
	<h2>
			<%--
				표현언어에서 비교연산자 사용 방법
				
					1. 값이 같은지 비교 할때는 == 또는 eq 연산자를 사용
					2. 값이 같지 않은지 비교할때는 != ne 연산자를 사용
					3. 대소 비교시 > 와 < 연산자 그리고 gt 와 lt도 각각 연산자로 사용할 수 있다.
					4. 대소 미 동등 비교르 동시에 할때는 >=와 <= 연산자 그리고 ge와 le도 각각 연산자로 사용할 수 있다.
					
			 --%>
			 
			 <%-- 1 --%>
			 ${10 == 10} <br>
			 ${10 eq 10} <br>
			
			
			 <%-- 2 --%>
			 ${20 != 10} <br>
			 ${"20" ne "10"} <br>
			 
			 <%-- 3 --%>
			 ${10 gt 10} <br>
			 ${10 lt 10} <br>
			 
			 <%-- 4 --%>
			 ${10 ge 10} <br>
			 ${10 le 10} <br>
	</h2>
</body>
</html>