<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>여기는 responseTest1.jsp페이지 입니다.</h1>
	
	<%
		//response객체의 sendRedirect()메소드를 이용해서
		//리다이렉트 방식으로 다른 서버페이지를 포워딩(재요청)하여 페이지의 흐름을 바꾸어 이동시키자
		//response.sendRedirect("포워딩할 서버페이지 주소");
		response.sendRedirect("responseTest2.jsp");
		//response.sendRedirect("https://www.daum.net");
	%>
</body>
</html>