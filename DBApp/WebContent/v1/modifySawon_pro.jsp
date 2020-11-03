<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    
    //1. 수정하기 위해 입력한 정보들은 request객체 메모리에 저장되어 있기 때문에..
    //		request객체 메모리영역에서 꺼내오기 전에 한글처리
		request.setCharacterEncoding("utf-8");
    
	//2. 수정할 직원의 정보를 request영역에서 얻기
  		String no = request.getParameter("no");
  		
		String s_id = request.getParameter("s_id");
		String s_pw = request.getParameter("s_pw");
		String s_name = request.getParameter("s_name");
		String s_age =  request.getParameter("s_age");
		String s_addr = request.getParameter("s_addr");
		String s_ext = request.getParameter("s_ext");
		String s_dept = request.getParameter("s_dept");
    
	//3. 위 요청한 값들을 이용해 update문장 만들기 (참고 : 변수명을  + 해서 전체 update문장 만듬)
		String sql = "UPDATE TBLSAWON SET id='"+s_id
		+"', pass='"	+	s_pw
		+"', name='"	+	s_name
		+"', age='"		+	s_age
		+"', addr='"	+	s_addr
		+"', extension='"+	s_ext
		+"', dept='"	+	s_dept
		+"' where no='"	+	no		+"'";
	
	//4. DB작업(UPDATE작업)을 하기위해 java.sql패키지에 존재하는 객체를 담을 변수 선언
		Connection con = null;
		Statement stmt = null;
		
	//5. DB와 연결할 DB주소, DB접속 id, pw 정보를 변수에 저장		
		String url = "jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
		String id = "jspid", pw = "jsppass";
		
	//6. DB와 연결하여 UPDATE쿼리문을 실행!
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
			window.alert("업데이트 성공!");
			
			//자바스크립트의 재요청(포워딩)기술?
			//index.jsp로 이동
			location.href="index.jsp";
		</script>
	<%
	}catch(Exception e){
		System.out.println("modifySawon_pro.jsp에서 예외 발생 : " + e);
	}finally{
		//자원해제
		//Statement객체를 사용하고 있으면 자원해제
		if(stmt != null) stmt.close();
		//Connection객체를 사용하고 있으면 자원해제
		if(con != null) con.close();
	}
    %>