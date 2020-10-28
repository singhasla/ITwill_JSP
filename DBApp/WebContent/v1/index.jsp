<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	
	<%-- 순서4. 검색기능 --%>
	<% 
		//DB작업을 위한 java.sql패키지에 있는 삼총사 객체를 저장시킬 변수 선언
		//1.DB연결정보를 가지고 있는 Connection객체를 저장할 변수 선언
		Connection con = null;
		
		//2.DB연결 후 DB에 SQL문을 전송하여 실행할 객체를 저장할 변수 선언
		Statement stmt = null;
		
		//3.DB에 SQL문(SELECT문)을 전송하여 조회한 회원정보들을 임시로 저장할
		//	객체를 담을 변수 선언
		ResultSet rs = null;
		
		//연결할 DB IP주소, DB ID, DB PW 정보를 저장
		String url = "jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
		String id = "jspid", pw = "jsppass";
		
		//SQL문 저장
		String sql = "";
		
		//SQL문 작성(SELECT)
		try{
			//검색버튼을 눌렀을 때 검색어를 입력하지 않았다면?
			//searchText변수에 값이 비어 있으면 true, 값이 있으면 false를 반환
			if(searchText.isEmpty()){
				
				//직원정보를 모두 검색하는 SELECT SQL문 만들기
				sql = "SELECT * FROM TBLSAWON";
			
			} else {
				
				//검색기준값에 해당하는 검색어단어를 포함하는 모든 직원을 검색하는
				//SELECT SQL문 만들기
				sql = "SELECT * FROM TBLSAWON WHERE " + search + " LIKE '%" + searchText + "%'";
			}
			
		} catch (Exception e){	//처음에 검색어가 입력되지 않고, index.jsp페이지를 처음 요청했을 때 모든 회원정보 출력 
			
			sql = "SELECT * FROM TBLSAWON";
		
		}
		
		/* -- 순서5. DB연동 -- */
		//DB연동, DB의 직원데이터 조회부분
		try{
			//1단계 JDBC 드라이버를 DriverManager클래스에 등록 (드라이버 로딩)
			Class.forName("com.mysql.jdbc.Driver");
			
			//2단계 DB연결 시도
			con = DriverManager.getConnection(url, id, pw);
			
			//3단계 DB에 SELECT SQL문장을 전송해서 실행할 Statement객체 얻기
			stmt = con.createStatement();
			
			//4단계 sql문장을 전송해서 조회한 결과를 ResultSet객체에 저장하여 얻기
			rs = stmt.executeQuery(sql);
			
			//SELECT문장 실행 후 조회한 결과데이터들을 ResultSet객체에서 꺼내와서 저장
			while(rs.next()){
				
				//조회한 한줄의 직원 정보 얻기
				String s_no = String.valueOf(rs.getInt("no"));
				String s_id = rs.getString(2);
				String s_name = rs.getString("name");
				String s_pw = rs.getString(4);
				int s_age = rs.getInt("age");
				String s_addr = rs.getString(6);
				String s_ext = rs.getString(7);
				String s_dept = rs.getString("dept");
				
		%>
				
				<%-- 순서6. 조회한 한줄의 직원정보를 출력 --%>
				<tr>
					<td><%=s_id%></td>
					<td><%=s_name%></td>
					<td><%=s_age%></td>
					<td><%=s_addr%></td>
					<td><%=s_dept%></td>
					<td><%=s_ext%></td>
					<td><a href="modifySawon.jsp?no=<%=s_no%>">수정</a></td>
					<td><a href="javascript:fnDel(<%=s_no%>)">삭제</a></td>
				</tr>
					
		<%
			}//while문 끝
			
		}catch(Exception e){
			System.out.println("index.jsp에서 DB작업 오류 : " + e);
		}finally{
			//자원해제
			//ResultSet객체를 사용하고 있으면 자원해제
			if(rs != null) rs.close();
			//Statement객체를 사용하고 있으면 자원해제
			if(stmt != null) stmt.close();
			//Connection객체를 사용하고 있으면 자원해제
			if(con != null) con.close();
		}
	%>		
	</table>
	
	
	
</body>
</html>