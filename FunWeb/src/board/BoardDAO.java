package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.print.attribute.DateTimeSyntax;
import javax.sql.DataSource;

//자바빈 클래스의 종류 중 DAO역할을 하는 클래스
//DB연결 후 작업하는 클래스(비지니스로직을 처리하는 클래스)
public class BoardDAO {

	Connection con = null; // DB와 미리연결을 맺은 접속을 나타내는 객체를 저장할 조상 인터페이스 타입의 변수
	PreparedStatement pstmt = null; // DB(jspbeginner)에 SQL문을 전송해서 실행할 객체를 저장할
									// 변수
	ResultSet rs = null; // DB에 SELECT 검색한 결과데이터들을 임시로 저장해 놓을 수 있는
							// ResultSet객체를 저장할 변수

	// DataSource커넥션풀을 얻고
	// 커넥션풀 내부에 있는 Connection객체를 얻는 메소드
	private Connection getConnection() throws Exception {

		// 톰캣이 각 프로젝트에 접근할 수 있는 Context객체의 경로를 알고 잇는 객체
		Context init = new InitialContext();

		// DataSource커넥션풀 얻기
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/jspbeginner");

		// DataSource커넥션풀 내부에 있는 Connection객체 얻기
		con = ds.getConnection();

		return con;
	}// getConnection 메소드 끝

	public void 자원해제() {
		try {
			if (con != null) {	con.close();	}
			if (pstmt != null) {pstmt.close();	}
			if (rs != null) {	rs.close();		}
		} catch (Exception e) {
			System.out.println("자원해제 실패 : " + e);
		}
	}
	
	//DB에 새 글 추가 메소드
	public void insertBoard(BoardBean bBean){
		
		//DB에 추가할 글 번호를 저장할 변수
		int num =0;
		
		//SQL문 저장할 변수선언
		String sql = "";
		
		try {
			//커넥션풀에서 커넥션 객체 얻기(DB연결)
			con = getConnection();
			
			//DB에 저장된 글의 가장 최신 글번호를 검색해 오는 SELECT문
			sql = "select max(num) from board";
			
			// 참고 : 글이 저장되어 있지 않는 경우 새로 추가할 글번호는? 1
			//		글이 저장되어 있는 경우, 검색한 가장 최신 글번호+1
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){	//가장 최신 글 번호가 검색된다면?
				
				num = rs.getInt(1)+1;
			} else {		//최신 글 번호가 검색되지 않으면?
				num = 1;
			}
			
			sql = "INSERT INTO board(num, name, passwd, subject, content, re_ref, re_lev, re_seq, readcount, date, ip)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);					//추가할 새 글의 글 번호
			pstmt.setString(2, bBean.getName());	//새 글을 작성한 사람의 이름(ID)
			pstmt.setString(3, bBean.getPasswd());	//추가할 새 글의 비밀번호
			pstmt.setString(4, bBean.getSubject());	//추가할 새 글의 제목
			pstmt.setString(5, bBean.getContent()); //글 내용
			pstmt.setInt(6, num);					//새 글의 그룹번호는 새 글의 글번호로 넣는다.
			pstmt.setInt(7, 0);						//새 글 추가시 들여쓰기 정도값은 0으로 넣는다.
			pstmt.setInt(8, 0);						//주 글의 순서값
			pstmt.setInt(9, 0);						//추가하는 새 글의 조회수 0				
			pstmt.setTimestamp(10, bBean.getDate());//새 글을 추가한 날짜 정보
			pstmt.setString(11, bBean.getIp());		//새 글을 작성한 사람의 IP주소 정보
			
			//insert문 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard메소드 내부에서 오류 : " + e);
		} finally {
			자원해제();
		}
	}//insertBoard메소드 끝

	//DB에 저장된 전체 글 개수를 검색해서 반환해주는 메소드
		public int getBoardCount(){
		
			int count = 0;	//검색한 글 개수를 저장할 변수
			
			String sql = "";
			
			try {
				//커넥션풀에서 커넥션 객체 얻기(DB연결)
				con = getConnection();
				
				sql = "select count(*) from board";
				
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);
				}
				
			} catch (Exception e){
				System.out.println("getBoardCount메소드에서 오류 : " + e);
			} finally {
				자원해제();
			}
			
			return count;	//조회한 글 개수 리턴
			
		}//getBoardCount메소드 끝
		
		public ArrayList<E> getBoardList(){
			
			int num;
			String subject;
			String name;
			Timestamp date ;
			int readcount;
		
			String sql = "";
			
			try {
				con = getConnection();
				
			
				sql = "select num, subject, name, date, readcount from member";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
				/*	num = rs.getInt(1);
					subject = rs.getString(2);
					name = rs.getString(3);
					date = rs.getTimestamp(4);
					readcount = rs.getInt(5);*/
				}
				
			} catch (Exception e) {
				System.out.println("getBoardList메소드 내부에서 오류 :" + e);
			} finally {
				자원해제();
			}
			
			return list;
		}
}
