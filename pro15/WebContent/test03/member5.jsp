<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 외부 jar라이브러리파일을 불러와서 로딩시킬때 사용함 --%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%-- 
	<c:choose>태그
		-> 자바의 switch문의 기능을 수행함
		
		<c:choose>태그 형식
		
			<c:choose>
				<c:when test="조건식1"> 본문내용1 </c:when>
				<c:when test="조건식2"> 본문내용2 </c:when>
									.
									.
									.
				<c:when test="조건식n"> 본문내용n </c:when>
				<c:otherwise> 본문내용 </c:otherwise>
			</c:choose>
			
			*설명 : 첫번째 <c:when>태그의 조건식1을 체크해서 참이면 본문내용1을 수행하고
					거짓이면 다음 <c:when>태그의 조건식2를 체크해서 본문내용2를 수행한다.
					모든 <c:when>태그의 조건식에 만족하지 않으면 
					<c:otherwise>태그의 본문내용을 수행한다. 
--%>

<%--
	변수 선언시 사용하는 <c:set />태그 
	<c:set var="선언할 변수명" value="선언한 변수에 저장할 값" scope="선언한 변수를 저장할 내장객체 영역"/>
 --%>
<c:set var="id" value="hong" scope="page"/>
<c:set var="pwd" value="1234" scope="page"/>
<%-- <c:set var="name" value="${'홍길동'}" scope="page"/> --%>
<c:set var="age" value="${22}" scope="page"/>
<c:set var="height" value="${177}" scope="page"/>

<h1>회원 정보 출력 창</h1>
<table align="center" border="1">
	<tr align="center" bgcolor="aqua">
		<td width="7%"><b>아이디</b></td>
		<td width="7%"><b>비밀번호</b></td>
		<td width="7%"><b>이름</b></td>
		<td width="7%"><b>나이</b></td>
		<td width="7%"><b>키</b></td>
	</tr>
	
	<%-- 변수 name의 값이 null이거나 빈 문자열인지 체크한다. --%>
	<c:choose>
		<c:when test="${name==null}">
			<tr align="center">
				<td colspan="5">이름을 입력하세요!</td>
			</tr>
		</c:when>
		<%-- 변수 name에 값이 저장되어 있다면? 모든 회원정보 출력 --%>
		<c:otherwise>
			<tr align="center">
				<td width="7%"><b>${id}</b></td>
				<td width="7%"><b>${pwd}</b></td>
				<td width="7%"><b>${name}</b></td>
				<td width="7%"><b>${age}</b></td>
				<td width="7%"><b>${height}</b></td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>