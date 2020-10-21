<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- requestTest1.jsp로부터 요청받은 데이터를 이용해 
		국어점수와 영어점수의 평균을 구해 클라이언트의 웹브라우저로 응답하는 페이지 --%>
		
	<%
		// 1. 한글 처리
		request.setCharacterEncoding("utf-8");
	
		// 2. 요청한 값 얻기
		double kor = Integer.parseInt(request.getParameter("kor"));
		double eng = Integer.parseInt(request.getParameter("eng"));
		
		// 3. 요청한 값을 이용해 응답할 값 마련
		double avg = (kor + eng) / 2;
	%>
	
	<%-- 4. 클라이언트의 웹브라우저로 응답(출력) --%>
	당신의 평균은 <%=avg %>입니다.
</body>
</html>