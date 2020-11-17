package sec02.ex01;

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
@WebServlet("/mem")
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
		
		
		//1. 요청한 값 얻기
		String id = request.getParameter("id");	//ajax3.html에 있는 data : { id: _id }안에 속성명"id"를 가리킴 (_id값을 불러옴) 
		
		//2. 응답할 값 마련
		//		(MemberDAO객체의 overLappedID(String id)메소드 호출시 입력한 아이디를 전달하여
		//		DB에 저장된 ID와 비교해서 중복되었는지 중복되지 않았는지 판단할 값을 얻어오자)
		MemberDAO memberDAO = new MemberDAO();
		
		//ID중복 여부를 체크하기 위해 메소드 호출 후 반환받기
		boolean overlappedID = memberDAO.overLappedID(id);
		
		//3. 응답 -> 웹브라우저를 거쳐 -> ajax기술로 요청한 ajax3.html로 전달
		if(overlappedID == true){	//아이디 중복일 경우
			writer.print("not_useable");
		} else {	//아이디 중복이 아닐 경우
			writer.print("useable");
		}
		
		
	}
}

