<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//request에 바인딩(저장)
		request.setAttribute("id", "hong");
		request.setAttribute("pwd", "1234");
		request.setAttribute("address", "서울시 강남구");
		
		//session에 바인딩
		session.setAttribute("name", "홍길동");
		
		//application에 바인딩
		application.setAttribute("email", "hong@test.com");
			
	%>
		<%--member4.jsp로 포워딩(재요청) 합니다. --%>
		<jsp:forward page="member4.jsp"/> 
		
		
</body>
</html>





