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
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//content.jsp페이지에서 글삭제 버튼을 클릭했을때 전달 받는  
	//삭제할 글번호, 삭제할글이 속해있는 페이지 번호 얻기
	int num = Integer.parseInt(request.getParameter("num"));//삭제할 글번호
	String pageNum = request.getParameter("pageNum");//글이 속해 있는 페이지번호
	
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
			<h1>Notice DELETE</h1>
			<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
				<%--삭제할 글번호 전달 --%>
				<input type="hidden" name="num" value="<%=num%>"/>
			
				<table id="notice">
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd"></td>
					</tr>												
				</table>
				<div id="table_search">
					<input type="submit" value="글삭제" class="btn" >
					<input type="reset" value="다시작성" class="btn" >
					<input type="button" value="글목록" class="btn" 
					       onclick="loction.href='notice.jsp?pageNum=<%=pageNum%>'" >
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





