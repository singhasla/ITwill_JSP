<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    	//입력한 회원정보를 request내장객체 영역에서 얻어오기 위해
    	//getParameter()메소드를 호출해 가져와
    	//표현식 <%= 을 이용해 출력!
    	
    	//한글처리
    	request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
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
		
		<%-- request.getParameter()메소드로 가져온 입력한 회원정보를 표현식을 이용해 출력 --%>
		<tr align="center">
			<td width="20%"><b><%=id %></b></td>
			<td width="20%"><b><%=pwd %></b></td>
			<td width="20%"><b><%=name %></b></td>
			<td width="20%"><b><%=email %></b></td>
		</tr>
		
		<%-- EL표현언어 구문 영역 안에서 사용할 수 있는 param내장객체를 이용해 request내장객체 영역에 접근하여
				getParameter()메소드를 이용하지 않고 
				<input name="">속성값을 이용하여 입력한 회원정보를 바로 얻을 수 있다.						--%>
		<tr align="center">
			<td width="20%"><b>${param.id}</b></td>
			<td width="20%"><b>${param.pwd}</b></td>
			<td width="20%"><b>${param.name}</b></td>
			<td width="20%"><b>${param.email}</b></td>
		</tr>
	</table>
</body>
</html>