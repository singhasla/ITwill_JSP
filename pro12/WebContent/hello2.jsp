<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
 <%-- 
	선언문을 이용해 name변수 선언후 이순신 저장
	getName()을 선언합니다. -> name변수에 저장된 값 반환
 --%>
 
 <%!
 	String name = "이순신";
 	public String getName(){
 		return name;
 	}
 %>

 <%-- 페이지 흐름 :
 
 	순서1.
 	 클라이언트가 웹브라우저 주소창에 주소를 입력해서 hello2.jsp페이지를 요청한다.
 	 요청할 주소 -> http://localhost:8080/pro12/hello2.jsp?age=22
 	 
 	순서2.
 	 요청을 받은 hello2.jsp서버페이지에서 request객체 메모리에 저장되어 있는 요청한 age값을 얻는다.
 	 
  --%>
  
  <%-- 스크립틀릿 기호 내부에 자바코드 이용 --%>
  <% String age = request.getParameter("age"); %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!-- 표현식을 이용해 전송된 나이를 클라이언트의 웹브라우저로 출력(응답)함. -->
	<h1>안녕하세요 <%= getName() %>님!! </h1>
	<h1>나이는 <%= age %>살 입니다. </h1>
</body>
</html>