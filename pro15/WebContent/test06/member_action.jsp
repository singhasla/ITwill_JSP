<%@page import="java.util.List"%>
<%@page import="sec02.ex01.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
		member_action.jsp는 화면기능을 수행하지 않고
		데이터베이스 연동기능만 수행한다.
		
		회원정보를 추가한 후 다시 회원정보를 조회하고,
		조회한 회원정보를 request내장객체 영역에 저장한 후 memberList.jsp로 포워딩하는 페이지임
 --%>
 
 <% request.setCharacterEncoding("UTF-8"); %>

 <jsp:useBean id="m" class="sec02.ex01.MemberBean"/>
 <jsp:setProperty property="*" name="m"/>
 
 <%
 	MemberDAO memDAO = new MemberDAO();
 
 	memDAO.addMember(m);
 	
 	List membersList = memDAO.listMembers();
 	
 	/* mList라는 request내장객체영역에 담아 membersList.jsp페이지로 재요청(포워딩)하여 이동시킴. */
 	request.setAttribute("mList", membersList);
 %>
 <jsp:forward page="membersList.jsp"/>
 
 