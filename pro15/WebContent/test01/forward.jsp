<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//회원가입창(memberForm1.jsp)에서 요청한 request내장객체영역에
	//추가로 새로운 주소정보를 수동으로(직접) 바인딩(저장)합니다.
	request.setAttribute("address", "서울시 강남구");

%>

<%-- member2.jsp로 포워딩 --%>
<jsp:forward page="member2.jsp"/>
