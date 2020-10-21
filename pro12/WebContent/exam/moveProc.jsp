<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 1. 한글 처리
	request.setCharacterEncoding("utf-8");

	// 2. 요청한 값 얻기
	String choice = request.getParameter("gender");
	
	
	// 3. 요청한 값을 이용해 포워딩(재요청)
	if(choice.equals("male")){
		//남성 전문 페이지로 재요청해 이동
		response.sendRedirect("man.html");
	} else {
		//여성 전문 페이지로 재요청해 이동
		response.sendRedirect("woman.html");
	}
%>