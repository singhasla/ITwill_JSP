<%@page import="sec01.ex01.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	
		/*
			주제 :
					<c:forEach>태그를 이용해 ArrayList배열에 저장된 회원정보를 얻어 출력해보자.
					<c:forEach>태그를 사용하면 ArrayList배열에 저장된 MemberBean객체를 쉽게 얻어 그 정보를 출력할 수 있다.
		*/
		
		List membersList = new ArrayList();
					
		//3명의 회원정보가 들어 있는 MemberBean객체를 생성 후 각각 ArrayList배열에 추가하여 저장
		membersList.add(new MemberBean("son","1234","손흥민","son@test.com"));
		membersList.add(new MemberBean("ki","5678","기성용","ki@test.com"));
		membersList.add(new MemberBean("park","9012","박지성","park@test.com"));
	%>

	<%-- 표현언어에서 사용할 수 있도록 <c:set>태그를 이용해 변수를 선언하고 변수에 ArrayList배열을 저장 --%>
	<c:set var="mlist" value="<%=membersList%>"/>
	
	<br>
	
	<h1>회원 정보 출력 창</h1>
	<table align="center" border="1">
		<tr align="center" bgcolor="aqua">
			<td width="7%"><b>아이디</b></td>
			<td width="7%"><b>비밀번호</b></td>
			<td width="7%"><b>이름</b></td>
			<td width="7%"><b>이메일</b></td>
		</tr>
	
	<%-- membersList에 저장된 MemberBean객체(회원) 갯수만큼 
		 반복변수 i를 0부터 1씩 증가시키면서 forEach문을 실행한다 --%>
	<c:forEach var="i" begin="0" end="2" step="1">
		<tr align="center">
			<%-- 반복변수 i에 저장된 배열의 인덱스 위치값을 이용해 MemberBean객체를 얻어 출력 --%>
			<td>${mlist[i].id}</td>
			<td>${mlist[i].pwd}</td>
			<td>${mlist[i].name}</td>
			<td>${mlist[i].email}</td>
		</tr>
	</c:forEach>
	
	<Br>
	
	<%-- items속성을 이용해서 더 간단히... --%>	
	<c:forEach var="m" items="${mlist}">
		<tr align="center">
			<td>${m.id}</td>
			<td>${m.pwd}</td>
			<td>${m.name}</td>
			<td>${m.email}</td>
		</tr>
	</c:forEach>
	
	</table>
</body>
</html>