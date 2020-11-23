<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    	//한글처리
    	request.setCharacterEncoding("UTF-8");
%>

<%--
   	컬렉션 프레임워크에서 제공해주는 가변길이 배열 -> ArrayList객체 배열 생성
--%>
<jsp:useBean id="membersList" class="java.util.ArrayList"/>


<%--
   	입력한 회원정보들을 request내장객체 영역에서 모두 꺼내어서
   	MemberBean객체의 각 객체(인스턴스) 변수에 저장
--%>
     
<jsp:useBean id="m" class="sec01.ex01.MemberBean"/>
<jsp:setProperty property="*" name="m"/>


<%
	//자바코드로 새로운 회원정보를 저장시키기 위해 MemberBean객체의 생성자를 호출해서 객체 생성
	MemberBean m2 = new MemberBean("son", "1234", "손흥민", "son@test.com");

	//위 두개의 MemberBean객체들(m, m2)을  ArrayList가변길이 배열에 추가하여 저장
	membersList.add(m);
	membersList.add(m2);
%>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<tr align="center" bgcolor="#99ccff">
			<td width="20%"><b>아이디</b></td>
			<td width="20%"><b>비밀번호</b></td>
			<td width="20%"><b>이름</b></td>
			<td width="20%"><b>이메일</b></td>
		</tr>

		<%-- ArrayList배열의 0번째 인덱스 위치에 저장되어 있는 
				MemberBean객체를 꺼내와서 각 변수의 값을 얻어 출력 --%>
		<tr align="center">
			<td width="20%"><b>${membersList[0].id}</b></td>
			<td width="20%"><b>${membersList[0].pwd}</b></td>
			<td width="20%"><b>${membersList[0].name}</b></td>
			<td width="20%"><b>${membersList[0].email}</b></td>
		</tr>
		<%-- ArrayList배열의 1번째 인덱스 위치에 저장되어 있는 
				MemberBean객체를 꺼내와서 각 변수의 값을 얻어 출력 --%>
		<tr align="center">
			<td width="20%"><b>${membersList[1].id}</b></td>
			<td width="20%"><b>${membersList[1].pwd}</b></td>
			<td width="20%"><b>${membersList[1].name}</b></td>
			<td width="20%"><b>${membersList[1].email}</b></td>
		</tr>
		
		
	</table>
</body>
</html>