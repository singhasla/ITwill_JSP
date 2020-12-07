package sec02.ex02;

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


//memberForm.jsp페이지에서 가입할 회원정보를 모두 입력한후
//가입하기 버튼 눌렀을때........
//<form>태그의 action속성에 작성한 요청 주소  /member/addMember.do에 의해 회원추가 요청 을 받는 서블릿이다.

//modMemberForm.jsp페이지(수정창)에서 수정하기 전에 조회한 회원정보를 화면에서 보고
//수정할 내용을 입력한 후 ~ 수정하기 버튼을 클릭했을때...
//  /member/modMember.do에 의해 수정요청을 받는 MemberController서블릿 이다.

//delMember 삭제하는과정
//1. 회원목록창(listMembers.jsp)에서 사겢를 클릭해 요청명 /member/delMember.do주소와
//		삭제할 회원 ID를 컨트롤러로 전달
//2. 컨트롤러는 request객체의 getPathInfo()메소드를 이용해 요청명 /delMember.do을 가져옵니다.
//3. 삭제할 회원 ID를 SQL문으로 전달해 DELETE문 완성후 t_member테이블에 회원정보를 삭제합니다.
//4. DELETE에 성공하면 성공한 msg값을 request영역에 저장 후
//		다시 컨트롤러로 /member/listMembers.do요청명으로 재요청해 모든 회원정보 조회 후
//		listMembers.jsp로 포워딩하면서 조회된 회원목록을 출력합니다.



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
											// /addMember.do
											// /listMembers.do
											// /modMember.do
											// /delMember.do
		
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
			// test03폴더의 listMembers.jsp로 포워딩 (재요청)하기 위해 View페이지 주소저장
			nextPage = "/test03/listMembers.jsp";
			
		//listMembers.jsp페이지의 하단에 <a>회원가입</a>링크를 클릭했을때.....
		///memberForm.do <--회원가입 페이지로 이동 시켜줘~~ 라는 요청 주소를 받았을때...
		}else if(action.equals("/memberForm.do")){
			
			//회원가입 입력창으로 포워딩할 주소 설정
			nextPage = "/test03/memberForm.jsp";

		//DB에 새 회원정보 추가 요청이 들어 왔을때...
		}else if(action.equals("/addMember.do")){
			
			//입력한 회원정보들을 request객체영역에서 꺼내온다(요청한 정보 얻기)
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			//MemberVO객체 생성후  입력한 회원정보들을 각변수에 저장
			MemberVO memberVO = new MemberVO(id,pwd,name,email);
			
			req.setAttribute("msg", "addMember");
			
			//MemberDAO객체의 addMember(MemberVO  vo)메소드호출시....
			//MemberVO객체를 매개변수로 전달 하여  insert작업 수행!
			memberDAO.addMember(memberVO);
			
			//회원가입에 성공했을때  이동할 뷰페이지 주소를 저장
			nextPage = "/member/listMembers.do";
		
			
		//listMembers.jsp페이지에서 수정링클릭했을때....
		//컨트롤러에 회원정보 수정창 요청시 ID로 회원정보를 조회한후 수정창으로 포워딩한다.
		}else if(action.equals("/modMemberForm.do")){ 
			
			//수정할 회원 id를 request객체로부터 얻는다
			String id = req.getParameter("id");
			
			//회원정보 수정창을 요청하면서 전송된 ID를 이용해 수정 전 회원정보를 검색해 줍니다.
			MemberVO memInfo = memberDAO.findMember(id);
			
			//request객체 내부에 저장(바인딩)하여  회원정보 수정창으로 전송하여 이동~(재요청,포워딩)
			req.setAttribute("memInfo", memInfo);
			
			//회원정보 수정창 페이지로 포워딩 하기 위해 URL주소를 저장 
			nextPage = "/test03/modMemberForm.jsp";
			
		
		// modeMemberForm.jsp에서 수정할 내용을 입력하고 수정하기 버튼을 클릭해 수정요청 주소를 받았을때..	
		}else if(action.equals("/modMember.do")){
			
			//회원정보 수정창에서 수정을 위해 입력한 전송된  정보를 가져온후
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			//MemberVO객체의 각 변수에 저장
			MemberVO memberVO = new MemberVO(id, pwd, name, email);
			
			//MembeDAO객체의 modMember메소드 호출시..MemberVO객체를 전달 하여 UPDATE작업을 한다
			memberDAO.modMember(memberVO);
			
			//UPDATE작업후  수정성공<---메세지를   request내장객체 영역에 저장후 
			req.setAttribute("msg", "modified");
			
			//수정후 재요청하여 이동시킬 뷰의 주소를 nextPage변수에 저장
			nextPage = "/member/listMembers.do";
	
		} else if(action.equals("/delMember.do")){
			//삭제할 회원 ID를 request내장객체 영역에서 꺼내오기(요청값 얻기)
			String id = req.getParameter("id");
			
			//삭제할 회원 ID를 이용하여 DB의 t_member회원테이블의 데이터 삭제
			memberDAO.delMember(id);
			
			//삭제 후 회원목록창(listMembers.jsp)으로 삭제성공메시지 전달하기위해
			//request내장객체영역에 바인딩(저장)함.
			req.setAttribute("msg", "deleted");
			
			//삭제 후 모든 회원을 조회하는 요청을 서블릿으로 하기 위해..
			//nextPage변수에 요청주소 저장
			nextPage = "/member/listMembers.do";
			
		} else {
			List membersList = memberDAO.listMembers();
			req.setAttribute("membersList", membersList);
			nextPage = "/test/03/listMembers.jsp";
			
		}
		

		RequestDispatcher dispatcher = 
				req.getRequestDispatcher(nextPage);
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(req, resp);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



