<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
	
		//ArrayList가변길이 배열 생성
		List membersList = new ArrayList();
		
		//MemberBean객체 생성시 생성자를 호출해 각 인스턴스변수에 값을 저장
		MemberBean m1 = new MemberBean("lee", "1234", "이순신", "lee@test.com");
		MemberBean m2 = new MemberBean("son", "5678", "손흥민", "son@test.com");
		
		//두 개의 MemberBean객체를 ArrayList배열에 저장한다
		membersList.add(m1);
		membersList.add(m2);
		
		//request내장객체 영역에 ArrayList배열을 저장
		request.setAttribute("memlist", membersList);
		
	%>
	
		<%-- member3.jsp로 포워딩(재요청) 합니다. --%>
		<jsp:forward page="member3.jsp"/>
	
</body>
</html>