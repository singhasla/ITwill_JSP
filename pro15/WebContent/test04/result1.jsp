<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- empty 연산자를 이용해 ID를 입력하지 않았는지 판단(체크) --%>
	<c:if test="${empty param.userID}">
		아이디를 입력하세요<br>
		<a href="login.jsp">로그인 창</a>
	</c:if>
	<%-- ID를 정상적으로 입력한 경우? --%>
	<c:if test="${not empty param.userID}">
		<h1>환영합니다. <c:out value="${param.userID}"/>님!!!</h1>
	</c:if>
</body>
</html>