package sec03.brd02;

import java.util.List;

//BoardController서블릿으로부터 호출되는 메소드들이 들어있는 서비스를 제공하는 클래스
public class BoardService {

	BoardDAO boardDAO;
	
	public BoardService() {
		boardDAO = new BoardDAO();
	}
	
	
	//BoardController서블릿으로부터 호출되는 listArticles메소드 만들기
	public List<ArticleVO> listArticles() {

		//BoardDAO객체의 selectAllArticles()메소드를 호출해 전체글을 검색해 옴
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		
		//서블릿으로 arrayList반환
		return articlesList;
	}

}
/*
	여기서 잠깐 쉬어가기!
		BoardDAO클래스의 메소드 이름은 보통 각 메소드들이 실행하는 SQL문에 의해 결정된다.
*/