<%@page import="java.util.Date"%>
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
	<h1>fmt포매팅 라이브러리에 속한 </h1>
	<hr>
		<h2>fmt:formatNumber태그를 이용한 숫자 포매팅 예제</h2>
		
		<c:set var="price" value="100000000"/>
		<c:set var="per" value="50"/>
		
		<fmt:formatNumber value="${price}" type="currency"/><br> 	<%-- ￦100,000,000 --%>
		<fmt:formatNumber value="${price}" type="number"/><br> 	<%-- 100,000,000 --%>
	
		<fmt:formatNumber value="${price}" type="currency" var="priceNumber"/><br>
		<c:out value="${priceNumber}"/><br><br>						<%-- ￦100,000,000 --%>
		
		<h3>통화로 표현시 : <%-- type="currency"로 작성하면  ￦100,000,000 로 표시된다. --%> </h3>
			<%-- currencySymbol=" " --%>
			<%-- groupingUsed="true" : 숫자 천 단위마다 콤마(,)표시함. 설정하지 않으면 기본값은 true --%>
			<fmt:formatNumber value="${price}" type="currency"/><br> 											<%-- ￦100,000,000 --%>
			<fmt:formatNumber value="${price}" type="currency" currencySymbol="$" groupingUsed="false"/><br><br><%-- $100000000 --%>
		
		<h3>퍼센트로 표현시 : <%-- type="percent"로 작성하면  5,000% 로 표시된다. --%> </h3>
			<fmt:formatNumber value="${per}" type="percent"/><br> 					<%-- 5,000% --%>
			<fmt:formatNumber value="${per}" type="percent" groupingUsed="false"/> 	<%-- 5000% --%>
		
		<hr>
		
		<h2>fmt:formatDate태그를 이용한 날짜 포매팅 예제</h2>
			<c:set var="now" value="<%= new Date() %>"/>
			<c:out value="${now}"/>		 										<%-- Thu Nov 26 11:19:00 KST 2020 --%>
			
		<h3>[type]</h3>
			<fmt:formatDate value="${now}" type="date"/><br> 					<%-- 2020. 11. 26 --%>
	 		<fmt:formatDate value="${now}" type="date" dateStyle="short"/><br> 	<%-- 20. 11. 26 --%>
	 		<fmt:formatDate value="${now}" type="date" dateStyle="full"/><br> 	<%-- 2020년 11월 26일 목요일 --%>
	 		<fmt:formatDate value="${now}" type="time"/><br> 					<%-- 오전 11:19:00 --%>
	 		<fmt:formatDate value="${now}" type="both"/><br> 					<%-- 2020. 11. 26 오전 11:19:00 --%>
	 		<fmt:formatDate value="${now}" type="both" 
	 						dateStyle="full" timeStyle="full"/><br> 	 		<%-- 2020년 11월 26일 목요일 오전 11시 19분 00초 KST --%>
 		<h3>[pattern]</h3>
 			<fmt:formatDate value="${now}" pattern="YYYY/MM/dd hh:mm:ss"/><br> 	<%-- 2020/11/26 11:29:32 --%>
 			
 		<h3>[뉴욕 시간대로 변경하여 출력]</h3>
 			<fmt:timeZone value="America/New York">
	 			뉴욕 현재시간 :	
	 			<fmt:formatDate value="${now}" type="both" dateStyle="full" timeStyle="full"/><br>
 			</fmt:timeZone>
</body>
</html>