<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>login3.html의 요청을 받아 클라이언트의 웹브라우저에 응답해주는 result3.jsp페이지</h1>
	<%
		// 1. login3.html에서 입력한 아이디와 비밀번호가 한글이 존재하면 한글이 깨지므로
		//		request내장객체 영역에 인코딩방식을 UTF-8방식으로 지정하자.
		//한글처리
		request.setCharacterEncoding("utf-8");
	
		// 2. login3.html에서 입력하여 요청한 요청값 얻기
		//		request내장객체 영역에서 꺼내오기
		//	방법) request객체.getParamter("<input태그의 name속성값>") 반환값 -> 입력한 값을 문자열로 받는다
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
	%>
		<!-- 3. 한걸음 더 나아가 스크립틀릿 기호 안에 자바코드를 사용해 ID가 정상적으로 입력되었는지 체크후
				정상입력 여부에 따라 동적으로 다른 결과를 출력하도록 구현하자.
		 -->
	<%
		//아이디를 입력하지 않았다면?
		if(user_id == null || user_id.length() == 0){
	%>
		아이디를 입력하세요. <br>
		<a href="/pro12/result3.html">로그인하기</a>
	<%
		}else{	//아이디를 입력했다면?
			
			if(user_id.equals("admin")){
	%>
				<h1>관리자로 로그인 했습니다.</h1>
				<form action="">
					<input type="button" value="회원정보 수정하기">
					<input type="button" value="회원정보 삭제하기">
				</form>
	<%
			} else {	//일반 사용자 아이디를 입력했을 경우?
	%>
				<h1>환영합니다. <%=user_id %>님!!!</h1>
	<%
			}
	%>
			<h1>환영합니다. <%= user_id%>님!!!</h1>
	<%
		}
	%>
		
</body>
</html>