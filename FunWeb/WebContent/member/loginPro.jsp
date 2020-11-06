<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//1. 한글처리
	request.setCharacterEncoding("utf-8");

	//2. login.jsp에서 입력한 id, pw 얻기
	String id = request.getParameter("id");
	String passwd = request.getParameter("pass");
	
	//3. 입력한 아이디와 비밀번호가 DB에 존재하는지 비교하는 DB작업을 위해 MemberDAO객체 생성 후
	//	userCheck(String id, String passwd)메소드 호출시...
	//	입력한 아이디와 비밀번호 전달
	MemberDAO memberdao = new MemberDAO();
	
	
	int check = memberdao.userCheck(id, passwd);
	/*
		int check =	1	-> 아이디 O , 비밀번호 O
					0	-> 아이디 O , 비밀번호 X
					-1	-> 아이디 X
	*/
	if(check == 1){
		
		//세션영역에 입력한 아이디를 세션값으로 저장
		session.setAttribute("id", id);
		//리다이렉트 방식으로 메인페이지 index.jsp 재요청(포워딩)
		response.sendRedirect("../index.jsp");
		
	} else if(check == 0){
%>
		<script>
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
<%
	} else{
		%>
		<script>
			alert("아이디가 틀리거나 없습니다.");
			history.go(-1);
		</script>
<%		
	}
	
%>