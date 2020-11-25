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
	%>
	
	<form action="result2.jsp" method="post">
		아이디: <input type="text" name="userID"/> <br>
		비밀번호: <input type="password" name="userPW"/> <br>
		<input type="submit" value="로그인"/>
		<input type="reset" value="다시 입력"/>
	</form>
</body>
</html>