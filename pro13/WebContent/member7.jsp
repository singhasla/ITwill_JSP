<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//request객체 영역에 인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("UTF-8");
	%>
	
	<%-- 
		회원가입창(memberForm.html)에서 입력받은 정보들을
		request영역에서 꺼내와서 MemberBean객체의 각 변수에 저장할 때..
		<input>태그의 name속성값과 MemberBean클래스의 각 변수명이 모두 동일 하면..
		모든 setter메소드가 호출되어 자동으로 memberBean객체의 각 변수에 저장된다.
	 --%>
	
	<jsp:useBean id="m" class="sec01.ex01.MemberBean" scope="page"></jsp:useBean>
	
	<jsp:setProperty name="m" property="*"/>
	
	
	<table align="center" width="100%">
		<tr align="center" bgcolor="#99ccff">
			<td width="7%">아이디</td>
			<td width="7%">비밀번호</td>
			<td width="5%">이름</td>
			<td width="11%">이메일</td>
			<td width="5%">가입일</td>
		</tr>

		
	<%-- <jsp:useBean>액션태그로 생성한 MemberBean객체의 getter메소드를 호출하여 반환된 변수의 값을 출력 --%>
		<tr align="center">
			<!-- MemberBean객체의 getId()메소드를 호출하여 id변수값을 반환받아 출력 -->
			<td><jsp:getProperty name="m" property="id"/></td>
			<td><jsp:getProperty name="m" property="pwd"/></td>
			<td><jsp:getProperty name="m" property="name"/></td>
			<td><jsp:getProperty name="m" property="email"/></td>
			<td><jsp:getProperty name="m" property="joinDate"/></td>
		</tr>	
		
		
		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>
</body>
</html>