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
	<%
		//1.한글처리
		request.setCharacterEncoding("UTF-8");
	
		//2.3. update.jsp페이지에서 수정을 위해 입력한 정보들을 request에서 꺼내와서
		//		BoardBean객체의 각 변수에 저장(자바코드 또는 Action태그 이용)
	%>
		
		<jsp:useBean id="bBean" class="board.BoardBean"/>
		<jsp:setProperty property="*" name="bBean"/>
	<%
		//4. 수정을 위해 입력한 정보가 담긴 BoardBean객체를
		//	BoardDAO객체의 updateBoard()메소드 호출시 매개변수로 전달 후 UPDATE작업 명령함
		//	수정에 성공하면 1을 반환받고 수정에 실패하면 0을 반환받아 int check변수에 저장
		BoardDAO bdao = new BoardDAO();
		int check = bdao.updateBoard(bBean);
		String pageNum = request.getParameter("pageNum");
		String num = request.getParameter("num");
		
		//5. check==1, UPDATE성공하면
		if(check == 1){
		%>
			<script type="text/javascript">
				window.alert("수정성공!");
				<%-- location.href="notice.jsp?pageNum=<%=pageNum%>"; --%>
				location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
			</script>
		<%
		} else {	// check==0, 비밀번호를 잘못 입력해서 UPDATE실패하면
		%>
			<script type="text/javascript">
				window.alert("비밀번호가 틀렸습니다");
				window.alert("수정실패!");
				history.go(-1);	//한단계 이전 update.jsp페이지로 가서 비밀번호 다시 입력하기
			</script>
		<%	
		}
	%>
</body>
</html>