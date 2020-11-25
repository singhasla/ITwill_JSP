package sec03.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


//json7.jsp페이지에서 AJAX기술을 이용해서 요청하는 서블릿
@WebServlet("/json4")
public class JsonServlet4 extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//웹브라우저로 응답할 데이터형식 지정, 응답할데이터 인코딩방식지정(한글처리)
		response.setContentType("text/html;charset=utf-8");
		//클라이언트의 웹브라우저로 출력할 스트림통로 역할을 하는 객체 얻기
		PrintWriter writer = response.getWriter();
		
				// Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링
				String url = "http://www.cgv.co.kr/movies/"; //크롤링할 url지정
				Document doc = null;        //Document에는 페이지의 전체 소스가 저장된다

				try {
					doc = Jsoup.connect(url).get();
					
				} catch (IOException e) {
					e.printStackTrace();
				}
				//select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
				Elements element = doc.select("div.sect-movie-chart");    

				System.out.println("============================================================");

				//Iterator을 사용하여 하나씩 값 가져오기
				Iterator<Element> ie1 = element.select("strong.rank").iterator();
				Iterator<Element> ie2 = element.select("strong.title").iterator();
				        
				while (ie1.hasNext()) {
					System.out.println(ie1.next().text()+"\t"+ie2.next().text());
				}
				
				System.out.println("============================================================");
	}

}










