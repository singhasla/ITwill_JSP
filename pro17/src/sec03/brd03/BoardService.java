package sec03.brd03;

import java.util.List;

//BoardController서블릿으로 부터 호출되는 메소드들이 들어 있는 서비스를 제공하는 클래스 
public class BoardService {
	
	BoardDAO boardDAO;
	
	public BoardService() {//생성자 호출시..BoardDAO객체 생성후 저장 
		boardDAO = new BoardDAO();
	}
				
	//BoardController에서 호출한 메소드로서....
	//글쓰기 창에서 입력된 정보를 ArticleVO객체에 저장한후 매개변수로 전달받아
	//다시~ BoardDAO객체의 insertNewArticle()메소드를 호출하면서 추가할 새글정보(ArticleVO)를 인자로 전달하여
	//DB에 INSERT작업을 하게됨
	public int addArticle(ArticleVO article){
		
		//새 글 정보를 DB에 INSERT한 후 새 글 정보중 새 글의 글 번호를 조회해서 반환 받아
		//다시 BoardController서블릿으로 리턴해준다.
		return boardDAO.insertNewArticle(article);
		
	}
	
	
	//BoardController서블릿으로 부터 호출되는 listArticles메소드 만들기
	public List<ArticleVO> listArticles(){ //<---단위기능 : 모든회원조회기능
		//BoardDAO객체의 selectArticles()메소드를 호출해 전체글을 검색해옴
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		//서블릿으로 arrayList반환
		return articlesList;
	}			
	
}
/*
	여기서 잠깐  쉬어 가기 !
	BoardDAO 클래스의 메소드 이름은  보통 각메소드들이 실행하는 SQL문에 의해 결정됩니다.
	예를 들어 selectAticles()메소드는 
	전체 글 정보를 조회하는 SQL문을 실행하므로 메소드 이름에 selectAll이 들어갑니다
*/



