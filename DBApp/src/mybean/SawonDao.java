package mybean;

import java.sql.*;
import java.util.ArrayList;

import dbcp.DBConnectionMgr;

//java프로그램과 DBMS의 DB와 연결을 맺어 데이터를 제어하는 클래스
public class SawonDao {

	//변수 선언
	private Connection con;			//DB연결 및 DB연결 정보가 있는 Connection객체를 저장할 변수
	private PreparedStatement pstmt;//DBMS의 DB에 SQL문을 전송하여 실행할 객체를 저장할 변수
	private ResultSet rs;			//DB에 SELECT문을 전송하여 실행 후 조회한 정보를 임시로 담을 객체를 저장할 변수
	private DBConnectionMgr pool;	//커넥션풀 역할을 하는 new DBConnectionMgr()객체를 저장할 변수
	
	//생성자 선언
	//커넥션풀 역할을 하는 new DBConnectionMgr()객체를 얻을 생성자
	public SawonDao() {
		try {
			//DBConnectionMgr클래스의 getInstance()메소드를 호출하여
			//반환값으로 new DBConnectionMgr()커넥션풀 객체 얻기
			pool = DBConnectionMgr.getInstance();
			
		} catch (Exception e) {
			System.out.println("커넥션풀 얻기 실패 : " + e);
		}
		
	}//SawonDao()메소드 끝
	
	//DB로부터 모든 직원정보를 조회하여 얻는 메소드
	//	-> index.jsp에서 요청한 검색기준값과 검색어를 매개변수로 넘겨받아
	//		검색어를 입력하지 않았다면 모든든 직원을 검색하여 ArrayList에 담는다.
	//		그 후 ArrayList배열을 반환함.
	public ArrayList getList(String key, String text){	//검색기준값, 검색어를 매개변수로 받는다

		//검색한 모든 직원정보들을 저장할 가변길이 배열
		ArrayList list = new ArrayList();
		
		//조건에 따라 SELECT문장을 저장할 변수 선언
		String sql = "";
		
		try {
			//1. 커넥션풀로부터 커넥션 객체 빌려오기
			con = pool.getConnection();		//DB연결
			//2. SQL문 만들기
			//	검색어가 입력되었는지 파악해서 SELECT 문장 완성
			if(text == null || text.isEmpty())	//검색어를 입력하지 않았다면,
				sql = "SELECT * from TBLSAWON";	//모든 직원을 검색하자
			else								//검색어를 입력했다면,
				sql = "SELECT * from TBLSAWON where "+key+ " like '%"+text+"%'";//검색기준필드에 해당하는 검색어를 포함하는 
																				//모든 레코드 검색SQL문 만들기
			
			//3. SQL문장을 실행할 PrepareStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			
			//4. SQL문장 실행
			rs = pstmt.executeQuery();
			
			//5. 조회한 데이터들을 ResultSet객체에서 한줄 단위로 얻어 new SawonDto()객체의 각 변수에 저장 후
			//	각각의 new SawonDto()객체들을 ArrayList배열에 담아서 추가
			while (rs.next()) {
				//5-1. ResultSet객체에 저장된 한 줄의 직원정보 꺼내오기
				int no = Integer.valueOf(rs.getInt("no"));
				String id = rs.getString("id");
				String name = rs.getString("name");
				String pw = rs.getString("pass");
				int age = rs.getInt("age");
				String addr = rs.getString("addr");
				String ext = rs.getString("extension");
				String dept = rs.getString("dept");
				
				//5-2. 조회된 한 줄의 직원정보를 SawonDto객체의 각 변수에 저장
				SawonDto dto = new SawonDto();
				
					//setter메소드들을 호출하여 SawonDto객체의 각 변수에 저장
					dto.setAddr(addr);
					dto.setAge(age);
					dto.setDept(dept);
					dto.setExtension(ext);
					dto.setId(id);
					dto.setName(name);
					dto.setNo(no);
					dto.setPass(pw);
				
				//5-3. ArrayList배열에 SawonDto객체 추가
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("getList메소드 내부에서 오류 : " + e);
		} finally {
			//6. 자원해제(Connection객체를 DBConnectionMgr커넥션풀로 반납)
			pool.freeConnection(con, pstmt, rs);
		}
		
		//7. ArrayList배열을 index.jsp로 리턴(반환)
		return list;
	}//getList()메소드 끝
	

	//addSawon_proc.jsp페이지에서 호출하는 메소드로
	//DB에 추가할 정보를 담은 SawonDto객체를 매개변수로 전달받아
	//전달받은 객체의 각 변수의 정보를 얻어 insert문장을 완성한다.
	//완성된 insert문장을 DB에 전송해서 직원추가 시키는 메소드이다.
	public void setSawon(SawonDto dto){
		
		//INSERT문장 완성
		String sql = "INSERT INTO TBLSAWON(id, name, pass, age, addr, extension, dept)"
								  + "values(?, 	?, 	   ?, 	?, 	 ?, 	  ?, 	   ?)";
		
		try {
			//커넥션풀에서 커넥션 얻기
			con = pool.getConnection();
			// ? 기호에 해응되는 값을 제외한 전체 INSERT문자열을 저장하고 있는 PreparedStatement실행객체 얻기
			pstmt = con.prepareStatement(sql);
			// ? 기호에 해응되는 값들을 매개변수로 전달받는 new SawonDto객체의 각 변수에 저장된 값으로 설정
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setInt(4, dto.getAge());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getExtension());
			pstmt.setString(7, dto.getDept());
			
			//PreparedStatement실행객체에 로딩된 INSERT전체문장을 DB에 전송해서 실행!
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("setSawon메소드 내부에서 오류 : " + e);
		} finally {
			//자원해제
			pool.freeConnection(con,pstmt);
		}
		
	}//setSawon메소드 끝	//addSawon_pro.jsp로 다시 간다.
	
