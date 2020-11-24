<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 외부 jar라이브러리파일을 불러와서 로딩시킬때 사용함 --%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="membersList" class="java.util.ArrayList"/>
<jsp:useBean id="membersMap" class="java.util.HashMap"/>

<%
	//해시맵에 '키'-'값' 을 한 쌍으로 묶어서 저장
	membersMap.put("id","park2");
	membersMap.put("pwd","4321");
	membersMap.put("name","박지성");
	membersMap.put("email","park2@test.com");

	//ArrayList배열에 MemberBean객체 2개 생성하여 저장
	membersList.add(new MemberBean("son","1234","손흥민","sontest@test.com"));
	membersList.add(new MemberBean("ki","5678","기성용","kitest@test.com"));
	
	//ArrayList배열을 -> 해시맵에 키-값을 한쌍으로 묶어서 저장
	membersMap.put("memList", membersList);
%>


<%-- 
		<c:set>태그를 이용해 HashMap에 저장된 ArrayList배열을 꺼내어서 변수에 저장하면
		ArrayList배열을 사용할 때 편리한 변수이름으로 사용할 수 있다.
 --%>
	<c:set var="mList" value="${membersMap.memList}"/> 

<table align="center" border="1">
	<tr align="center" bgcolor="lightgreen">
		<td width="7%"><b>아이디</b></td>
		<td width="7%"><b>비밀번호</b></td>
		<td width="7%"><b>이름</b></td>
		<td width="7%"><b>이메일</b></td>
	</tr>
	
	<%-- 표현언어 EL로 변수에 접근하여 박지성 정보를 얻어 출력 --%>
	<tr align="center">
		<td width="7%">${membersMap.id}</td>
		<td width="7%">${membersMap.pwd}</td>
		<td width="7%">${membersMap.name}</td>
		<td width="7%">${membersMap.email}</td>
	</tr>
	
	<%-- 표현언어 EL로 변수에 접근하여 배열에 저장된 손흥민, 기성용 정보를 얻어 출력 --%>
	<tr align="center">
		<td width="7%">${mList[0].id}</td>
		<td width="7%">${mList[0].pwd}</td>
		<td width="7%">${mList[0].name}</td>
		<td width="7%">${mList[0].email}</td>
	</tr>
	<tr align="center">
		<td width="7%">${mList[1].id}</td>
		<td width="7%">${mList[1].pwd}</td>
		<td width="7%">${mList[1].name}</td>
		<td width="7%">${mList[1].email}</td>
	</tr>
</table>