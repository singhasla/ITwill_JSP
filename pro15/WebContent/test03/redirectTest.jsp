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
	<%-- <c:redirect>태그를 이용해 회원정보를 전달받아 출력할 member1.jsp페이지로 
			리다이렉트 방식으로 포워딩 함 											
			포워딩 시 회원정보를 매개변수로 전달한다. 							--%>
	<c:redirect url="/test01/member1.jsp"> <%-- 리다이렉트방식으로 포워딩할 주소 설정 --%>
		<%-- 리다이렉트방식으로 포워딩할 페이지로 전달할 매개변수(값)을 설정함 --%>
		<c:param name="id" value="${'hong'}"/>
		<c:param name="pwd" value="${'1234'}"/>
		<c:param name="name" value="${'홍길동'}"/>
		<c:param name="email" value="${'hong@test.com'}"/>
	</c:redirect>
	
	<%
		/* response.sendRedirect("/test01/member1.jsp?id='hong'&pwd='1234'&name='홍길동'&email='hong@test.com'"); */
		
	%>
</body>
</html>