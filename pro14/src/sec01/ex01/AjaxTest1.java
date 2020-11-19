package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//서버페이지 : 서블릿
//클라이언트페이지인 ajax1.html페이지에서 Ajax기술로 메세지를 요청하면 처리하는 서블릿입니다.
//웹브라우저에서 매개변수 이름인 param으로 데이터를 보내면  getParameter()메소드를 이용해 요청한 데이터를 가져옵니다
//그리고 서블릿에서는 PrintWriter객체의 print()메소드의 인자로 응답 메세지를 웹브라우저로 내보냅니다.
//웹브라우저로 내보낸 응답 메세지는 웹브라우저를 거쳐 요청한  ajax1.html의  $.ajax메소드의 success속성에 전달됨
@WebServlet("/ajaxTest1")
public class AjaxTest1 extends HttpServlet {
		
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
		//ajax1.html요청페이지로부터 전달 받은 데이터 얻기 
		//방법 : request객체의 getParameter()메소드 이용
		String param = request.getParameter("param");
		//클라이언트의 웹브라우저로 응답할(출력할) 스트림통로 객체 생성
		PrintWriter writer = response.getWriter(); 
		//PrintWriter객체의 print()함수를 이용해 클라이언트의 웹브라우저로 응답할 메세지를 내보냄
		writer.print("안녕하세요 서버페이지에서 응답하는 메세지 입니다!!");
		
	}	
}






