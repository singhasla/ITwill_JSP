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
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//응답할 데이터 형식 설정
		response.setContentType("text/html;charset=utf-8");
	
		//클라이언트의 웹브라우저로 응답할(출력할) 스트림통로 객체 생성
		PrintWriter writer = response.getWriter(); 
		
		//1.요청한값 얻기 (회원정보를 조회 하는 요청주소 http://localhost:8080/pro14/mem2를 받음)
		
		//2.응답할값 마련 
		//DB에 저장된 모든 회원정보를 조회해 오기 위해  MemberDAO객체의 listMembers()메소드 호출하여
		//조회된 회원 한사람의 정보씩 -> MemberBean객체에 각각 저장후
		//각각의 MemberBean객체들을 ArrayList가변길이 배열에 담아 ArrayList배열 반환 받기 
		MemberDAO memberDAO = new MemberDAO();
		
		List membersList = memberDAO.listMembers();
		
		//XML데이터 형식의 문자열로 만들어서 저장할 변수 
		String result = null;
		
		//조회한 회원정보를 XML형식의 문자열로 만들어 저장
		result = "<main>";
				
		for(int i=0;  i<membersList.size(); i++){
			//ArrayList배열에 각 인덱스 위치에 저장된  MembeBean객체(조회한 회원한사람의 정보)를  꺼내와
			//XML데이터 형식으로 만들어주자
			MemberBean m = (MemberBean)membersList.get(i);
			
			result += "<member>"+
					  	"<id>" + m.getId() + "</id>" + 
					  	"<name>" + m.getName() + "</name>" + 
					  	"<email>" + m.getEmail() + "</email>" + 
					  	"<date>" + m.getJoinDate() + "</date>" + 
					  	"<pwd>" + m.getPwd() + "</pwd>" + 
					  "</member>";	
		}
		
		result += "</main>";
		//확인을 위해 그냥 출력
		System.out.println(result);
//		<main>
//			<member>
//				<id>aasd</id>
//				<name>관리자</name>
//				<email>admin@naver.com</email>
//				<date>2020-10-27</date>
//				<pwd>1234</pwd>
//			</member>
//			<member>
//				<id>xcxcxc</id>
//				<name>관리자</name>
//				<email>admin@naver.com</email>
//				<date>2020-10-27</date>
//				<pwd>1234</pwd>
//			</member>
//			<member>
//				<id>master12</id>
//				<name>관리자</name>
//				<email>admin@naver.com</email>
//				<date>2020-10-27</date>
//				<pwd>1234</pwd>
//			</member>
//			<member>
//				<id>xcxc</id>
//				<name>관리자23</name>
//				<email>admin@naver.com</email>
//				<date>2020-10-27</date>
//				<pwd>1234</pwd>
//			</member>
//			... 총 12쌍 
//		</main>
			
		writer.print(result);
		
	}	
}






