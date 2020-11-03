<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 순서1. addSawon.jsp 의 form태그내부에서 입력하여 요청한 가입할 회원내용 얻기 --%>
	<%
		//1> 인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("utf-8");
		
		//2> 요청한 값 얻기
		String s_id = request.getParameter("s_id");
		String s_pw = request.getParameter("s_pw");
		String s_name = request.getParameter("s_name");
		String s_age =  request.getParameter("s_age");
		String s_addr = request.getParameter("s_addr");
		String s_ext = request.getParameter("s_ext");
		String s_dept = request.getParameter("s_dept");
		System.out.println(s_addr);
		
		//순서2. 위 요청한 값들을 이용해 insert문장 만들기 (참고 : 변수명을  + 해서 전체 insert문장 만듬)
		String sql = "INSERT INTO TBLSAWON(id,pass,name,age,addr,extension,dept) "
						+ "VALUES(?,?,?,?,?,?,?)";
			
		//순서3. DB연결 후 insert문장 실행하는 작업!
		//DB작업을 위한 java.sql패키지에 있는 객체를 저장할 변수 2개 선언
		//1> DB연결을 맺은 접속정보를 가지고 있는 객체를 담을 변수 
		Connection con = null;
		//2> DB연결후  SQL문(insert문장)을 DB에 전송하여 실행할 역할을 하는객체를 담을 변수
		PreparedStatement pstmt = null;	
		//3> 연결할 DB의 접속정보 3가지 변수에 각각 저장 (접속할  DB주소, id, pw)
		String url = "jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
		String id = "jspid", pw = "jsppass";

		try{
			//4> 1단계 Mysql전용 Driver로딩 
			Class.forName("com.mysql.jdbc.Driver");
			//5> 2단계  DB연결 시도(DB연결)
			con = DriverManager.getConnection(url, id, pw);
			//6> 3단계 PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, s_id);
			pstmt.setString(2, s_pw);
			pstmt.setString(3, s_name);
			pstmt.setInt(4, Integer.parseInt(s_age));
			pstmt.setString(5, s_addr);
			pstmt.setString(6, s_ext);
			pstmt.setString(7, s_dept);
			
			
			//7> 4단계 Statement객체를 이용해 "insert"문장 DB에 전송 하여 실행!
			pstmt.executeUpdate();
		%>
			<h2>직원정보가 잘 추가 되었습니다.</h2>
			<a href="addSawon.jsp">새로운 직원 추가 화면으로 ..</a>
			<a href="index.jsp">메인화면 index.jsp로...</a>
		<%	
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("addSawon_proc.jsp에서 오류 : " + e);
		}finally{
			//8>자원해제
			//Statement객체를 사용하고 있으면 자원해제
			if(pstmt != null) pstmt.close();
			//Connection객체를 사용하고 있으면 자원해제
			if(con != null) con.close();
		}
		%>
		
</body>
</html>