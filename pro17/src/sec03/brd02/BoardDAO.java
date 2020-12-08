package sec03.brd02;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	
	public BoardDAO() { // new MemberDAO()객체 생성시 호출되는 기본생성자는
		// 커넥션풀(DataSource)를 받아와 저장시키는 용도이다
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			// 컥넥션풀 (DataSource) 얻기
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (Exception e) {
			System.out.println("커넥션풀 얻기 실패:" + e.toString());
		}
	}
	

	//BoardService클래스에서 BoardDAO의 selectAllArticles()메소드를 호출하면
	//계층형 SQL문을 이용해 계층형 구조로 전체 글을 조회한 후 조회된 정보들을 ArrayList에 담아 반환해주는 메소드
	public List selectAllArticles() {

		//조회된 글의 정보들을 저장할 ArrayList배열 생성
		List articlesList = new ArrayList();
		
		try {
			conn = dataFactory.getConnection();
			
			//계층형 구조로 전체글을 조회하는 오라클 SQL문 만들기
			String query = "SELECT LEVEL, articleNO, parentNO, title, content, id, writeDate"
						+ " from t_board"
						+ " START WITH parentNO=0"
						+ " CONNECT BY PRIOR articleNO=parentNO"
						+ " ORDER SIBLINGS BY articleNO DESC";
		/* 위 SELECT구문 참고 설명
	        SELECT문의 LEVEL은 계층형 SQL문 실행시, CONNECT BY PRIOR articleNO=parentNO로 
	                글이 나열되면서 각 글의 깊이를 나타낸다.
	                오라클에서 자동으로 부모글에 대해서 깊이를 계산해서 LEVEL컬럼의 값으로 반환한다.

	        - START WITH parentNO=0  : parentNO의 값이 0인 글이 최상위 계층(부모글)이다라는 의미.
	        - CONNECT BY PRIOR articleNO=parentNO  : parentNO가 어떤 부모글과 연결되는지를 나타낸다.
	        
	        따라서 계층형 SQL문을 실행하면 오라클이 전체글에 대해서 내부적으로 모든 글의 articleNO에 대해..
	        다른 글들의 parentNO와 비교해서 같으면 그 글들을 parenNO의 글 아래 정렬한 후
	    articleNO의 내림차순으로 정렬하는 
	    */
			
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int level = rs.getInt("level");	//각 글의 깊이(계층)를 level변수에 저장
				int articleNO = rs.getInt("articleNO"); //글 번호는 숫자형이므로...
				int parentNO = rs.getInt("parentNO");	//부모글번호
				String title = rs.getString("title");	//글제목
				String content = rs.getString("content");//글내용
				String id = rs.getString("id");	//글쓴이 id
				Date writeDate = rs.getDate("writeDate");//글쓴 날짜
				
				//검색할 글 정보를 ArticleVO객체의 각 변수에 저장
				ArticleVO article = new ArticleVO();
				article.setLevel(level);
				article.setArticleNO(articleNO);
				article.setParentNO(parentNO);
				article.setTitle(title);
				article.setContent(content);
				article.setId(id);
				article.setWriteDate(writeDate);
				
				//ArrayList배열에 new ArticleVO();객체 추가
				articlesList.add(article);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		
		return articlesList;	//ArrayList배열을 BoardService클래스로 리턴
	}//selectAllArticles메소드 끝

}
