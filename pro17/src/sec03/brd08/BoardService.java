package sec03.brd08;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//BoardController서블릿으로 부터 호출되는 메소드들이 들어 있는 서비스를 제공하는 클래스 
public class BoardService {
	
	BoardDAO boardDAO;
	
	public BoardService() {//생성자 호출시..BoardDAO객체 생성후 저장 
		boardDAO = new BoardDAO();
	}
		
	//답글 정보(ArticleVO객체정보)를 매개변수로 전달 받아....
	//답글 정보를 DB에 추가 하기 위해  BoardDAO객체의 insertNewArticle()메소드 호출시 인자로 전달하여 insert명령함
	public int addReply(ArticleVO  article){
		
		//답글정보를 DB에 insert시킨후  insert시킨 답글의 글번호를 반환 받아 BoardController서블릿으로 다시 반환!!
		return	 boardDAO.insertNewArticle(article);
		 
	}
	
	
	
	//컨트롤러에서 modArticle()메소드를 호출하면 다시 BoardDAO객체의 updateArticle메소드를 호출하면서 수정할 데이터를 전달 합니다.
	public void modArticle(ArticleVO article){
		
		boardDAO.updateArticle(article);
		
	}
	
	
	
	//BoardController에서 호출한 메소드로서....
	//글쓰기 창에서 입력된 정보를 ArticleVO객체에 저장한후 매개변수로 전달받아
	//다시~ BoardDAO객체의 insertNewArticle()메소드를 호출하면서 추가할 새글정보(ArticleVO)를 인자로 전달하여
	//DB에 INSERT작업을 하게됨
	public int addArticle(ArticleVO article){
		
		//새글 정보를 DB에 INSERT한후 새글정보중 새글의 글번호를 조회해서 반환 받아..
		//다시~~  BoardController서블릿으로 리턴(반환)해준다.
		return  boardDAO.insertNewArticle(article);
		
	}
	
	

	
	
	//BoardController서블릿으로 부터 호출되는 listArticles메소드 만들기
	//-> 페이징 기능에 필요한 글 목록과 전체 글수를 각각 조회할수 있도록 다음과 같이 구현합니다
	//-> HashMap을 생성 한후  조회한 두정보를 각각  속성으로 저장합니다.
	public Map listArticles(Map pagingMap){ //<---단위기능 : 모든회원조회기능
		
		Map articlesMap = new HashMap();
		
		//매개변수로 전달 받은 해쉬맵(section,pageNum)을 BoardDAO객체의 메소드 호출시 전달하여  조회작업함
		List<ArticleVO> articlesList = boardDAO.selectAllArticles(pagingMap);
		
		//t_board테이블에 존재하는 전체 글 개수를 조회합니다
		int totArticles = boardDAO.selectTotArticles();
		
		//조회된 글목록 ArrayList를  HashMap에 저장
		articlesMap.put("articlesList", articlesList);
		//조회된 전체 글수를  HashMap에 저장
		articlesMap.put("totArticles", totArticles);
		
		//서블릿(BoardController)으로 해쉬맵을 반환
		return articlesMap;
	}

	//컨트롤러로부터 전달 받은 글번호로 다시 BoardDAO객체의  selectArticle()메소드를 호출해 글정보 검색해 옴
	public ArticleVO viewArticle(int articleNO) {
		
		//검색한(조회한) 글정보를 저장할 ArticleVO객체를 담을 변수 선언
		ArticleVO article = null;
		
		//글번호에 해당되는 글을 조회하여 ArticleVO객체의 각변수에 저장후 ArticleVO객체를 리턴 받음 
		article = boardDAO.selectArticle(articleNO);
		
		//ArticleVO(조회한 글의 정보)객체를 BoardController서블릿으로 리턴
		return article;
	}


	//BoardController서블릿클래스에서 removeArticle()메소드 호출시.. 매개변수articleNO로  삭제할 글번호를 전달 받아
	//BoardDAO객체의 selectRemoveArticles()메소드를 먼저 호출해  글 번호에 대한 글과 그 자식 글번호를 조회해서 가져온후 ArrayList배열에 저장한다
	//그런 다음 BoardDAO객체의 deleteArticle()메소드를 호출해  글번호에  대한 글과 자식글을 모두 삭제하고 삭제한 글번호를 리스트(ArrayList)를 
	//BoardController서블릿으로 반환 한다.
	public List<Integer> removeArticle(int articleNO) {
		
		//글을 삭제 하기 전에  삭제할 글번호를 selectRemoveArticles메소드로 전달하여
		//그 글과 자식글들의 글번호들을 조회한후 ArrayList배열에 담아 반환 받아 저장
		List<Integer> articleNOList = boardDAO.selectRemoveArticles(articleNO);
		
		//BoardDAO의 deleteArticle메소드를 호출하여 글번호에 대한 글과 자식글들을 모두 삭제 
		boardDAO.deleteArticle(articleNO);
		
		return articleNOList;//삭제한 글번호 목록을 컨트롤러로 반환 
	}			
	
}//BoardService클래스 끝
/*
	여기서 잠깐  쉬어 가기 !
	BoardDAO 클래스의 메소드 이름은  보통 각메소드들이 실행하는 SQL문에 의해 결정됩니다.
	예를 들어 selectAticles()메소드는 
	전체 글 정보를 조회하는 SQL문을 실행하므로 메소드 이름에 selectAll이 들어갑니다
*/



