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

//json7.jsp에서 요청
@WebServlet("/json3")
public class JsonServlet3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JsonServlet3() {
    	
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doHandle(request, response);
	}
    
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doHandle(request, response);
	}
    
    protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	
    	response.setContentType("text/html;charset=utf-8");
    	
    	//클라이언트의 웹브라우저로 출력할 스트림 통로 역할을 하는 객체 얻기
    	PrintWriter writer = response.getWriter();
    	
    	/*	
    	 * 	{
    	 * 		"books":  [
    	 * 					{"image":"http://localhost:8080/pro14/image/image1.jpg","price":"30000","genre":"IT","writer":"남궁성","title":"자바의 정석"},
    	 * 					{"image":"http://localhost:8080/pro14/image/image2.jpg","price":"32000","genre":"IT","writer":"오정현","title":"JSP & Servlet"}
    	 * 				  ],
    	 * 		"members":[
    	 * 					{"gender":"남자","name":"박지성","nickname":"날쌘돌이","age":"25"},
    	 * 					{"gender":"여자","name":"김연아","nickname":"칼치","age":"20"}
    	 * 				  ],
    	 * 	}
    	 * 
    	 * */
    	
    	//배열 2개를 저장할 JSONObject객체 생성
    	JSONObject totalObject = new JSONObject();
    	
    	//HashMap의 구조와 같은 JSONObject객체들을 저장할 JSONArray배열 2개 생성
    	JSONArray membersArray = new JSONArray();
    	JSONArray booksArray = new JSONArray();
    	
    	//회원 한 명의 정보가 저장될 JSONObject객체 생성
    	JSONObject memberInfo = new JSONObject();
    	
			    	//회원 한명의 정보를 name/value 쌍으로 묶어서 저장함
			    	memberInfo.put("name", "박지성");
			    	memberInfo.put("age", "25");
			    	memberInfo.put("gender", "남자");
			    	memberInfo.put("nickname", "날쌘돌이");
			    	
			    	//회원 한명의 정보가 저장되어있는 JSONObject객체를? JSONArray배열에 추가하여 저장시킴
			    	membersArray.add(memberInfo);

			    	//////////////////////////////////////////////////////////////
		memberInfo = new JSONObject();
			    	
			    	//회원 한명의 정보를 name/value 쌍으로 묶어서 저장함
			    	memberInfo.put("name", "김연아");
			    	memberInfo.put("age", "20");
			    	memberInfo.put("gender", "여자");
			    	memberInfo.put("nickname", "칼치");
			    	
			    	membersArray.add(memberInfo);

    		
		totalObject.put("members", membersArray);
		 
////////////////////////////////////////////////////////////////////////////////////////////////////
		//책 한권 정보가 저장될 JSONObject객체 생성
	    JSONObject bookInfo = new JSONObject();
			    	//책 한권의 정보를 name/value 쌍으로 묶어서 저장함
			    	bookInfo.put("image", "http://localhost:8080/pro14/image/image1.jpg");
			    	bookInfo.put("price", "30000");
			    	bookInfo.put("genre", "IT");
			    	bookInfo.put("writer", "남궁성");
			    	bookInfo.put("title", "자바의 정석");
				    	
			    	//책 정보가 저장되어있는 JSONObject객체를? JSONArray배열에 추가하여 저장시킴
			    	booksArray.add(bookInfo);

			    	//////////////////////////////////////////////////////////////
		bookInfo = new JSONObject();
			    	//책 한권의 정보를 name/value 쌍으로 묶어서 저장함
			    	bookInfo.put("image", "http://localhost:8080/pro14/image/image2.jpg");
			    	bookInfo.put("price", "32000");
			    	bookInfo.put("genre", "IT");
			    	bookInfo.put("writer", "오정현");
			    	bookInfo.put("title", "JSP & Servlet");
				    	
			    	//책 정보가 저장되어있는 JSONObject객체를? JSONArray배열에 추가하여 저장시킴
			    	booksArray.add(bookInfo);

	    		
	    totalObject.put("books", booksArray);
		 
		 //참조변수에 저장된 JSONObject객체를 문자열로 변환하여 저장
		 String jsonInfo = totalObject.toJSONString();

		 System.out.println(jsonInfo);
		 /*
		  * '{"members":[{"gender":"남자","name":"박지성","nickname":"날쌘돌이","age":"25"},{"gender":"여자","name":"김연아","nickname":"칼치","age":"20"}]}'
		  */
		 
		 //문자열로 변환된 JSONObect객체 데이터를 웹브라우저를 거쳐서 json7.jsp의 $.ajax메소드로 응답함
		 writer.print(jsonInfo);
    }

}
