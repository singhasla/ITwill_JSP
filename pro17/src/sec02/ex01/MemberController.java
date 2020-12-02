package sec02.ex01;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//컨트롤러 역할을 하는 MemberController서블릿클래스.
//이컨트롤러 클래스에서는  request객체의 getPathInfo()메소드를 이용해
//두 단계로 이루어진 요청주소를 가져옵니다.
//action변수값에 따라  if문을 분기해서 요청한 작업을 수행합니다.

@WebServlet("/member/*") //웹브라우저를 통해 요청시  두 단계로 요청이 이루어집니다.
public class MemberController extends HttpServlet{

	MemberDAO memberDAO;
	
	//init()메소드에서 MemberDAO객체를 생성하여 초기화시킴
	@Override
	public void init() throws ServletException {
		memberDAO = new MemberDAO();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doHandle(req, resp);
	}
	
	protected void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//인코딩 방식 UTF-8로 설정
		req.setCharacterEncoding("utf-8");
		//웹브라우저로 응답할 MIME-TYPE설정(데이터유형 설정)
		resp.setContentType("text/html; charset=utf-8");
		
		//request객체의 getPathInfo()메소드를 호출해  
		//요청한 전체 URL주소중에서 .. 2단계 요청 주소를 얻는다
		String action = req.getPathInfo();  // /memberForm.do
		System.out.println("action변수에 저장된 요청한 주소 : " + action);
		
		//MVC 중 View화면 주소를 변수에 저장하기 위한 변수 선언
		String nextPage = null;
		
		//action변수에 값에 따라 if문을 분기해서 요청한 작업을 수행하는데..
		//만약 action변수의 값이 null이거나  /listMembers.do인 경우에는
		//회원 검색 기능을 수행합니다.
		//-> 회원 조회 기능 요청이 들어 오면(/listMembers.do)
		if(action == null || action.equals("/listMembers.do")){
			//MemberDAO객체의 listMembers()메소드를 호출하여
			//클라이언트의 회원조회 요청에 대해 DB로부터 조회한 회원정보들을
			//각각  MemberBean객체에 저장후  각각의 MemeberBean객체들을
			//ArrayList배열에 추가로 저장후  ArrayList배열을 반환 받는다.
			//참고 : ArrayList배열에 저장된 데이터들은 (웹브라우저로 응답할 응답데이터 이다.)
			//     ArrayList배열 ->  MVC ->  Model 
			List membersList = memberDAO.listMembers();
			
			//이때 request내장객체 메모리영역에 조회된 모든 회원정보(ArrayList배열)
			//들을 키-값 쌍으로 묶어서 저장
			req.setAttribute("membersList", membersList);
			
			//검색한 회원정보(웹브라우저로 응답할 메세지)을 보여줄 View페이지 주소 설정
			// test02폴더의 listMembers.jsp로 포워딩 (재요청)하기 위해 View페이지 주소저장
			nextPage = "/test02/listMembers.jsp";
			
		//listMembers.jsp페이지의 하단에 <a>회원가입</a>링크를 클릭했을때.....
		///memberForm.do <--회원가입 페이지로 이동 시켜줘~~ 라는 요청 주소를 받았을때...
		}else if(action.equals("/memberForm.do")){
			
			//회원가입 입력창으로 포워딩할 주소 설정
			nextPage = "/test02/memberForm.jsp";

		}
		

		RequestDispatcher dispatcher = 
				req.getRequestDispatcher(nextPage);
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(req, resp);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



