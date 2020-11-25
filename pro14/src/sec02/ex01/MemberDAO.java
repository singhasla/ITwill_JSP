package sec02.ex01;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//오라클 DBMS의 테이블과 연결 하여 작업할 클래스 
public class MemberDAO {

	//위 네가지 접속 설정값을 이용해서 오라클 DB와 접속한 정보를 지니고 있는 Connection객체를 저장할 변수 선언
	private Connection con;
	
	//DB와 접속후 우리가 만들 SQL문을 생성후 실행할 실행 객체를 담을 변수 선언
//	private Statement  stmt;
	//Statement인터페이스를 구현한 자식객체 대신~~ 
	//PreparedStatement인터페이스를 구현한 자식객체를 사용하기 위해 변수 선언
	private PreparedStatement pstmt;
	
	//검색한 회원정보들을 임시로 저장할 메모리 객체를 담을 변수 선언
	private ResultSet  rs;
	
	//커넥션풀 객체를 저장할 변수 선언 
	private DataSource dataFactory;
	
	//기본 생성자 역할 : JNDI기술을 이용하여  context.xml파일의 Resource를 불러와 커넥션풀을 얻는다.
	public MemberDAO() {   
		try{
			//톰캣이 실행되면 context.xml의 <Resource/>태그의 설정을 읽어와
			//톰캣 메모리에 프로젝트별로 Context객체들을 생성합니다.
			//이때 InitialContext객체가 하는 역할은 
			//톰캣 실행시 context.xml에 의해서 생성된 Context객체들에 접근하는 역할을 합니다.
			Context ctx = new InitialContext();
			
			//JNDI방법으로 접근하기 위해 기본 경로(java:/comp/env)를 지정 합니다
			//lookup("java:/comp/env")는 그 중 환경 설정에 관련된 컨텍스트 객체에 접근하기 위한 기본주소입니다.
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			
			/*커넥션풀 얻기*/
			//그런후 다시 톰캣은  context.xml에 설정한 <Resource name="jdbc/oracle".../>태그의 
			//name값 "jdbc/oracle"을 이용해 톰캣이 미리 연결한 DataSource객체(커넥션풀 역할을 하는 객체)를 받아옵니다
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
			
			
		}catch(Exception e){
			System.out.println("커넥션풀(DataSource객체)얻기 실패" + e);
		}
	}//MemberDAO생성자 
	
	//서블릿에서 전달된 입력한 ID로  SQL문의 조건식에 설정한후 
	//입력한 ID에 해당되는 회원정보를 조회하여 그결과를 true 또는 false로 반환함
	public boolean overlappedID(String id){
		
		boolean result = false;
		
		try{
			//커넥션풀(DataSource)공간에서 커넥션(Connection)객체를 빌려옴
			//DB접속
			con = dataFactory.getConnection();
			//오라클의 decode()함수를 이용하여 서블릿에서 전달된 입력한 ID에 해당하는 데이터를 검색하여
			//true 또는 false를 반환하는데..
			//검색한 갯수가 1(검색한레코드가 존재하면)이면  true를 반환
			//존재하지 않으면 false를 문자열로 반환하여 조회하는 SQL문 
			String query = "select decode(count(*), 1, 'true','false') as result from t_member";
				   query += " where id=?";
	   
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1, id);
		    rs = pstmt.executeQuery();
		    rs.next();
		    
		    //문자열 "true" 또는 "false"를  Boolean클래스의 parseBoolean(String value)메소드를 호출시 전달해
		    //boolean데이터로 변환 해서 반환 함.
		    result =   Boolean.parseBoolean(rs.getString("result"));
		    
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			//자원해제
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;//MemberServlet서블릿으로  true또는 false반환 
	}
}//MemberDAO클래스 끝





