

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
	/*주글에 대한 답글 정보를 입력하여 요청하는 곳*/
	
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//content.jsp페이지에서 주글에 대한 답글 쓰기 버튼을 클릭했을때..
	//전달받는 요청값은 ? 몇개? 4개 이기때문에 전달 받기
	int num =  Integer.parseInt(request.getParameter("num"));//주글 글번호 
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));//주글 그룹번호
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));//주글의 들여쓰기 정도값
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));//주글들내의 순서값


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
			<h1>Notice 답글작성하는 페이지</h1>
			
		<form action="reWirtePro.jsp" method="post">
		
			<input type="hidden" name="num" value="<%=num%>" >
			<input type="hidden" name="re_ref" value="<%=re_ref%>">
			<input type="hidden" name="re_lev" value="<%=re_lev%>">
			<input type="hidden" name="re_seq" value="<%=re_seq%>">
					
			<table id="notice">
				<tr>
					<td>답글작성자</td>
					<td><input type="text" name="name"></td>	
				</tr>
				<tr>
					<td>답글 비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>답글 제목</td>
					<td><input type="text" name="subject" value="[답글]">  </td>
				</tr>
				<tr>
					<td>답글 내용</td>
					<td><textarea name="content" rows="13" cols="40"></textarea></td>
				</tr>
				
			</table>	
			<div id="table_search">
				<input type="submit" value="답글작성" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="목록보기" class="btn" 
				       onclick="location.href='notice.jsp'">
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





