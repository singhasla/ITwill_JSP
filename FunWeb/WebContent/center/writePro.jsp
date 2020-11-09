<%@page import="com.sun.org.apache.regexp.internal.recompile"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>writePro.jsp</h1>    
    
<%
	//세션영역에 저장된 값 얻기 
	//이유 : 로그인 하지 않고 글쓰기 작업시 다시 로그인을 하기위해 아이디 비밀번호를 입력하는 곳으로 이동 시키기 위해
 	String id = (String)session.getAttribute("id");

	//세션영역에 값이 저장되어 있지 않다면
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
 
	//1.  인코딩 방식 UTF-8설정
	request.setCharacterEncoding("UTF-8");
	
	//2. 요청한값 얻기 (쓴 글의 내용 얻기)
	String name = request.getParameter("name");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	//현재글을 작성한 날짜 얻기
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	//현재글을 작성하는 사람의 IP주소 얻기
	String ip = request.getRemoteAddr();
	
	//3. BoardBean객체를 생성하여 DB에 추가할 글내용 저장
	BoardBean boardbean = new BoardBean();
	//set으로 시작하는 메소드들을 호출하여 각변수에 저장
	boardbean.setName(name);
	boardbean.setPasswd(passwd);
	boardbean.setSubject(subject);
	boardbean.setContent(content);
	boardbean.setDate(timestamp);
	boardbean.setIp(ip);
	
	//4.BoardDAO객체를 생성하여 새로운글내용을 추가할 insertBoard메소드 호출시  BoardBean객체를 전달
	BoardDAO bdao = new BoardDAO();
	bdao.insertBoard(boardbean);
	 
	
	//5.DB에 글 추가가 성공 되었다면   notice.jsp게시판목록화면을 재요청해 이동
	response.sendRedirect("notice.jsp");
%>
    
    
    
    
    
    
    
    
    
    