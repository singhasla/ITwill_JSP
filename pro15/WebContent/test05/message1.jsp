<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위한 선언 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- JSTL fmt라이브러리에 속한 태그들을 사용하기 위한 선언 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
	<%-- <fmt:setLocale> 태그를 이용해 표시할 locale(언어)를 영어로 지정한다. --%>
 	<fmt:setLocale value="en_US"/>
	
	<%-- <fmt:setLocale> 태그를 이용해 표시할 locale(언어)를 한글로 지정한다. --%>
<%-- 	<fmt:setLocale value="ko_KR"/> --%>
	
	<h1>
		회원정보<br><br>
		
		<%-- <fmt:bundle>태그를 이용해 resource패키지 아래의 member로 시작하는 
			properties file의 내용을 읽어올 수 있다. --%>
		<fmt:bundle basename="resource.member">
			<%-- <fmt:message>태그의 key속성에 properties 파일에 작성된 key값을 지정하여
				value값을 불러와 출력할 수 있다. --%>
			이름 : <fmt:message key="mem.name"/>	<br>
			주소 : <fmt:message key="mem.address"/>	<br>
			직업 : <fmt:message key="mem.job"/>	<br>
		</fmt:bundle>
		
	</h1>
</body>
</html>