<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 
 <%-- jsp페이지에서 java.lang패키지는 자동임포트 되기 때문에 import하지 않아도 된다. --%>   
 <%!
 	String name = "이순신";
 	public String getName(){
 		return name;
 	}
 %>

 <%-- 페이지 흐름 :
 
 	순서1.
 	 클라이언트가 웹브라우저 주소창에 주소를 입력해서 hello3.jsp페이지를 요청한다.
 	 요청할 주소 -> http://localhost:8080/pro12/hello3.jsp?age=22
 	 
 	순서2.
 	 요청을 받은 hello3.jsp서버페이지에서 request객체 메모리에 저장되어 있는 요청한 age값을 얻는다.
 	 
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
	
	
	<h1>키는 <%= 180 %>cm입니다.</h1>
	<h1>나이+10은 <%= Integer.parseInt(age)+10 %>살입니다.</h1>
	
	<%--
		Integer클래스의 parseInt("숫자형태의 문자열") 호출하면 정수 숫자로 반환해준다.
		String클래스의 valueOf(숫자) -> 숫자를 문자열로 변환해서 반환해준다.
	 --%>
	
</body>
</html>