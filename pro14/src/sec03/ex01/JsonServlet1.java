package sec03.ex01;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@WebServlet("/json")
public class JsonServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JsonServlet1() {
    	
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
    	
    	//json5.jsp요청하는 페이지에서 AJAX통신을 이용하여 요청한 요청값 얻기
    	//	- AJAX로 전달된 JSONObject객체 형태의 문자열을 getParameter메소드를 호출해 얻기
    	String jsonInfo = request.getParameter("jsonInfo");
    					//'{"name":"박지성","age":"25","gender":"남자","nickname":"날쌘돌이"}'
    	
    	try {
			//참고 : JSONParser클래스는 JSONObject객체 형태의 문자열을 파싱(추출)해서
    		//		 JSONObject객체로 변환하는 기능을 제공한다.
    		
    		//JSONObject객체 형태의 문자열을 파싱해서 JSONObject객체로 변환할 객체 생성
    		JSONParser jsonParser = new JSONParser();
    		
    		//parse(jsonInfo)메소드를 호출하면
    		//JSONObject객체형태의 문자열을 파싱해서 JSONObject객체로 변환해서 반환함
    		JSONObject jsonObject = (JSONObject)jsonParser.parse(jsonInfo);
    		
    		
    		System.out.println("* JSONObject객체 내부에 저장된 회원정보를 얻어 출력");
    		
    		//JSONObject객체내부의 name속성들을 get()메소드 호출시 전달하면 value를 얻을 수 있다.
    		String name = (String)jsonObject.get("name");
    		System.out.println(name);
    		
    		String age = (String)jsonObject.get("age");
    		System.out.println(age);
    		
    		System.out.println(jsonObject.get("gender"));
    		
    		System.out.println(jsonObject.get("nickname"));
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
	}

}
