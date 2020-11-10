<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
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
		request.setCharacterEncoding("UTF-8");
	
		//reWrite.jsp에서 입력한 정보를 BoardBean객체의 각 변수에 저장
	%>
	
	<jsp:useBean id="bBean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bBean"/>
	
	<%
		//답글을 작성한 날짜와 시간정보를 추가로 BoardBean객체의 date변수에 저장
		//System.currentTimeMillis();	/* 현재 컴퓨터시스템 시간을 long값으로 반환 */
		bBean.setDate( new Timestamp(System.currentTimeMillis()) );
		
		//답글을 작성하는 클라이언트의 IP주소를 추가로 저장 BoardBean객체의 ip변수에 저장
		//request.getRemoteAddr();	/* 요청한 클라이언트의 IP주소를 반환 받음 */
		bBean.setIp( request.getRemoteAddr() );
		
		//작성한 답글 정보를 DB에 INSERT하기 위해 
		//BoardDAO객체의 reInsertBoard(BoardBean bBean)메소드 호출시..
		//BoardBean객체 전달함
		new BoardDAO().reInsertBoard(bBean);	//체이닝기법?
				
		//DB에 답글을 추가했다면
		//notice.jsp게시판목록화면을 재요청해 이동
		response.sendRedirect("notice.jsp");
	%>
</body>
</html>