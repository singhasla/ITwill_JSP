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

<%-- 
	<c:if test="${조건식}" var="조건식에 만족하면 true를 저장할 변수명" scope="변수를 저장할 내장객체 영역의 종류">
		조건식에 만족하면 실행할 코드
	</c:if> 
--%>

<%-- 조건식이 만족하면 --%>
<c:if test="${true}">
	<h1>항상 참입니다.</h1>
</c:if>

<c:if test="${11 == 11}">
	<h1>두 값은 같습니다.</h1>
</c:if>
<c:if test="${11 != 21}">
	<h1>두 값은 같지 않습니다.</h1>
</c:if>
<c:if test="${(id=='hong') && (name=='홍길동')}">
	<h1>아이디는 ${id}이고, 이름은 ${name}입니다.</h1>
</c:if>
<c:if test="${age==22}">
	<h1>${name}의 나이는 ${age}살입니다.</h1>
</c:if>
<c:if test="${height>=170}">
	<h1>${name}의 키는 170보다 큽니다.</h1>
</c:if>
