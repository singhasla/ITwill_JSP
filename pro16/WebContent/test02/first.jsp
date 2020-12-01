<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 
			첫번째 JSP에서 다운로드할 이미지 파일 이름을 두번째 JSP로 전달하도록
			first.jsp를 작성한다.
			
			다운로드할 파일 이름을 <input type="hidden">태그의 value속성의 값으로 설정해서
			result.jsp에 다운로드 요청한다.
	 --%>
	<form action="result.jsp" method="post">
		<input type="hidden" name="param1" value="login.png"/> <br>
		<input type="hidden" name="param2" value="board테이블.txt"/> <br>
		<input type="submit" value="다운로드">
	</form>
	 
</body>
</html>