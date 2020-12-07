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

//MVC패턴중 .. Model M의 역할을 하는 클래스 
//-> DB와 연결 하여 비즈니스 로직 처리를 하는 클래스 
public class MemberDAO {

	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public MemberDAO() { //new MemberDAO()객체 생성시 호출되는 기본생성자는
						 //커넥션풀(DataSource)를 받아와 저장시키는 용도이다
		try{
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			//컥넥션풀 (DataSource) 얻기
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
		
		}catch(Exception e){
			System.out.println("커넥션풀 얻기 실패:" + e.toString());
		}
	}//기본생성자 끝부분 
	
	
	//MemberController서블릿으로부터 호출되는 메소드로
	//DB에 존재하는 모든 회원정보를 조회하여 반환 해주는 메소드
	public List listMembers(){
		
		//조회한 모든 회원정보들(MemberVO객체들)을 저장할 ArrayList배열 
		List membersList = new ArrayList();
		
		try{
			//커넥션풀로 부터 커넥션 객체 빌려오기 (DB접속)
			conn = dataFactory.getConnection();
			//SQL문을 작성합니다
			String query = "select * from t_member order by joinDate desc";
			//SQL문을 DB에 전송하여 실행할 PreparedStatement객체 얻기 
			pstmt = conn.prepareStatement(query);
			//SQL문을 DB에 전송하여 조회 한후  조회한 회원정보들을 ResultSet객체에 담아 얻기
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				//조회한 회원한줄의 정보씩 얻어 변수에저장
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				//조회한 회원 한사람의 정보씩 MemberVO객체의 변수에 저장합니다.
				MemberVO memberVO = new MemberVO(id,pwd,name,email,joinDate);
				//ArrayList배열에 조회한 회원사람의 정보(MemberVO객체의 정보)를 추가하여 저장
				membersList.add(memberVO);
			}
				
		}catch(Exception e){
			System.out.println("listMembers메소드 오류:" + e);
		}finally {	
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return membersList;//호출한 MemberControler서블릿으로 리턴
	}


	//MemberController서블릿으로 부터 호출되는 메소드로
	//memberForm.jsp페이지에서 입력한 모든 회원정보를 DB에 INSERT시키는 메소드!
	//입력한 회원정보들은  MemberVO객체의 각변수에 저장되어 있기 때문에..
	//현재 addMember메소드의 매개변수로 그~~ MemberVO객체를 전달 받아 작업 한다.
	public void addMember(MemberVO memberVO) {
		
		try{
			//커넥션풀에서 커넥션객체 얻기 (DB연결)
			conn = dataFactory.getConnection();
			
			//입력회원정보들은 MemberVO객체의 각변수에 저장되어 있으므로
			//MemberVO객체의 getter역할을 하는 메소드들을 호출하여 모두 얻어온다
			//얻어오는 이유 : insert문장에 ?값으로 설정 하기 위함
			String id = memberVO.getId();
			String pwd = memberVO.getPwd();
			String name = memberVO.getName();
			String email = memberVO.getEmail();
			
			//insert문장 만들기
			String query = "INSERT INTO t_member(id, pwd, name, email)"
					     + "VALUES(?, ?, ?, ?)";
			
			System.out.println(query);
			
			//INSER전체문장중에서 ?기호에 대응되는 값을 제외한 전체 INSERT문장을 로딩한 
			//PreparedStatement <---insert문장을 실행할 객체 얻기
			pstmt = conn.prepareStatement(query);
			//PreparedStatement객체에  ?기호에 대응되는 추가할 값들을 설정
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			//PreparedStatement객체를 통해 오라클DB에 INSERT문장을 전송해서 실행!
			pstmt.executeUpdate(); //insert
				
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			//자원해제
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
	}//addMember메소드 
	
}//MemberDAO클래스 





