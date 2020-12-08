package sec03.brd02;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//http://localhost:8080/pro17/board/listArticles.do로 모든 글정보조회 요청을 하여
//BoardController서블릿이 위 주소를 받아 처리

//컨트롤러 역할을 하는 BoardController 서블릿
//주요역할 : action변수에 저장된 요청주소값이 /articleForm.do이면 글쓰기 창 화면으로 이동해 웹브라우저에 표시하고,
//			action변수의 값이 /addArticle.do면 다음과정으로 새 글을 DB에 추가한다.
//			upload()메소드를 호출해 글쓰기 창에서 전송된 글 관련 정보를 Map에 key/value쌍으로 저장한다.
//			파일을 첨부한 경우 먼저 파일이름을 Map에 저장한 후 첨부한 파일을 저장소(폴더)경로에 업로드한다.
//			upload()메소드를 호출한 후에는 반환한 Map에서 새글 정보를 가져온다.
//			그런 다음 service클래스의 addArticle()메소드 호출시 인자로 새글 정보를 전달하면 새 글정보가 DB에 등록된다.

@WebServlet("/board/*")
public class BoardController extends HttpServlet {

	//새글 추가시 첨부할 이미지 저장위치의 경로를 상수로 선언한다
	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
			
			
	// 재료준비
	BoardService boardService;
	ArticleVO articleVO;

	// 서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		boardService = new BoardService();
		articleVO = new ArticleVO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 재요청(포워딩)할 요청주소를 저장할 변수
		String nextPage = "";

		// 요청한 전체 주소중에서 2단계 요청주소 얻기
		// http://localhost:8080/pro17/board/listArticles.do 주소중에서
		//	/listArticles.do얻기
		
		// 글쓰기 링크를 클릭했을때..
		// http://localhost:8080/pro17/board/articleForm.do
		//	/articleForm.do얻기
		String action = request.getPathInfo();

		System.out.println("action변수 : " + action);

		List<ArticleVO> articlesList = null;

		if (action == null) {// 요청한 주소가 없을때..

			// 모든 회원정보 조회를 위한 호출
			// 리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList = boardService.listArticles();

			request.setAttribute("articlesList", articlesList);

			nextPage = "/board02/listArticles.jsp";

		} else if (action.equals("/listArticles.do")) {
			// 모든 글정보 조회를 위한 호출
			// 리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList = boardService.listArticles();

			request.setAttribute("articlesList", articlesList);

			nextPage = "/board02/listArticles.jsp";
			
		//조회된 글 목록창에서 글쓰기 <a>태그를 클릭해 요청받은 주소가 /articleForm.do이면
		//(글쓰기 디자인 화면으로 이동하라는 요청주소를 받았을때)
		} else if (action.equals("/articleForm.do")) {
			nextPage = "/board02/articleForm.jsp";
		}

		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);

	}

}