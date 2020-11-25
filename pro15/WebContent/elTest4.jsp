<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>표현언어의 여러가지 연산자들</title>
</head>
<body>
	<h1>여러가지 논리 연산자</h1>
	
	<h2>
			<%--
				표현언어 ${ }내부에 사용할 수 있는 논리연산자들

					논리연산자 사용법				
					1. &&연산자나 and연산자는 논리곱 연산을 한다
					2. ||연산자나 or연산자는 논리합 연산을 한다
					3. ! 연산자나 not연산자는 반대의 결과를 얻게 해주는 연산을 한다
			 --%>
			 
			 <%-- 1 --%>
			 ${(10 == 10) && (20 == 20)} <br>
			 ${(10 == 10) and (20 == 20)} <br>
			
			
			 <%-- 2 --%>
			 ${(10 == 10) || (20 == 20)} <br>
			 ${(10 == 10) or (20 == 20)} <br>
			 
			 <%-- 3 --%>
			 ${!(10 == 10)} <br>
			 ${not(10 == 10)} <br>
			 
	</h2>
</body>
</html>