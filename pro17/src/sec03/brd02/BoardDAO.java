package sec03.brd02;

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

//DB작업 하는 클래스 
public class BoardDAO {

	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() { //커넥션풀 얻기 
		try{
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			//컥넥션풀 (DataSource) 얻기
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
		
		}catch(Exception e){
			System.out.println("커넥션풀 얻기 실패:" + e.toString());
		}
	}//생성자 끝
	
	//참고 : insertNewArticle()메소드의 SQL문을 실행하기 전에 getNewArticleNo()메소드를 호출해
	//     추가할 새글에 대한 글번호를 먼저 가져옵니다
	
	//DB에 새글을 추가하기 전에 ..DB에 존재하는 가장 최신글번호를 검색해서 제공해주는 메소드
	private int getNewArticleNO(){
		try{
			//커넥션풀로부터 커넥션 얻기 (DB연결)
			conn = dataFactory.getConnection();
			//기본들 번호 중에서 가장 큰 글번호를 조회하는 SQL문
			String query = "SELECT max(articleNO) from t_board";
			pstmt = conn.prepareStatement(query);		
			rs = pstmt.executeQuery();
			if(rs.next()){//최신 글번호(가장 큰 글번호)가 검색되었다면
				//가장 큰 글번호에 + 1을 더한 값을 리턴 합니다. 이유 : 새글을 추가하기 위함
				return (rs.getInt(1) + 1);
			}		
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}//getNewArticleNO메소드 끝
	
	
	//DB에 새글을 추가하는 메소드
	//insertNewArticle메소드의 SQL문(insert문)을 실행하기 전에 바로위의 getNewArticleNO()메소드를 호출해
	//DB에 추가할 새글번호(최신글번호 + 1)를 얻어 옵니다.
	public void insertNewArticle(ArticleVO article){
		
		try{
			//커넥션풀로 부터 커넥션 얻기 (DB연결)
			conn = dataFactory.getConnection();
			//DB에 추가할 새글의 글번호를 얻어옵니다
			int articleNO = getNewArticleNO();
			int parentNO = article.getParentNO();
			String title = article.getTitle();
			String content = article.getContent();
			String id = article.getId();
			String imageFileName = article.getImageFileName();
			//insert문장 만들기
			String query = "INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, id)"
					     + "VALUES(?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, articleNO);
			pstmt.setInt(2, parentNO);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, imageFileName);
			pstmt.setString(6, id);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}//finally끝
		
	}//insertNewArticle메소드 끝
	

	
	//BoardService클래스에서 BoardDAO의  selectAllArticles()메소드를 호출하면
	//계층형 SQL문을 이용해 계층형 구조로 전체 글을 조회한후 조회된 정보들을 ArrayList에 담아 반환해주는 메소드
	public List selectAllArticles(){
		//조회된 글의 정보들을 저장할 ArrayList배열 생성
		List articlesList = new ArrayList();
		
		try{
			//커넥션풀로 부터 커넥션 얻기(DB접속)
			conn = dataFactory.getConnection();
			//계층형 구조로 전체 글을 조회하는 오라클의 SQL문 만들기
			String query = "SELECT LEVEL,articleNO,parentNO,title,content,id,writeDate"
					     + " from t_board"
					     + " START WITH parentNO=0"
					     + " CONNECT BY PRIOR articleNO=parentNO"
					     + " ORDER SIBLINGS BY articleNO DESC";
			
			System.out.println(query);
			
			/*
			 	위 SELECT구문 참고 설명
			 	
			 	1. 먼저 START WITH parentNO=0  
			 	 -> parentNO의 값이 0인 글이 최상위 계층이다라는 의미 입니다.
			 	 -> parentNO가 0이면 그글 은 최상위 부모글이 되는 겁니다.
			 	 
			 	2. CONNECT BY PRIOR articleNO=parentNO 
			 	-> 각 글이 어떤 부모글과 연결되는지 나타냅니다.
			 	
			 	3. ORDER SIBLINGS BY articleNO DESC
			 	-> 계층구조로 조회된 글을 articleNO글번호를 기준으로 내림차순 정렬해서 다시 조회
			 
			 	4. select문의 LEVEL컬럼은 계층형 SQL문 실행시.. 
			 	   CONNECT BY PRIOR articleNO=parentNO 로 글이 나열되면서 각글의 깊이를 나타냅니다.
			 	      오라클에서 알아서 부모글에 대해서 깊이를 계산해서 LEVEL컬럼의 값으로 반환합니다.
			 
			 	5. 따라서 계층형 SQL문을 실행하면 오라클이 전체 글에 대해서 내부적으로 모든 글의 articleNO에 대해
			 	      다른 글들의 parentNO와 비교해서 같으면 그 글들을  parentNO의 글 아래 정렬 한후,
			 	   articleNO의 내림차순으로 정렬 하는 과정을 거칩니다.
			 
			 */
			pstmt =conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int level = rs.getInt("level");//각 글의 깊이(계층)를  level변수에 저장
				int articleNo = rs.getInt("articleNO");//글번호는 숫자형이므로 getInt()메소드로  가져옴
				int parentNO = rs.getInt("parentNO");//부모글번호
				String title = rs.getString("title");//글제목
				String content = rs.getString("content");//글내용
				String id = rs.getString("id");//글쓴이 id
				Date writeDate = rs.getDate("writeDate");//글쓴 날짜
				
				//검색할 글정보를 ArticleVO객체의 각변수에 저장
				ArticleVO article = new ArticleVO();
				article.setLevel(level);
				article.setArticleNO(articleNo);
				article.setParentNO(parentNO);
				article.setTitle(title);
				article.setContent(content);
				article.setId(id);
				article.setWriteDate(writeDate);
				
				//ArrayList배열에  new ArticleVO();객체추가
				articlesList.add(article);
				
			}//while반복문
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return articlesList;//ArrayList배열을 BoardService클래스로 리턴	
	
	}//selectAllArticles()메소드 끝
	
}//BoardDAO클래스 끝





