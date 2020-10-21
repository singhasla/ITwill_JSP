<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JspWriter객체의 out참조변수</title>
</head>
<body>
	<%
		int a = 10, b = 5;
	%>
	
	<h2>JspWriter객체의 out참조변수 미사용!! 출력의 불편함</h2>
	<%
		if(a == 10){
	%>
		<%=a + "을 가진 변수는 a변수입니다." %>
	<%
		} else if(b == 10){
	%>
		<%=b + "을 가진 변수는 b변수입니다." %>
	<%		
		}
	%>
	
	<hr>
	
	<h2>JspWriter객체의 out참조변수 사용!!</h2>
	<%
		if(a == 10){
			out.print(a + "을 가진 변수는 a변수입니다.");
		}else if(b==10){
			out.print(b + "을 가진 변수는 b변수입니다.");
		}
	%>
</body>
</html>