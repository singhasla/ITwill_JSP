package sec02.ex01;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


//자바빈 클래스 종류 중 DAO클래스
//	- DB관련 작업하는 클래스

//오라클 DMBS의 데이터베이스와 연결하여 작업할 클래스
public class MemberDAO {

	//데이터베이스 관련 작업에 필요한 객체들을 저장할 변수 선언
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;	//커넥션풀
	
	//기본생성자 : 커넥션풀(DataSource)객체를 얻는 생성자
	public MemberDAO() {
		try {
			//톰캣이 실행되면 context.xml의 <Resource>설정을 읽어와서 톰캣 메모리에 프로젝트별로
			//Context객체들을 생성해 놓는다.
			//이 때, InitialContext객체가 하는 역할은 톰캣 실행시 context.xml에 의해서 생성된
			//Context객체들에 접근을 하는 역할을 한다.
			Context ctx = new InitialContext();
			
			//JNDI방법으로 접근하기 위해 기본경로(java:/comp/env)를 지정한다.
			//lookup("java:/comp/env")는 그 중 환경설정에 관련된 컨텍스트 객체에 접근하기 위한 기본주소이다.
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			
			//그런 후 톰캣 context.xml에 설정한 <Resource name="jdbc/oracle"..>태그의
			//name값 "jdbc/oracle"을 이용해 톰캣이 미리 DB에 연결해 놓은
			//DataSource객체(커넥션풀 역할을 하는 객체)를 받아온다.
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
			
		} catch (Exception e) {
			System.out.println("커넥션풀 얻기 실패 : " + e.toString());
		}

	}
	
	//DB에 회원정보를 추가할 메소드
	//member.jsp페이지에서 호출하는 메소드로 매개변수로 전달되어 오는 MemberBean객체의 각 변수에는?
	//입력한 회원정보들이 저장되어 있다.
public void addMember(MemberBean memberBean){
		
		try{
			//DataSource(커넥션풀)내부에 있는 DB와 미리연결을 맺은 Connectinon객체 꺼내서 빌려오기
			con = dataFactory.getConnection();
			
			//입력한 회원정보들을 매개변수로 전달 받은 MemberBean객체의 각변수에 저장된 값을 얻어 저장
			String id = memberBean.getId();
			String pwd = memberBean.getPwd();
			String name = memberBean.getName();
			String email = memberBean.getEmail();		
			//insert문장 만들기 (PreparedStatement방식)
			String query = "insert into t_member(id,pwd,name,email) values(?,?,?,?)";		
			
			//?를 제외한 insert문장을 임시로  OraclePreparedStatementWrapper실행객체에 담아..
			//OraclePreparedStatmentWrapper <---insert문장을 DB에 전송하여 실행할 역할을 하는 객체 얻기
			pstmt = con.prepareStatement(query);
			
			//OraclePreparedStatementWrapper실행객체에  ? 값 4개 설정
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			//OraclePreparedStatementWrapper실행객체를 이용하여 DB에 insert문장을 전송후 실행!
			pstmt.executeUpdate();
			
		}catch(Exception e){
			
			System.out.println("addMember메소드 내부에서 오류 : " + e.toString());
			
		}finally{
			try {
				//자원해제
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}//finally끝
		
	}//addMember메소드 끝
	
	//DB의 모든 회원정보를 조회(검색) 하는 메소드
		public List listMembers(){
			
			//DB의 모든 회원정보들을 조회(검색) 하여 저장시킬 가변길이 배열 ArrayList공간 생성
			List list = new ArrayList();
					
			try{
				//커넥션풀(DataSource)로 부터 Connection객체 얻기
				con = dataFactory.getConnection();
				
				//SELECT문장 만들기 : 회원정보를 최근 가입일순으로 내림차순정렬하여 모든 회원 조회 
				String query = "select * from t_member order by joinDate desc";
						
				//OraclePreparedStatementWrapper실행객체 얻기
				pstmt = con.prepareStatement(query);
				
				//? 기호에 대응되는 값 설정
						
				//조회한 모든 회원정보들을 OracleResultSetImpl객체에 담아 이객체 자체를 반환받기
				ResultSet rs = pstmt.executeQuery();
				
				//테이블 형식의 구조를 가지고 있는 OracleResultSetImpl객체에 조회한 회원레코드가 존재하는 동안 반복
				while(rs.next()){
					//오라클 DB의 t_member테이블에서 검색한 레코드의 각컬럼값들(한줄단위로 검색한 값들)을 
					//OracleResultSet객체에서 꺼내와 각변수에 저장
					String id = rs.getString("id"); 
					String pwd = rs.getString("pwd");
					String name = rs.getString("name");
					String email = rs.getString("email");
					Date joinDate = rs.getDate("joinDate");
					
					//검색한 회원 한명의 정보(한줄정보)를 MemberBean객체를 생성하여 각각의 변수에 저장
					MemberBean vo  = new MemberBean();
					vo.setId(id);
					vo.setPwd(pwd);
					vo.setName(name);
					vo.setEmail(email);
					vo.setJoinDate(joinDate);
					
					//그후 MemberBean객체를 ArrayList배열에 추가 
					list.add(vo);
				}//반복문의 끝
		
			}catch(Exception e){
				System.out.println("listMembers메소드 내부에서 오류 : " + e);
			}finally{
				
				try {
					if(pstmt != null) pstmt.close();
					if(con != null) con.close(); //커넥션풀로 반납
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			//ArrayList배열을  member.jsp로 반환
			return list;
			
		}//listMembers메소드 끝
			
	}//MemberDAO클래스 끝