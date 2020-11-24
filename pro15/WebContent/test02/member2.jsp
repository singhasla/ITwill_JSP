<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    	//한글처리
    	request.setCharacterEncoding("UTF-8");


%>
    
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
		
		<%-- 방법2. 표현언어 ${ }으로 request내장객체에 접근해서 저장된 값을 얻어 회원정보 출력 --%>
		<%--	requestScope.			<-- request내장객체 메모리에 접근
				requestScope.member		<--	request내장객체 메모리에 저장된 new MemberBean(...);객체 얻기
				requestScope.member.id 	<-- new MemberBean객체의 getId()메소드 호출하여 id변수값 리턴받기
		 --%>
		<tr align="center">
			<td width="20%"><b>${requestScope.member.id}</b></td>
			<td width="20%"><b>${requestScope.member.pwd}</b></td>
			<td width="20%"><b>${requestScope.member.name}</b></td>
			<td width="20%"><b>${requestScope.member.email}</b></td>
		</tr>
	</table>
</body>
</html>