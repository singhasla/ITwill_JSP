<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		//두번째 JSP인 member1.jsp입니다
		
    	//한글처리
    	request.setCharacterEncoding("UTF-8");

		//forward1.jsp에서 재요청(포워딩)한 member1.jsp페이지에서
		//각 내장객체 영역에 접근하여 값을 꺼내올 수 있다.
		//방법1. 자바코드 사용 =-> getAttribute()메소드 사용
		//방법2. 표현언어에서 자바코드를 사용하지 않고 ${ } 사용
		
		//방법1. 각 내장객체에 바인딩된 속성값들을 getAttribute()메소드를 이용해 가져온다
		String id = (String)request.getAttribute("id");
		String pwd = (String)request.getAttribute("pwd");
		
		String name = (String)session.getAttribute("name");
		
		String email = (String)application.getAttribute("email");
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
		
		<%-- 방법1. 표현식으로 회원정보 출력 --%>
		<tr align="center">
			<td width="20%"><b><%=id %></b></td>
			<td width="20%"><b><%=pwd %></b></td>
			<td width="20%"><b><%=name %></b></td>
			<td width="20%"><b><%=email %></b></td>
		</tr>
		
		<%-- 방법2. 표현언어 ${ }으로 각 내장객체에 접근해서 저장된 값을 얻어 회원정보 출력 --%>
		<tr align="center">
			<td width="20%"><b>${param.id}</b></td>
			<td width="20%"><b>${requestScope.pwd}</b></td>
			<td width="20%"><b>${sessionScope.name}</b></td>
			<td width="20%"><b>${applicationScope.email}</b></td>
		</tr>
	</table>
</body>
</html>