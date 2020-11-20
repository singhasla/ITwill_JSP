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

//json6.jsp에서 요청
@WebServlet("/json2")
public class JsonServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JsonServlet2() {
    	
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
    	

    	
    	//배열을 저장할 JSONObject객체 생성
    	JSONObject totalObject = new JSONObject();
    	
    	//HashMap의 구조와 같은 JSONObject객체들을 저장할 JSONArray배열 생성
    	JSONArray membersArray = new JSONArray();
    	
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
		 
		 //totalObject참조변수에 저장된 JSONObject객체를 문자열로 변환하여 저장
		 String jsonInfo = totalObject.toJSONString();

		 System.out.println(jsonInfo);
		 /*
		  * '{"members":[{"gender":"남자","name":"박지성","nickname":"날쌘돌이","age":"25"},{"gender":"여자","name":"김연아","nickname":"칼치","age":"20"}]}'
		  */
		 
		 //문자열로 변환된 JSONObect객체 데이터를 웹브라우저를 거쳐서 json6.jsp의 $.ajax메소드로 응답함
		 writer.print(jsonInfo);
    }

}
