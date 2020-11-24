<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 외부 jar라이브러리파일을 불러와서 로딩시킬때 사용함 --%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%--
	변수 선언시 사용하는 <c:set />태그 
	<c:set var="선언할 변수명" value="선언한 변수에 저장할 값" scope="선언한 변수를 저장할 내장객체 영역"/>
 --%>
<c:set var="id" value="hong" scope="page"/>
<c:set var="pwd" value="1234" scope="page"/>
<c:set var="name" value="${'홍길동'}" scope="page"/>
<c:set var="age" value="${22}" scope="page"/>
<c:set var="height" value="${177}" scope="page"/>

<%-- 변수 age와 height를 page내장객체 영역에서 제거하기 --%>
<c:remove var="age"/>
<c:remove var="height"/>

<table align="center" border="1">
	<tr align="center" bgcolor="lightgreen">
		<td width="7%"><b>아이디</b></td>
		<td width="7%"><b>비밀번호</b></td>
		<td width="7%"><b>이름</b></td>
		<td width="7%"><b>나이</b></td>
		<td width="7%"><b>키</b></td>
	</tr>
	
	<%-- 표현언어 EL로 변수에 접근하여 값을 얻어 출력 --%>
	<tr align="center">
		<td width="7%">${id}</td>
		<td width="7%">${pwd}</td>
		<td width="7%">${name}</td>
		<td width="7%">${age}</td>
		<td width="7%">${height}</td>
	</tr>
</table>