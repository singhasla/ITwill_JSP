<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 외부 jar라이브러리파일을 불러와서 로딩시킬때 사용함 --%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");
%>



<h1>회원 정보 출력 창</h1>
<table align="center" border="1">
	<tr align="center" bgcolor="aqua">
		<td width="7%"><b>아이디</b></td>
		<td width="7%"><b>비밀번호</b></td>
		<td width="7%"><b>이름</b></td>
		<td width="7%"><b>이메일</b></td>
	</tr>
	
	<c:choose>
		<%-- memberForm.jsp에서 입력한 회원정보들은 request내장객체영역에 저장되어 있기 때문에,
				조건식을 작성할 때 request내장객체영역에 접근하여 입력한 id가 존재하지 않다면? --%>
		<c:when test="${empty param.id}">
			<tr align="center">
				<td colspan="4">이름을 입력하세요!</td>
			</tr>
		</c:when>
		<%-- 아이디를 입력했다면? 입력한 회원정보 출력 --%>
		<c:otherwise>
			<tr align="center">
				<td width="7%"><c:out value="${param.id}"/></td>
				<td width="7%"><c:out value="${param.pwd}"/></td>
				<td width="7%"><c:out value="${param.name}"/></td>
				<td width="7%"><c:out value="${param.email}"/></td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>