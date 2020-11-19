package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//자바빈 클래스의 종류중 DAO역할을 하는 클래스
//DB연결 후 작업하는 클래스 (비즈니스로직을 처리하는 클래스)
public class BoardDAO {
	
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
	
	//DB에 새글 추가 메소드
	public void insertBoard(BoardBean bBean){
		
		//DB에 추가할 글번호를 저장할 변수 
		int num = 0;
		
		//SQL문 저장할 변수선언
		String sql = "";
		
		try {
			//커넥션풀에서 커넥션객체 얻기(DB연결)
			con = getConnection();
			
			//DB에 저장된 글의 가장 최신 글번호 검색해 오는 SELECT문
			sql = "select max(num) from board";
			//참고 : DB에 글이 저장되어 있지 않는경우  새로추가할 글번호 는? 1
			//      DB에 글이 저장되어 있는 경우  검색한 가장 최신글번호 + 1 데이터를 새로추가할 글번호로 지정
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){//가장 최신 글번호가 검색된다면?
				//가장최신 글번호  + 1 데이터를 새로 추가할 글번호로 지정
				num = rs.getInt(1) + 1;
			}else{//가장 최신 글번호가 검색되지 않으면?(DB에 글이 없다면)
				num = 1; //새로추가할 글번호를 1로 설정 
			}
			
			sql = "insert into board(num,name,passwd,"
				+ "subject,content,re_ref,re_lev,re_seq,readcount,date,ip)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?);";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//추가할 새글의 글번호
			pstmt.setString(2, bBean.getName());//새글을 작성한 사람의 이름(id)
			pstmt.setString(3, bBean.getPasswd());//추가할 새글의 비밀번호
			pstmt.setString(4, bBean.getSubject());//추가할 새글의 제목
			pstmt.setString(5, bBean.getContent());//글내용
			pstmt.setInt(6, num); // 새글의 그룹번호는 새글의 글번호로 넣는다.
			pstmt.setInt(7, 0); //새글 (주글) 추가시 들여쓰기 정도값은 0으로 넣는다.
			pstmt.setInt(8, 0); //주글의 순서값 
			pstmt.setInt(9, 0); //추가하는 새글의 조회수 0
			pstmt.setTimestamp(10, bBean.getDate()); //새글을 추가한 날짜 정보 
			pstmt.setString(11, bBean.getIp());//새글을 작성한 사람의  IP주소 정보 
			
			//insert문장 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard메소드 내부에서 실행 오류 : " + e);
		} finally {
			자원해제();
		}	
	}//insertBoard메소드 끝
	
	
	//DB에 저장된 전체 글 개수를 검색해서 반환 해주는 메소드 
	public int getBoardCount(){
		
		int count = 0; //검색한 글개수를 저장할 변수 
		
		String sql = "";
		
		try {
			//DB연결
			con = getConnection();
			
			//전체 글수 조회 SELECT문장 만들기
			sql = "select count(*) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount에서 오류:" + e);
		}finally {
			자원해제();
		}
		return count;//조회한 글 개수 리턴 
		
	}//getBoardCount()메소드 끝
	
	//notice.jsp페이지에서 호출하는 메소드로
	//각페이지마다 첫번째로 보여질 시작글번호와  한페이지당 보여질 글 개수를 매개변수로 전달 받아
	//한페이지당 보여질 글개수만큼 검색해서 가져오는 메소드 
	public List<BoardBean>  getBoardList(int startRow,  int pageSize){
		
		String sql = "";
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection(); //DB연결
			//SELECT문장 만들기
			//정렬 re_ref 내림차순정렬 후 re_seq 오름차순정렬 하는데..
			//limt 각페이지마다 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수 
			sql = "select  * from board order by re_ref desc, re_seq asc limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				//BoardBean객체 => Arraylist배열에 추가
				boardList.add(bBean);
			}
			
		} catch (Exception e) {
			System.out.println("getBoardList메소드 내부에서 오류 : " + e);
		} finally{
			자원해제();
		}
		return boardList;//ArrayList리턴
	
	}//getBoardList메소드 끝
	
	//하나의 글을 클릭했을때  글번호를 매개변수로 전달 받아.
	//글번호에 해당되는 글 조회수 정보를 1 증가 (업데이트) 시키는 메소드
	public void updateReadCount(int num){
		String sql = "";
		try {
			//DB연결
			con = getConnection();
			//UPDATE구문 만들기-> 매개변수로 전달 받는 글번호에 해당되는 글의 조회수정보를 1증가(업데이트)
			sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount메소드에서 오류 : " + e);
		} finally{
			자원해제();
		}
	}//updateReadCount메소드 끝
	
	
	//글번호를 매개변수로 전달 받아 글번호에 해당되는 글의 정보를 검색 하는 메소드
	public BoardBean getBoard(int num){
		
		String sql = "";
		
		BoardBean bBean = new BoardBean();
		
		try {
			//DB연결
			con = getConnection();
			//SELECT문장 만들기 - 매개변수로 전달 받는 글번호에 해당되는 글정보검색
			sql = "select  * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
			}
		} catch (Exception e) {
			System.out.println("getBoard메소드에서 오류 :" + e);
		} finally {
			자원해제();
		}	
		return bBean;
	}//getBoard메소드 끝
		
	
	//삭제할 글번호와 글을 삭제하기 위해 입력했던 비밀번호를 매개변수로 전달받아..
	//삭제할 글번호에 해당되는 비밀번호를 검색하여
	//검색한 비밀번호와 입력했던 비밀번호가 동일하면 글을 DELETE합니다.
	//DELETE에 성공하면  check = 1 로 저장하여 반환 하고 
	//DELETE에 실패하면  check = 0 로 저장하여  deletePro.jsp로 반환함.
	public int deleteBoard(int num, String passwd){
		int check = 0;
		String sql = "";
		try {
			//DB연결
			con = getConnection();
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){//해당삭제할 글번호에 대한 글의 비밀번호가 검색되면
				//입력한 비밀번호와 검색한 글의 비밀번호가 동일 하면?
				if(passwd.equals(rs.getString("passwd"))){
					//check = 1;
					check = 1;
					//delete문장 작성
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}else{//입력한 비밀번호와 검색한 글의 비밀번호가 다르면?
					check = 0;
				}
			}		
		} catch (Exception e) {
			System.out.println("deleteBoard메소드 내부에서 오류 : " + e);
		} finally{
			자원해제();
		}		
		return check;//deletePro.jsp로 비밀번호 일치 유무 1 또는 0을 반환
	}//deleteBoard메소드 끝
	
	
	//수정을 위해 입력한 글정보가 저장된 BoardBean객체를 매개변수로 전달받아
	//UPDATE문장 완성후  DB와 연결하여 UPDATE구문 실행할 메소드
	//조건 : DB에 저장된 글의 비밀번호와 글을 수정하기 위해 입력한 비밀번호가 일치할때만 UPDATE함
	public int updateBoard(BoardBean bBean){
		int check = 0;
		String sql = "";
		
		try {
			//커넥션풀로 부터 커넥션객체(DB와 미리 연결을 맺은 접속을 나타내는 객체) 빌려오기
			con = getConnection();
			
			//BoardBean객체의 num변수에 저장된 글번호에 해당되는 비밀번호 검색하는 SELECT문
			sql = "select passwd from board where num=?";
			
			//select문장을  DB에 전송하여 실행할 PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			
			//?기호에 대응되는 값 설정
			pstmt.setInt(1, bBean.getNum());
			
			//위 select실행후 검색한 결과를 임시로 ResultSet객체에 저장후 ResultSet객체 반환 받기
			rs = pstmt.executeQuery();
			
			if(rs.next()){//글번호에 해당되는 글의 정보중 비밀번호가 검색되면
				//글수정을 위해 입력한 비밀번호와 검색한 글의 비밀번호를 비교해 동일하면
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;//비밀번호 맞음 ! 그러므로 수정을 해야함
					sql = "update board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					pstmt.executeUpdate();
				}else{//글수정을위해 입력한 비밀번호와 검색한 글의 비밀번호가 다를때
					check = 0;
				}
			}
		} catch (Exception e) {
			System.out.println("updateBoard메소드에서 오류 : " + e);
		} finally {
			자원해제();
		}
		return check;//updatePro.jsp로 check변수 값 0또는 1을 반환
	}
	
	
	/*
		답변 달기 규칙
		1. 답글 그룹번호(re_ref)는 주글의 그룹번호(re_ref)를 사용한다.
		2. 답글의 같은 그룹의 글들의 내의 순서값(re_seq)은  주글의 re_seq에서 + 1증가 한값을 넣어준다
		3. 답글의 들여쓰기 정도값(re_lev)은 주글의 re_lev값에 +1 증가 한 값을 넣어서 사용한다.
		
		답변글을 DB에 INSERT하는 메소드 만들기
	*/
	
	public  void reInsertBoard(BoardBean bBean){//reWritePro.jsp에서 호출하는 메소드로 ~~
		
		String sql = "";
		
		//답글의 글번호를 만들어저 저장할 변수 
		int num = 0;
		
		try {
			//DB연결
			con = getConnection();
			//답변글 글번호를 구하기위해  DB에 저장된 가장 최신글번호 얻기 (SELECT문)
			sql = "SELECT max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){//최신글번호가 검색된다면
				//답변글의 글번호 = 검색한 최신글번호 + 1
				num = rs.getInt(1)  + 1;
			}else{//DB에 글이 없다면
				num = 1;
			}
			
			//re_seq 답글들내의 순서 재배치
			//주글의 그룹과 같은 그룹이면서  주글의 seq값보다 큰 답변글들은? seq값을 1증가 시킨다.
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref());//주글의 그룹번호
			pstmt.setInt(2, bBean.getRe_seq());//주글의 글입력순서
			pstmt.executeUpdate(); //update구문 실행!
			
			/*답변달기*/
			//insert
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//추가할 답변글의 글번호 
			pstmt.setString(2, bBean.getName());//답변글을 작성하는 사람의 이름 
			pstmt.setString(3, bBean.getPasswd());//답변글의 비밀번호
			pstmt.setString(4, bBean.getSubject());//답변글의 제목
			pstmt.setString(5, bBean.getContent());//답변글의 글내용
			pstmt.setInt(6, bBean.getRe_ref());//답변글의 그룹번호는 주글의 그룹번호를 사용
			pstmt.setInt(7, bBean.getRe_lev() + 1); //답변글의 들여쓰기정도값은 
													//주글의 들여쓰기정도값에  + 1 한값을 사용
			pstmt.setInt(8, bBean.getRe_seq() + 1);//답변글의 순서값은 주글의 re_seq + 1한값 사용
			pstmt.setInt(9, 0);//답변글을 조회한 조회수 0
			pstmt.setTimestamp(10, bBean.getDate());//답변글을 작성한 날짜및 시간정보 
			pstmt.setString(11, bBean.getIp());//답변글을 작성하는 클라이언트의 IP정보 
			
			pstmt.executeUpdate();//답변글을 DB에 INSERT
			
		} catch (Exception e) {
			System.out.println("reInsertBoard메소드에서 오류 : " + e );
		} finally {
			자원해제();
		}	
	}//reInsertBoard메소드 끝
	
}//BoardDAO클래스 끝












