package sec01.ex01;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//MVC중에 C역할을 하는 서블릿

//회원정보 조회요청 순서!
//순서1. 클라이언트가 웹브라우저 주소창에  
//      http://localhost:8080/pro17/mem.do 주소를 입력하여 
//      MemberController서블릿 으로 회원정보 조회 요청을 한다.

//순서2. 조회요청을 받은 서블릿은  MemberDAO객체의 listMembers()메소드를 호출하여
//      DB와 연결 하여 모든 회원정보 조회요청을 다시 전달!!

@WebServlet("/mem.do")
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
		
		//그런다음 RqeustDispatcher클래스를 이용해 
		//회원목록창(listMembers.jsp)으로 포워딩함
		RequestDispatcher dispatcher = 
				req.getRequestDispatcher("/test01/listMembers.jsp");
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(req, resp);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



