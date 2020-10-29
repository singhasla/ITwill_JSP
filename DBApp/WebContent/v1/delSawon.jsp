<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제후 ~삭제성공! <--메시지창 띄우고 index.jsp로 이동!
	request.setCharacterEncoding("utf-8");
	String s_no = request.getParameter("no");
	
	Connection con = null;
	Statement stmt = null;
	
	String url = "jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	String id = "jspid", pw = "jsppass";
	
	String sql = "DELETE FROM TBLSAWON WHERE no='"+ s_no +"'";
	
	try{
		//1단계 MySQL DBMS에서 제공해주는 Driver.class의 객체를 동적으로 생성해서
		//DriverManager 클래스에 저장(등록)
		//요약 : Mysql전용 Driver로딩 
		Class.forName("com.mysql.jdbc.Driver");						//예외발생가능구역
		//2단계  DB연결 시도(DB연결)
		con = DriverManager.getConnection(url, id, pw);				//예외발생가능구역
		//3단계 sql문을 실행할 Statement객체 얻기
		stmt = con.createStatement();
		//4단계 UPDATE문장을 DB에 전송 하여 실행!
		stmt.executeUpdate(sql);								//예외발생가능구역
		
	%>
		<script type="text/javascript">
			window.alert("삭제성공!");
			location.href="index.jsp";
		</script>
	<%
	}catch(Exception e){
		System.out.println("delSawon_pro.jsp에서 예외 발생 : " + e);
	}finally{
		//자원해제
		//Statement객체를 사용하고 있으면 자원해제
		if(stmt != null) stmt.close();
		//Connection객체를 사용하고 있으면 자원해제
		if(con != null) con.close();
	}
%>