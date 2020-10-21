<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	//session내장객체 메모리영역에 접근하여 젖아된 데이터를 모두 제거
	session.invalidate();
/*
	//session내장객체 메모리영역에 접근하여 저장된 데이터를 모두 제거
	session.removeAttribute("id");
*/
	//session값 제거 후 다시 index.jsp메인화면을 포워딩(재요청)해 이동
	response.sendRedirect("index.jsp");
%>