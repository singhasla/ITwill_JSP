<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>deletePro.jsp</h1>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//delete.jsp(글을 삭제하기 위해 비밀번호 입력화면)에서 
		//글을 삭제하기위해 비밀번호를 입력하고  삭제버튼을 클릭했을때..
		//요청한 값 얻기 
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String passwd = request.getParameter("passwd");//입력한 비밀번호 
		
		BoardDAO bdao = new BoardDAO();
		
		//check == 1  삭제성공  -> notice.jsp이동
		//check == 0  글에 대한 비밀번호 틀림  -> delete.jsp로 이동 
		int check = bdao.deleteBoard(num,passwd);
		 
		if(check == 1){
	%>
		<script>
			alert("삭제성공!");
			location.href="notice.jsp?pageNum=<%=pageNum%>";
		</script>	
	<%		
		}else{
	%>
		<script>
			alert("비밀번호틀림!");
			history.back();
		</script>
	<%		
		}
	%>



</body>
</html>








