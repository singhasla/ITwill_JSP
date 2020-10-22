<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    errorPage="addException.jsp"%>	<!-- errorPage="" 현재 페이지에서 예외 발생시 예외를 처리할 JSP페이지를 지정한다 -->

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//add.html에서 입력받은 자연수를 request메모리에서 꺼내와 얻기
	int num = Integer.parseInt(request.getParameter("num"));

	//합을 저장할 변수
	int result=0;
	
	//연산과정
	for(int i=1; i<=num;i++){
		result += i;
	}
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>합계 구하기</h2>
	<h1>1부터 <%=num %>까지의 합은 <%=result %>입니다.</h1>
	
</body>
</html>