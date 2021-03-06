

<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<%
	/*글 하나의 정보를 보여주는 페이지*/
	
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
//content.jsp에서 글수정 버튼 클릭했을때 요청한 값 전달 받기 
	//1.수정하기 전의 글정보를 데이터베이스에서 검색해오기 위해 글번호 얻기 
	int num = Integer.parseInt(request.getParameter("num"));
	//2.수정할 글번호가 속해 있는 페이지 번호 얻기 
	String pageNum = request.getParameter("pageNum");

	//DB작업을 위한 DAO객체 생성
	BoardDAO dao =  new BoardDAO();
	
	//글번호를 매개변수로 전달 하여  글번호에 해당되는 글의 정보를 검색해옴
	BoardBean boardBean = dao.getBoard(num); 
	
	int DBnum = boardBean.getNum();//검색한 글번호 
	int DBReadcount = boardBean.getReadcount();//검색한 글의 조회수
	String DBName = boardBean.getName();//검색한 글작성자명
	Timestamp DBDate = boardBean.getDate();//검색한 글작성일
	String DBSubject = boardBean.getSubject();//검색한 글제목
	String DBContent = "";//검색한 글 내용
	//검색한 글내용이 존재한다면.. 엔터키를 사용해서 처리한 글내용을 받아온다
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br>", "\r\n");
	}
	//답변글 처리 관련 검색한 필드의 정보 얻기
	int DBRe_ref = boardBean.getRe_ref();//주글의 그룹번호
	int DBRe_lev = boardBean.getRe_lev();//주글의 들여쓰기정도값
	int DBRe_seq = boardBean.getRe_seq();//주글들 내의 순서값
	
%>

<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Notice</a></li>
				<li><a href="#">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>Notice Update[글수정요청페이지]</h1>
			
		<form action="updatePro.jsp" method="post">
		
			<input type="hidden" name="num" value="<%=num%>" >
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=DBName%>"></td>	
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject%>">  </td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea name="content" rows="13" cols="40"><%=DBContent%></textarea></td>
				</tr>
				
			</table>	
			<div id="table_search">
				<input type="submit" value="글수정" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="목록보기" class="btn" 
				       onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
			</div>
		</form>
		
			<div class="clear"></div>
			
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>





