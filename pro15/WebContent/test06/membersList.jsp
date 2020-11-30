<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 외부 jar라이브러리파일을 불러와서 로딩시킬때 사용함 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 조회한 회원정보 출력 -->
<table align="center" border="1">
	<tr align="center" bgcolor="lightgreen">
		<td width="7%"><b>아이디</b></td>
		<td width="7%"><b>비밀번호</b></td>
		<td width="7%"><b>이름</b></td>
		<td width="7%"><b>이메일</b></td>
		<td width="7%"><b>가입일</b></td>
	</tr>
	
	<c:choose>
		<c:when test="${membersList == null}">	<!-- requestScope.membersList에서 requestScope 생략가능 -->
			<tr>
				<td colspan="5">등록된 회원이 없습니다.</td> 
			</tr>
		</c:when>	
	</c:choose>
	
	<%-- 표현언어 EL로 변수에 접근하여 값을 얻어 출력 --%>
	<tr align="center">
		<td width="7%">${id}</td>
		<td width="7%">${pwd}</td>
		<td width="7%">${name}</td>
		<td width="7%">${email}</td>
		<td width="7%">${date}</td>
	</tr>
</table>