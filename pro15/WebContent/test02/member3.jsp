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
		
		<%-- 방법2. 표현언어 ${ }으로 request내장객체에 접근해서 ArrayList배열에 저장된 값을 얻어 회원정보 출력 
					배열의 0번째 인덱스 위치에 저장된 new MemberBean객체를 꺼내와
					객체의 각 변수의 값을 얻어 EL로 출력														--%>
		
		<tr align="center">
			<td width="20%"><b>${requestScope.memlist[0].id}</b></td>
			<td width="20%"><b>${requestScope.memlist[0].pwd}</b></td>
			<td width="20%"><b>${requestScope.memlist[0].name}</b></td>
			<td width="20%"><b>${requestScope.memlist[0].email}</b></td>
		</tr>
		<tr align="center">
			<td width="20%"><b>${requestScope.memlist[1].id}</b></td>
			<td width="20%"><b>${requestScope.memlist[1].pwd}</b></td>
			<td width="20%"><b>${requestScope.memlist[1].name}</b></td>
			<td width="20%"><b>${requestScope.memlist[1].email}</b></td>
		</tr>
	</table>
</body>
</html>