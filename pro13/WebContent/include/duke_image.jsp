<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//include1.jsp의 param액션태그로 전달된 값들을
	//request내장객체 메모리 영역에서 꺼내오기
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");	//이름
	String imgName = request.getParameter("imgName");	//이미지명
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br><br>
	<h1>이름은 <%=name %>입니다.</h1>
	<br><br>
	<%=imgName %>
	<img src="./image/<%=imgName %>"/>
	
</body>
</html>