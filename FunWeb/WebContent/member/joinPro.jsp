<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//1. join.jsp(회원가입페이지)에서 입력한 가입할 내용은 모두 request내장객체에 저장되어 있다.
	//		저장된 데이터들 중 한글이 존재하면 request내장객체에서 꺼내올 때 한글이 깨지므로
	//		인코딩 방식을 UTF-8 방식으로 설정
	//	한글처리
	request.setCharacterEncoding("utf-8");
%>

	<%-- 2. join.jsp에서 입력한 회원정보들을 request객체에서 꺼내와서 MemberBean객체의 각 변수에 저장
			참고. Action태그 사용
	 --%>
	 <jsp:useBean id="memberbean" class="member.MemberBean"/>
	 <jsp:setProperty property="*" name="memberbean"/>
	 
	<%-- 3. DB에 회원추가(INSERT)를 위해 MemberDAO객체 Action태그로 생성하여
			MemberDAO객체의 insertMember메소드 호출시... MemberBean객체를 매개변수로 전달하여 작업함.
			참고. MemberDAO클래스 내부에 insertMember메소드를 만들어야 호출할 수 있음.
	--%>
	<jsp:useBean id="memberdao" class="member.MemberDAO"></jsp:useBean>
	<%
		memberdao.insertMember(memberbean);
	
		// 4. 회원가입에 성공하면? login.jsp로 포워딩(재요청)
		response.sendRedirect("login.jsp");
	%>