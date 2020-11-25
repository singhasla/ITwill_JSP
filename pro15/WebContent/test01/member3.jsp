<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    	//한글처리
    	request.setCharacterEncoding("UTF-8");

%>
    <%--
    	입력한 회원정보들을 request내장객체 영역에서 모두 꺼내어서
    	MemberBean객체의 각 객체(인스턴스) 변수에 저장
     --%>
     
<jsp:useBean id="m" class="sec01.ex01.MemberBean"/>
<jsp:setProperty property="*" name="m"/>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<tr align="center" bgcolor="#99ccff">
			<td width="20%"><b>아이디</b></td>
			<td width="20%"><b>비밀번호</b></td>
			<td width="20%"><b>이름</b></td>
			<td width="20%"><b>이메일</b></td>
		</tr>

		<%-- 표현식 <%=... 를 이용해 입력한 회원정보들을 MemberBean객체의 각 변수로부터 꺼내와 출력 --%>
		<tr align="center">
			<td width="20%"><b><%=m.getId() %></b></td>
			<td width="20%"><b><%=m.getPwd() %></b></td>
			<td width="20%"><b><%=m.getName() %></b></td>
			<td width="20%"><b><%=m.getEmail() %></b></td>
		</tr>
		
		<%-- 표현언어 ${ }를 이용해 입력한 회원정보들을 얻어오는데... 
				MemberBean객체의 각 객체변수명(속성명)을 이용하여 얻어 출력	--%>
		<tr align="center">
			<td width="20%"><b>${m.id}</b></td>		<%-- 액션태그의 id속성명.변수명 --%>
			<td width="20%"><b>${m.pwd}</b></td>
			<td width="20%"><b>${m.name}</b></td>
			<td width="20%"><b>${m.email}</b></td>
		</tr>
		
		
	</table>
</body>
</html>