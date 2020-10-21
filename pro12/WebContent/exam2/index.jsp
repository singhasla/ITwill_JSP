<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to My Page</title>
</head>
<body>
	<h1>Welcome to My Page</h1>
	<%
		//login.jsp페이지에서 로그인에 성공했을 때
		//같은 웹브라우저에서 유지되는 session내장객체 메모리영역에 저장된 값을 얻어 변수에 저장
		String new_id = (String)session.getAttribute("id");
	
		//session영역에 세션값이 존재하면 로그인 화면으로 디자인
		//session영역에 세션값이 존재하지 않으면 로그아웃된 화면으로 디자인
		
		//DB에 저장된 master값이 session영역에 저장된 id값과 동일할 때 로그인 처리
		if("master".equals(new_id)){
	%>
		<%=new_id %>님 로그인중...<br>
		<a href="logout.jsp">logout</a>
		<a href="shop.jsp">쇼핑몰</a>
	<%
		} else {
	%>
			<%=new_id %>님 로그인중...<br>
			<a href="login.jsp">logout</a>
			<a href="shop.jsp">쇼핑몰</a>
		<%		
		}
	%>
</body>
</html>