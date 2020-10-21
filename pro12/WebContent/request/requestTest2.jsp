<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>request내장객체 영역</title>
</head>
<body>
	<%
		//request객체 메모리영역에 들어 있는 currTime변수 값의 주소를 꺼내어서 저장하게 되는데
		//꺼낼 currTime변수가 없으므로 null값이 저장됨
		Date date1 = (Date)request.getAttribute("currTime");	//다운캐스팅
	%>
	
	현재 시간은 <%=date1 %>입니다. <br>
	
	<%
		//request내장객체 메모리영역 내부에 currTime변수를 선언하여 new Date()객체 값을 저장
		request.setAttribute("currTime", new Date());
	
		//request내장객체 메모리영역에 들어 있는 currTime변수 값을 꺼내어서 저장
		date1= (Date)request.getAttribute("currTime");		//object객체이므로 다운캐스팅
	%>
	
	현재 시간은 <%=date1 %>입니다. <br>
	
	<%
		//request내장객체 메모리영역 내부에 있는 currTime변수를 제거
		request.removeAttribute("currTime");
	
		//request내장객체 메모리영역 내부에 있는 currTime변수 값을 꺼내어서 저장
		date1= (Date)request.getAttribute("currTime");		//object객체이므로 다운캐스팅
	%>
	
	현재 시간은 <%=date1 %>입니다.
	
</body>
</html>