	//직원 수정 전 직원 한 사람의 정보를 검색하기 위한 메소드
	public SawonDto getSawon(int no){
		//매개변수로 전달받는 직원번호에 해당되는 한 사람의 정보를 검색하는 SELECT문 만들기
		String sql = "SELECT * FROM TBLSAWON WHERE no = ?";
		
		//검색한 한 사람의 정보를 저장할 SawonDto객체 생성, 참조변수이름 dto
		SawonDto dto = new SawonDto();
		
		try {
			//커넥션풀 내부에 있는 DB와 미리 연결을 맺은 Connection객체 얻기
			con = pool.getConnection();
			//? 기호에 대응되는 값을 제외한 SELECT구문을 실행할 PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			//? 기호에 대응되는 값을 PreparedStatement객체에 설정
			pstmt.setInt(1, no);
			//PreparedStatement객체를 이용해 SELECT문장을 DB에 전송하여 실행후
			//검색한 데이터를 ResultSet에 저장하여 반환받기
			rs = pstmt.executeQuery();

			//ResultSet객체 공간에 검색한 한 줄이 존재하면?
			if(rs.next()){
				//ResultSet객체 공간에서 검색한 한 줄 정보를 꺼내어 SawonDto객체의 각 변수에 저장
				dto.setAddr(rs.getString("addr"));
				dto.setAge(rs.getInt("age"));
				dto.setDept(rs.getString("dept"));
				dto.setExtension(rs.getString("extension"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNo(no);
				dto.setPass(rs.getString("pass"));
			}
		} catch (Exception e) {
			System.out.println("getSawon메소드내부에서 오류 : " + e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		//SawonDto객체 리턴		//modifySawon.jsp로
		return dto;
		
	}//getSawon메소드 끝
	
	//매개변수로 전달받은 입력한 수정할 내용을 DB에 UPDATE할 메소드
	public void modifySawon(SawonDto dto){
		//매개변수로 전달받은 SawonDto객체의 no변수에 저장된 직원번호에 해당되는 직원의 정보 수정
		String sql = "UPDATE TBLSAWON SET id=?, pass=?, name=?, age=?, addr=?, extension=?, dept=? where no=?";
		
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setInt(4, dto.getAge());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getExtension());
			pstmt.setString(7, dto.getDept());
			pstmt.setInt(8, dto.getNo());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("modifySawon메소드내부에서 오류 : " + e.getMessage());
		} finally {
			pool.freeConnection(con,pstmt);
		}
		
	}//modifySawon메소드 끝
	
	//매개변수로 전달받은 직원 no에 해당되는 레코드 삭제하는 메소드
	public void delSawon(int no){
		
		String sql = "DELETE FROM TBLSAWON WHERE no = ?";
		
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("delSawon메소드 내부에서 오류 : " + e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}//delSawon메소드 끝
	
}//SawonDao클래스 끝
