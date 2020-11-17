package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//서버페이지 : 서블릿
//클라이언트페이지인 ajax1.html페이지에서 Ajax기술로 메세지를 요청하면 처리하는 서블릿.
//웹브라우저에서 매개변수 이름인 param으로 데이터를 보내면 getParameter()메소드를 이용해 요청한 데이터를 가져온다.
//그리고 서블릿에서는 PrintWriter객체의 print()메소드의 인자로 응답메세지를 웹브라우저로 내보낸다.
//웹브라우저로 내보낸 응답메세지는 웹브라우저를 거쳐 요청한 ajax1.html의 $.ajax메소드의 success속성에 전달됨
@WebServlet("/ajaxTest2")
public class AjaxTest2 extends HttpServlet {
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

		//도서 정보를 .xml파일의 데이터형식의 문자열로 만들어서 변수에 저장
		String result = "";
		
		//도서정보를 xml데이터형식의 문자열로 만들어 result변수에 누적!
		result ="<main>" +
					"<book>" +
						"<title><![CDATA[JAVA의 정석]]></title>" +
						"<writer><![CDATA[저자 | 남궁성]]></writer>" +
						"<image><![CDATA[http://localhost:8080/pro14/image/image1.jpg]]></image>" +
					"</book>" +
				"</main>" +
				"<main>" +
					"<book>" +
						"<title><![CDATA[JSP 2.3 & Servlet 3.1]]></title>" +
						"<writer><![CDATA[저자 | 오정원]]></writer>" +
						"<image><![CDATA[http://localhost:8080/pro14/image/image2.jpg]]></image>" +
					"</book>" +
				"</main>";
		
		
		//클라이언트의 웹브라우저로 응답할(출력할) 스트림통로 객체 생성
		PrintWriter writer = response.getWriter();
		
		//PrintWriter객체의 print()함수를 이용해 클라이언트의 웹브라우저로 응답할 메세지를 보냄
		writer.print(result);	//웹브라우저는 전달받은 result변수의 값을
								//ajax2.html $.ajax메소드의 success속성의 function매개변수로 응답메세지 전달함
	}
}

