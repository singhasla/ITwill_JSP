

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
	//DB작업할 객체 생성
	BoardDAO boardDAO = new BoardDAO();

	//DB에 저장된 전체 글개수 검색 해오는 메소드 호출
	int count = boardDAO.getBoardCount();
	
	
	//한 페이지당 보여줄 글개수 5개로 설정
	int pageSize = 5;
	
	//notice.jsp페이지에서 클릭한 페이지 번호 얻기 
	String pageNum = request.getParameter("pageNum");
	
	//현재 클릭한 페이지 번호가 없으면(notice.jsp페이지를 처음 요청했을때)
	//현재 화면에 나타나는 페이지를 1로 설정
	if(pageNum == null){
		pageNum = "1";
	}
	
	//현재 화면에서 클릭한 페이지번호(현재 보여지는 화면)를 정수로 변환해서 저장
	int currentPage = Integer.parseInt(pageNum);
	
	//각 페이지 마다  가장 첫번째로 보여질 시작 글번호 구하기
	//(현재 화면에서 클릭한 페이지번호 - 1) * 한페이지당 보여줄 글개수 5
	int startRow = (currentPage - 1) * pageSize;
		
	//DB에 저장된 전체 글정보들을 담을 변수 선언
	List<BoardBean> list = null;
	
	if(count > 0){//DB에 글이 존재 한다면
		
		//글목록 검색해서 가져오기
		//getBoardList(각페이지마다 첫번째로 보여질 시작 글번호, 한페이당 보여줄 글개수);
		list = boardDAO.getBoardList(startRow,pageSize);
	} 
	//날짜 포맷 형식을 개발자가 지정할수 있는 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");	
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
			<h1>Notice[전체 글 개수: <%=count%>]</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
<%
	if(count > 0){//DB에 글이 존재 한다면
			for(int i=0;  i<list.size(); i++){
				BoardBean bean = list.get(i);
%>				
				<tr onclick="location.href='content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
					<td><%=bean.getNum()%></td>
					<td class="left">
						<%
							int wid = 0;	//답변글에 대한 들여쓰기 정도값 저장
							
							if(bean.getRe_lev() > 0){	//답변글이라면
								//들여쓰기 값 처리
								wid = bean.getRe_lev() * 10;
							
						%>
						<img src="../images/center/level.gif" width="<%=wid%> height="15">
						<img src="../images/center/re.gif">
						<%
							}
						%>
						
						<%=bean.getSubject()%>
					</td>
					<td><%=bean.getName()%></td>
					<td><%=sdf.format(bean.getDate())%></td>	
					<td><%=bean.getReadcount()%></td>
				</tr>	
<%				
			}
	}else{ //DB에 글이 존재 하지 않으면 
%>		
				<tr>
					<td colspan="5">게시판 글 없음</td>
				</tr>	
<%		
	}
%>							
			</table>
			
			<%
				String id = (String)session.getAttribute("id");
				if(id != null){ //로그인 되어있다면
			%>		
			<div id="table_search">
				<input type="button" 
					   value="글쓰기"  
					   onclick="location.href='write.jsp'" 
					   class="btn"  />
			</div>
			<%}%>	
			<div id="table_search">
				<input type="text" name="search" class="input_box"> 
				<input type="button" value="글검색" class="btn">
			</div>
			<div class="clear"></div>
			<div id="page_control">
				<%
					if(count>0){
						
						//전체 페이지 수 구하기 
						//=> 글 20개, 한 페이지당 보여줄 글개수 10개 = 2개의 페이지
						//=> 글 25개, 한 페이지당 보여줄 글개수 10개 = 3개의 페이지
						//조건삼항연산자 사용
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0:1);	//이해완료
						
						//한 화면(한 블럭)에 보여줄 페이지 개수 설정
						int pageBlock = 2;
						
						//시작페이지 번호 구하기
						// 1 ~ 10 = 1		11 ~ 20 = 11		21 ~ 30 = 21
						//	( (현재 클릭한 페이지번호/한블럭에 보여줄 페이지개수) - (현재 클릭한 페이지번호를 한블럭에 보여줄 페이지개수로 나눈 나머지값) ) * 한블럭에 보여줄 페이지 개수 + 1
						int startPage = ((currentPage / pageBlock) - (currentPage%pageBlock==0? 1:0)) * pageBlock + 1;
						
						//끝페이지 번호 구하기
						// 1 ~ 10 = 10		11 ~ 20 = 20		21 ~ 30 = 30
						// 끝페이지 번호 = 시작페이지번호 + 한 블럭에 보여줄 글갯수 -1
						int endPage = startPage + pageBlock - 1 ;
						
						//[이전] : 시작페이지 번호가 한 블럭에 보여줄 페이지 개수보다 클 때
						if(startPage > pageBlock){
							%>
								<a href="notice.jsp?pageNum=<%=startPage-pageBlock %>">[이전]</a>
							<%
						}
			
						//페이지 번호 구현 [1] [2] [3]....
						for(int i = startPage; i <= endPage ; i++){
							%>
								<a href="notice.jsp?pageNum=<%=i %>">[<%=i %>]</a>
							<%
						}
						
						//[다음] : 끝페이지 번호가 전체 페이지개수보다 작을 때
						if(endPage < pageCount){
							%>
								<a href="notice.jsp?pageNum=<%=startPage+pageBlock %>">[다음]</a>
							<%
						}
						
					}
				 %>
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





