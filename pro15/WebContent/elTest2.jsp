<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>표현언어의 여러가지 연산자들</title>
</head>
<body>
	<h1>여러가지 산술 연산자</h1>
	
	<h2>
			${20 + 10} <br>
			${20 - 10} <br>
			${20 * 10} <br>
			${20 / 10} <br>
			
			<%-- div단어를 사용해 나누기 연산을 한다. --%>			
			${100 div 3} <br>
			
			
			${100 % 9} <br>
			<%-- %기호 대신에 mod단어를 사용해 나눈 나머지값을 구할 수 있다. --%>
			${100 mod 9} <br>
			
	</h2>
</body>
</html>