<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isErrorPage="true"%>	<!-- isErrorPage="true" 다른 JSP페이지에서 예외 발생시 예외를 처리하는 페이지로 지정 -->
    
    <%-- 
    	페이지 지시자 태그의 isErrorPage속성을 true로 설정해
    	exception내장객체를 이용해서 발생한 ? 예외를 처리하도록 합니다.
    	이때 exception내장객체는 자바의 Exception클래스의 인스턴스입니다.
     --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	========== toString()메소드 호출한 결과 내용 ==========<br>
	<!-- exception내장객체를 사용한 예외처리를 한다 -->
	<h1><%=exception %></h1><!-- exception.toString()에 toSting()메소드 생략되어있음 -->
	
	========== getMessage()메소드 호출한 결과 내용 ==========<br>
	<!-- 예외가 발생하면 발생한 예외 메세지를 간략하게 얻고 싶을 때, getMessage()메소드 호출 -->
	<h1><%=exception.getMessage() %></h1>
	
	========== printStackTrace()메소드 호출한 결과 내용 ==========<br>
	<!-- 이클립스의 Console창에 예외 메세지를 상세히 출력한다 -->
	<h1><% exception.printStackTrace(); %></h1>
		
	<h3>숫자만 입력가능합니다. 다시 시도해 주세요.</h3>
	<a href="add.html">다시 입력하러 가기</a>
</body>
</html>