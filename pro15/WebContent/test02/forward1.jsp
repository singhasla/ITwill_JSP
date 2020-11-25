<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//주제 : request, session, application 내장객체 영역에 속성이름과 값을 쌍으로 묶어서 저장한 후
		//			다른 JSP페이지에 전달할 수 있다.
		//			표현 EL언어를 사용하면 자바코드를 사용하지 않고 각 내장객체에 저장된 값을 얻어 바로 출력할 수 있다
		//-> 각 내장객체에 바인딩(저장)된 값을 얻어서 EL표현언어로 출력하자
		
		//첫번째 JSP페이지인 forward1.jsp페이지 요청시
		//requestm session, application 내장객체영역에 회원정보들을 수동으로 각각 저장한 후
		//다시 member1.jsp를 재요청(포워딩)한다.
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//request내장객체 메모리에 접근하여 값을 바인딩 함
		request.setAttribute("id", "hong");
		request.setAttribute("pwd", "1234");
		
		//session내장객체 메모리에 접근하여 값을 바인딩 함
		session.setAttribute("name", "홍길동");
		
		//application내장객체 메모리에 접근하여 값을 바인딩 함
		application.setAttribute("email", "hong@test.com");
		
	%>
	
		<%-- member1.jsp로 포워딩(재요청) 합니다. --%>
		<jsp:forward page="member1.jsp"/>
	
</body>
</html>