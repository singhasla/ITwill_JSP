
<%-- 커넥션풀(DBConnectionMgr 클래스)를 사용하기 위해 import --%>
<%@page import="mybean.SawonDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbcp.DBConnectionMgr" %>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@page import="mybean.SawonDao" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
	
		//아래의 코드 중 삭제<a>태그를 클릭했을 때..
		//직원삭제를 정말로 하시겠습니까?	<-- 라고 한번더 물어볼 수 있는 기능을 하는 메소드
		function fnDel(no) {
			
			var recheck = confirm("정말로 삭제하시겠습니까?");
			//[확인]버튼을 누르면 -> true
			if(recheck){
				//delSawon.jsp 재요청시.. 삭제할 직원no 전달
				location.href = "delSawon.jsp?no=" + no;
			}
			//else{//[취소]버튼을 누르면 -> false
				
			//}
			
		}
	</script>

</head>
<body>

	<%-- 순서2. 서치 가져오기--%>
	<% 
		//아래의 <form>태그 내부에서 입력한 요청값 한글처리
		request.setCharacterEncoding("utf-8");
		
		//입력한 검색기준값, 검색어를 request메모리에서 꺼내오기(요청한 값 얻기)
		String search = request.getParameter("search");	//선택한 검색기준값 얻기
		String searchText = request.getParameter("searchText");	//입력한 검색어 얻기
	%>
	
	<%-- 순서1. 페이지 디자인--%>
	<h2>직원 정보 리스트</h2>
		<%-- 직원추가(회원가입)페이지로 이동하는 링크 만들기 --%>
		<a href="addSawon.jsp">직원추가(회원가입)</a>
		
		<%-- 직원 정보를 검색하기 위한 검색 : 검색기준값, 검색어 --%>
		<form action="index.jsp" method="post">
			<select name="search">
				<option value="id">아이디</option>
				<option value="addr">근무지</option>
				<option value="dept">부서명</option>
			</select>
			<input type="text" name="searchText">
			<input type="submit" value="검색">
		</form>
		
	<%-- 순서3. 조회한 직원정보 리스트 --%>
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>나이</td>
			<td>근무지</td>
			<td>부서명</td>
			<td>내선번호</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
	
	<% 
		//DB에 저장된 모든 회원 정보를 조회하기위해 객체 생성
		SawonDao dao = new SawonDao();	
	
		//SawonDao객체의 getList메소드 호출시.. 입력한 검색어와 검색기준값을 전달하여 DB작업함.
		//그 후~ getList메소드의 반환값으로 검색한 회원정보들을 ArrayList배열에 담아 반환받는다.		
		ArrayList list = dao.getList(search, searchText);
		
		//ArrayList배열에 저장된 new SawonDto()객체의 갯수만큼 반복해서..
		//ArrayList배열에 각 인덱스 위치에 저장된 new SawonDto()객체를 get(index)메소드를 호출하여 얻어 출력
		for(int i=0;i<list.size();i++){
			
			SawonDto dto = (SawonDto)list.get(i);
			%>
			<tr>
				<td><%=dto.getId() %></td>
				<td><%=dto.getName() %></td>
				<td><%=dto.getAge() %></td>
				<td><%=dto.getAddr() %></td>
				<td><%=dto.getDept() %></td>
				<td><%=dto.getExtension() %></td>
				<td><a href="modifySawon.jsp?no=<%=dto.getNo()%>">수정</a></td>
				<td><a href="javascript:fnDel(<%=dto.getNo()%>)">삭제</a></td>
			</tr>
			<%
		}
	%>
</body>
</html>
