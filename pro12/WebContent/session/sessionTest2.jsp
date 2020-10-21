<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>여기는 sessionTest2.jsp페이지입니다.</h1>
	
	<%-- session내장객체 메모리 영역에 저장된 데이터를 꺼내올 때 getAttribute("저장된 변수명"); --%>
	<%=	session.getAttribute("sessionVal")%>	
	
	<%-- 
		결론 : 클라이언트 요청시 자동으로 생성되는 jsp페이지의 session영역은
				또다시 다른 jsp페이지 요청시.. 같은 웹브라우저가 닫기기 전까지는 session영역은 계속 유지된다.
	 --%>
</body>
</html>