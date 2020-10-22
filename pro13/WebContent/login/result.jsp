<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		//login.jsp에서 입력한 아이디 얻기
		String userID = request.getParameter("userID");
		
		//조건식
		if(userID.length()==0){	//아이디를 입력하지 않았을 경우
			
			//디스패쳐 방식으로 login.jsp를 재요청해서 이동
			//RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			//dispatcher.forward(request, response);
		
			
			%>	<jsp:forward page="login.jsp" /> <%
		} 
		
	%>
		<!-- 아이디를 입력했을 경우 -->
		<h1>환영합니다. <%=userID %>님!!!</h1>
</body>
</html>