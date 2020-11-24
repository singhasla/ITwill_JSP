<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL라이브러리에 속해 있는 core라이브러리에 속해있는 태그들 사용을 위한 선언 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- c:set태그를 이용해 pageContext내장객체의 컨텍스트 이름을 얻어 변수contetPath에 미리 저장 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="result.jsp">
		아이디: <input type="text" size="20"> <br>
		비밀번호: <input type="password" size="20"> <br>
		<input type="submit" value="로그인">
		<input type="reset" value="다시입력">
	</form>
	<br><br>
	
	<%-- 
		먼저 JSP에서 <a>태그를 이용해 다른 페이지로 이동하는 방법이다.
		지금까지는 표현언어 ${ }로 pageContext.request.contextPath 같은 긴 속성을 그대로 사용 했는데,
		<c:set >태그를 이용하면 긴 이름의 속성이나 변수를 줄여서 사용할 수 있다.
		
		원래 문장 => 	<a href="${pageContext.request.contextPath}/test03/memberForm.jsp">회원등록하러가기</a>	
	 --%>
	 
	 <%-- 현재 로그인창에서 회원가입창으로 이동할 때 미리 <c:set>태그를 이용해 줄여서 사용함. 가독성 좋아짐 --%>
	<a href="${contextPath}/test03/memberForm.jsp">회원등록하러가기</a>
</body>
</html>