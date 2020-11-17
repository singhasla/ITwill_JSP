package sec02.ex02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//memberInfo.html로부터 회원정보 조회요청을 받은 서블릿
//서버페이지 : 서블릿
@WebServlet("/mem2")
public class MemberServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		//응답할 데이터 형식 지정
		response.setContentType("text/html;charset=utf-8");

		//클라이언트의 웹브라우저로 응답할(출력할) 스트림통로 객체 생성
		PrintWriter writer = response.getWriter();
		
		
		//1. 요청한 값 얻기 (회원정보를 조회하는 요청주소를 받음)
		//"http://localhost:8080/pro14/mem2"
		
		//2. 응답할 값 마련
		//	DB에 저장된 모든 회원정보를 조회해오기 위해 MemberDAO객체의 listMembers()메소드 호출하여
		//	조회된 회원 한 사람의 정보씩 -> MemberBean객체에 각각 저장후
		//  각각의 MemberBean객체들을 ArrayList가변길이 배열에 담아 ArrayList배열 반환 받기
		MemberDAO memberDAO = new MemberDAO();
		
		List membersList = memberDAO.listMembers();
		
		//XML데이터 형식의 문자열로 만들어서 저장할 변수
		String result = null;
		
		//조회한 회원정보를 XML형식의 문자열로 만들어 저장
		result = "<main>";
		
		for(int i=0; i<membersList.size(); i++){
			
			//ArrayList배열에 각 인덱스 위치에 저장된 MemberBean객체(조회한 회원 한 명의 정보)를 꺼내와
			//XML데이터 형식으로 만들어주자
			MemberBean m = (MemberBean)membersList.get(i);
			result += "<member>"
						+ "<id>" + m.getId() + "</id>"
						+ "<pwd>" + m.getPwd() + "</pwd>"
						+ "<name>" + m.getName() + "</name>"
						+ "<email>" + m.getEmail() + "</email>"
						+ "<date>" + m.getJoinDate() + "</date>"
					+ "</member>";
		}
		
		result += "</main>";
		
		//확인용....
		System.out.println(result);
		
		
		//3. 응답 -> 웹브라우저를 거쳐 -> ajax기술로 요청한 memberInfo.html로 전달
		writer.print(result); 
		
	}
}

