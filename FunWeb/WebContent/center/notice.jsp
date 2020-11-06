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
	//DB작업할 객체 생성
	BoardDAO boardDAO = new BoardDAO();

	//DB에 저장된 전체 글 개수 검색 해오는 메소드 호출
	int count = boardDAO.getBoardCount();
	
	//DB에 저장된 전체 글 정보들을 담을 배열 변수 선언
	List<BoardBean> list = null;
	
	if(count > 0){	//작성한 글이 존재한다면
		
		//DB에 저장된 모든 글을 검색해서 ArrayList에 담아 리턴
		list = boardDAO.getBoardList();
	}
	
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
			<h1>Notice[전체 글 개수: <%=count %>    ]</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				
			</table>
			
			<%
				String id = (String)session.getAttribute("id");
			
				if(id != null){	//로그인 되어있다면
					
					%> 
					<!-- //글쓰기버튼이 보여야 함. -->
					<div id="table_search">
						<input type="button" value="글쓰기" onclick="location.href='write.jsp'" class="btn"/>	
					</div>	
					<%
				} else { //로그인 되어있지 않다면
					
					//글쓰기버튼이 보이지 않아야 함.
				}
			
			%>
			
			<div id="table_search">
				<input type="text" name="search" class="input_box"> 
				<input type="button" value="검색" class="btn">
			</div>
			<div class="clear"></div>
			<div id="page_control">
				<a href="#">Prev</a> <a href="#">1</a><a href="#">2</a><a href="#">3</a>
				<a href="#">4</a><a href="#">5</a><a href="#">6</a> <a href="#">7</a><a
					href="#">8</a><a href="#">9</a> <a href="#">10</a> <a href="#">Next</a>
			</div>
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