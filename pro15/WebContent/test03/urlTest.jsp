<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 컨텍스트 주소 이름을 얻어 <c:set>태그로 선언한 contextPath변수에 저장 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

	<a href="${contextPath}/test01/member1.jsp">회원정보출력</a>
	
<%-- ------------------------------------------------------------------------------- --%>
<%-- ------------------------------------------------------------------------------- --%>
	
<%-- <c:url>태그로 이동할 페이지 주소를 설정한다 --%>
<c:url var="url1" value="/test01/member1.jsp">
	<c:param name="id" value="hong"/>
	<c:param name="pwd" value="1234"/>
	<c:param name="name" value="홍길동"/>
	<c:param name="email" value="hong@test.com"/>
</c:url>

	<a href="${url1}">회원정보출력</a>