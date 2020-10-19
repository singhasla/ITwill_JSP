<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--
		include.jsp페이지는 인클루드 디렉티브 태그를 이용해 
		duke_image.jsp페이지의 코드 내용을 모두 현재 페이지에 삽입하여 포함시킨다. 
	-->
	<h1>안녕하세요. 쇼핑몰 중심 JSP 시작영역입니다.</h1>
	
	<!-- 인클루드 디렉티브 태그를 사용하여 
			duke_image.jsp페이지의 코드 내용을 현재 위치에 포함시킨다. -->
	<%@ include file="duke_image.jsp" %>
	
	<h1>안녕하세요. 쇼핑몰 중심 JSP 끝 하단 영역입니다.</h1>
</body>
</html>