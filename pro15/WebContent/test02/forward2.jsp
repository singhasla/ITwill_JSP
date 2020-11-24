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
	
		//MemberBean객체 생성시 생성자를 호출해 각 인스턴스변수에 값을 저장
		MemberBean member = new MemberBean("lee", "1234", "이순신", "lee@test.com");
		
		//생성한 MemberBean객체 -> request내장객체 영역에 저장
		request.setAttribute("member", member);
		
	%>
	
		<%-- member2.jsp로 포워딩(재요청) 합니다. --%>
		<jsp:forward page="member2.jsp"/>
	
</body>
</html>