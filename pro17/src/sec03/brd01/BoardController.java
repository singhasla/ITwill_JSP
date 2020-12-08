package sec03.brd01;

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

//@WebServlet("/board/*")
public class BoardController extends HttpServlet {

	// 재료준비
	BoardService boardService;
	ArticleVO articleVO;

	// 서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		boardService = new BoardService();
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
		// /listArticles.do얻기
		String action = request.getPathInfo();

		System.out.println("action변수 : " + action);

		List<ArticleVO> articlesList = null;

		if (action == null) {// 요청한 주소가 없을때..

			// 모든 회원정보 조회를 위한 호출
			// 리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList = boardService.listArticles();

			request.setAttribute("articlesList", articlesList);

			nextPage = "/board01/listArticles.jsp";

		} else if (action.equals("/listArticles.do")) {
			// 모든 글정보 조회를 위한 호출
			// 리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList = boardService.listArticles();

			request.setAttribute("articlesList", articlesList);

			nextPage = "/board01/listArticles.jsp";
		}

		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);

	}

}