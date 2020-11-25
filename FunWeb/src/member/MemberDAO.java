
package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//자바빈 클래스의 종류중 DAO역할을 하는 클래스
//DB연결 후 작업하는 클래스 (비즈니스로직을 처리하는 클래스)
public class MemberDAO {

	Connection con = null; //DB와 미리연결을 맺은 접속을 나타내는 객체를 저장할 조상 인터페이스 타입의 변수 
	PreparedStatement pstmt = null; //DB(jspbeginner)에 SQL문을 전송해서 실행할 객체를 저장할 변수 
	ResultSet rs = null;//DB에 SELECT검색한 결과데이터들을 임시로 저장해 놓을 수 있는
						//ResultSet객체를 저장할 변수 
	
	
	//DataSource커넥션풀을 얻고
	//커넥션풀 내부에 있는 Connection객체를 얻는 메소드
	private Connection getConnection() throws Exception{
		
		//톰캣이 각 프로젝트에 접근할수 있는 Context객체의 경로를 알고 있는 객체
		Context init = new InitialContext();
		
		//DataSource커넥션풀 얻기 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		//DataSource커넥션풀 내부에 있는 Connection객체 얻기
		con = ds.getConnection();
		
		return con;//DB와 미리 연결을 맺어 놓은 접속을 나타내는 Connection객체 반환
	}//getConnection메소드 끝
	
	public void 자원해제(){
		try{
			if(pstmt != null){ pstmt.close();}
			if(rs != null){rs.close();}
			if(con != null){con.close();}
		}catch(Exception e){
			System.out.println("자원해제 실패 : " + e);	
		}
	}
	
	
	
	/*joinPro.jsp에서 호출하는 메소드로   입력한 회원정보를 DB에 추가하는 메소드*/
	public void insertMember(MemberBean memberBean){
		
		String sql = "";
		
		try {
			//1.커넥션풀에서 커넥션얻기(DB연결)
			con = getConnection();
			
			//2.insert문장 만들기
			sql = "insert into member(id,passwd,name,reg_date,email,address,tel,mtel)"
				+ "values(?,?,?,now(),?,?,?,?)";
			
			//3.PreparedStatement insert문 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//3-1. ? 기호에 대응 되는 값을 우리가 입력한 가입할 내용으로 설정 
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getEmail());
			pstmt.setString(5, memberBean.getAddress());
			pstmt.setString(6, memberBean.getTel());
			pstmt.setString(7, memberBean.getMtel());
			//4.insert문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부 오류 : " + e);
		} finally{
			//5.자원해제
			자원해제();	
		}
	}//insertMember메소드 닫는 기호 
	
	
	//회원가입을 위해 사용자가 입력한 id를 매개변수로 전달 받아..
	//DB에 저장된 id와 비교 하여  중복, 중복이냐를 판단 해서 반환해주는 메소드
	public int idCheck(String id){		
		String sql = "";		
		//아이디 중복이냐, 중복이 아니냐 의 판단 데이터를 저장할 변수 선언
		int check = 0;
		
		try {
			//DataSource에서 Connection얻기 (DB연결)
			con = getConnection();
			//매개변수로 전달받은 입력한 아이디에 해당되는 회원 검색 SELECT문장 만들기 
			sql = "select * from member where id=?";
			//SELECT문장을 실행할 PreparedStatement실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//? 설정
			pstmt.setString(1, id);
			//DB에 SELECT전송하여 실행후 검색된 회원 한사람의 정보를 ResultSet객체에 담아 반환받습니다.
			rs = pstmt.executeQuery();
			
			if(rs.next()){//입력한 아이디에 해당되는 회원 한줄이 조회되면?
						  //(입력한 아이디가 DB에 저장되어 있다면?)
				check = 1; //아이디 중복
			}else{//입력한 아이디가 DB에 존재 하지 않으면? 조회가 되지 않으면?
				check = 0; //아이디 중복 아님 
			}	
		} catch (Exception e) {
			System.out.println("idCheck메소드내부에서 오류 : " + e.toString());
		} finally{
			자원해제();
		}
		return check;//join_IDCheck.jsp로 리턴(반환) , check변수값 1또는 0을 반환 
	}//idCheck메소드 닫는 기호 
	
	
	//loginPro.jsp에서 호출하는 메소드로 
	//사용자로 부터 입력받은 ID,PWD를 매개변수로 전달 받아..
	//DB에 존재하는 ID,PWD가 같으면 로그인 처리 하는 메소드
	public int userCheck(String id, String passwd){
		
		int check = -1;  //  1 -> 아이디, 비밀번호 맞음 
						 //  0 -> 아이디 맞음, 비밀번호 틀림
						 //  -1 -> 아이디 틀림
		try {
			//위에 만들어 놓은 getConnection메소드를 호출해
			//Connection객체 얻기 (DB접속)
			con = getConnection();
			//매개변수로 전달 받은 입력한 id에 해당되는 회원 검색 SQL문
			String sql = "select * from member where id=?";
			//PreparedStatement실행객체 얻기 
			pstmt = con.prepareStatement(sql);
			//?설정
			pstmt.setString(1, id);
			//입력한 id에 해당되는 회원 검색후 얻기 
			rs = pstmt.executeQuery();
			
			if(rs.next()){//입력한 id가 DB에 존재 하면(아이디 같으면)
				
				if(passwd.equals(rs.getString("passwd")) ){//비밀번호 같으면
					
					check = 1; //입력한 아이디 비밀번호가 DB에 저장된 값과 동일 하다는 뜻임
				
				}else{//아이디는 같으나 비밀번호가 다르면
					check = 0; //아이디 맞음 , 비밀번호 틀림 
				}			
			}else{//입력한 id가 DB에 존재 하지 않으면
				check = -1; //아이디 없음 
			}	
		} catch (Exception e) {
			System.out.println("userCheck메소드 내부에서 오류:"+ e);
 		} finally {
			자원해제();
		}
		return check;//loginPro.jsp페이지로 반환
	}
	
	
	
}//MemberDAO클래스 끝





