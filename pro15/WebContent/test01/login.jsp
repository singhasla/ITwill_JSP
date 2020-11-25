<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="\result.jsp">
		아이디: <input type="text" size="20" /> <br>
		비밀번호: <input type="password" size="20" /> <br>
		<input type="submit" value="로그인" /> <br>
		<input type="reset" value="다시 입력" /> <br> 
	</form>
	
	<%-- 1. 직접 컨텍스트 이름을 입력해서 요청하는 방식 --%>
	<a href="http://localhost:8080/pro15/test01/memberForm.jsp">회원가입</a> <Br><Br><Br>
	
	<%-- 2. login.jsp페이지를 요청하면 새로운 request메모리가 생생되면서 login.jsp를 요청한 전체 URL정보가 저장된다 
			request객체에서 요청한 전체 URL중에서 컨텍스트 경로만 얻기 위해
			request.getContextPath()메소드를 호출하면 된다														--%>
	<a href="<%=request.getContextPath()%>/test01/memberForm.jsp">회원가입</a> <Br><Br><Br>
	
	<%-- 3. jsp페이지에 자바코드를 사용하지 않기위해 EL표현언어에서 제공해주는
			pageContext내장객체의 속성인 request에는 HttpServletRequest객체가 저장되어 있기때문에
			request속성 하위의 HttpServletReauest객체의 contextPath속성을 호출하면
			request객체에서 요청한 전체 URL중에서 컨텍스트 경로만 얻을 수 있다.						--%>
	<a href="${pageContext.request.contextPath}/test01/memberForm.jsp">회원가입</a> <Br><Br><Br>
	
</body>
</html>