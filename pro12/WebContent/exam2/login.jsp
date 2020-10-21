<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 현재 login.jsp화면에서 아이디와 비밀번호를 입력한 후 현재 자신의 페이지 login.jsp로 로그인처리 요청 --%>

	<form action="login.jsp" method="post">
	
		아이디 : <input type="text" name="id"> <br>
		비밀번호 : <input type="text" name="pw"> <br>
	
		<input type="submit" value="로그인 요청"> &nbsp;&nbsp;
		<input type="reset" value="로그인 취소">
	</form>
	<%
		//<form>태그에서 요청하는 방식이 POST방식일때..
		if(request.getMethod().equals("POST")){
			// 1. 한글처리
			request.setCharacterEncoding("UTF-8");
			
			// 2. 요청한 값 얻기
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
		// 가정. DB에 저장되어 있는 아이디 -> "master"
		//		 DB에 저장되어 있는 비밀번호 -> "1111"
			
			// 3. DB에 저장되어 있는 "master"라는 아이디값과
			if("master".equals(id)){ //		login.jsp에서 입력한 아이디값이 동일하면
				
				//DB에 저장되어 있는 "1111"라는 비밀번호값과
				if("1111".equals(pw)){//아이디가 동일하고 입력한 비밀번호가 동일하면
					
					//session내장객체 메모리영역에 세션값 저장
					session.setAttribute("id", id);
					//index.jsp메인페이지를 재요청하여 이동
					response.sendRedirect("index.jsp");
					
				} else { //아이디는 동일하나 비밀번호가 "1111"와 동일하지 않다면
					%>	<script> window.alert("비밀번호가 틀립니다");</script>	<%
				}
				
			} else {	//아이디가 "master"와 동일하지 않다면
				
				//DB에 저장되어 있는 "1111"라는 비밀번호값과
				if("1111".equals(pw)){//아이디가 동일하고 입력한 비밀번호가 동일하면
					%>	<script> window.alert("아이디가 틀립니다");</script>	<%
				} else { //아이디와 비밀번호가 전부 동일하지 않다면
					%>	<script> window.alert("아이디와 비밀번호를 다시 입력해주세요");</script>	<%
				}
			}
		
		} else {	//"POST"방식이 아니라 "GET"방식이라면
			request.setCharacterEncoding("UTF-8");
		}
	
		
	%>
</body>
</html>
