<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 클라이언트가 요청하는 디자인 페이지 --%>
	
	<form action="requestTest1_proc.jsp" method="post">
	
		국어점수 입력받기 : <input type="text" name="kor"> <br>
		영어점수 입력받기 : <input type="text" name="eng"> <br>
		<!-- 수학점수 입력받기 : <input type="text" name="math"> <br> -->
		
		<input type="submit" value="평균 요청"/>
	
	</form>
</body>
</html>