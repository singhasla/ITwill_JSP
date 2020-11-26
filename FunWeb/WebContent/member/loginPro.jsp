<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//1.한글처리(인코딩방식 UTF-8로 request객체에 설정)
	request.setCharacterEncoding("UTF-8");
	
	//2.login.jsp에서 입력한 아이디 비밀번호 얻기 (요청한 값 얻기)
	String id = request.getParameter("id");
	String passwd = request.getParameter("pass");
	
	System.out.println(id + "," + passwd);
	
	
	//3.입력한 아이디와 비밀번호가 DB에 존재 하는지 비교 하는 DB작업을 위해 MemberDAO객체 생성후
	//userCheck(String id, String passwd)메소드 호출시......
	//입력한 아이디와 비밀번호 전달!
	MemberDAO memberdao = new MemberDAO();
	
	//check =  1 -> 아이디, 비밀번호 동일
	//check =  0 -> 아이디 동일 , 비밀번호 틀림
	//check =  -1 -> 아이디 틀림
	int check = memberdao.userCheck(id,passwd);
	
	if(check == 1){
		
		//세션영역에  입력한 아이디를  세션값으로 저장
		session.setAttribute("id", id);
		//리다이렉트 방식으로 메인페이지 index.jsp 재요청(포워딩) 하여 이동
		response.sendRedirect("../index.jsp");
		
	}else if(check == 0){
%>
		<script>
			alert("비밀번호 틀림");
			history.back();
		</script>
<%		
	}else{
%>
		<script>
			alert("아이디 없음");
			history.go(-1);
		</script>
<%	
	}
%>




