<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--JSTL라이브러리 태그들을 사용하기 위한 선언 --%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<p class="cls1">회원정보</p>
		<table align="center" border="1">
			<tr align="center" bgColor="aqua">
				<td width="7%" ><b>아이디</b></td>
				<td width="7%" ><b>비밀번호</b></td>
				<td width="7%" ><b>이름</b></td>
				<td width="7%" ><b>이메일</b></td>
				<td width="7%" ><b>가입일</b></td>
			</tr>
<c:choose>
<%--request내장객체에서 ArrayList배열을 꺼내오지 못하면? --%>
	<c:when test="${requestScope.membersList == null }">
			<tr>
				<td cospan="5">
					<b>등록된 회원이 없습니다.</b>
				</td>
			</tr>
	</c:when>
<%--request내장객체영역에서 조회한 회원정보들을 저장하고 있는 ArrayList배열을 꺼내온다면 --%>
	<c:when test="${membersList != null}">
		<c:forEach   var="mem"   items="${membersList}">
			<tr align="center">
				<td>${mem.id}</td>
				<td>${mem.pwd}</td>
				<td>${mem.name}</td>
				<td>${mem.email}</td>
				<td>${mem.joinDate}</td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>		
		</table>
		
		<a href="#"><p class="cls2">회원 가입하기</p></a>
		
		
		
</body>
</html>




