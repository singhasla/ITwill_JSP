package common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//viewArticle.jsp에서 전송된 글번호와 이미지 파일이름으로 파일경로를 만든 후, 해당 파일을 내려받는다.

@WebServlet("/download.do")
public class FileDownloadController extends HttpServlet{	//이미지를 다운받아 <img>에 제공해주는 클래스

	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
	
	@Override
	protected void doGet(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, 
			              HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}	
	
	protected void doHandle(HttpServletRequest request, 
			             	HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		//클라이언트의 웹브라우저 화면에 이미지의 내용을 읽어들여서 보여줘야하기 때문에..
		//response객체의 헤더정보를 text/html; charset=utf-8로 설정
		response.setContentType("text/html; charset=utf-8");
		
		//viewArticle.jsp페이지의 <img>태그로부터 요청받은 이미지파일명과 조회한 글의 글번호를 전달받아 저장
		String imageFileName = request.getParameter("imageFileName");
		String articleNO = request.getParameter("articleNO");
		
		//요청한 클라이언트의 웹브라우저와 연결된 출력스트림 통로 역할을 하는 객체 생성
		OutputStream out = response.getOutputStream();
		
		//글번호에 대한 파일 경로를 설정한다.
		String path = ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + imageFileName;
		
		File imageFile = new File(path);
		
		response.setHeader("Cache-Control", "no-cache");
		//이미지파일을 내려받는데 필요한 헤더정보 추가
		response.addHeader("Content-disposition", "attachment;filename="+imageFileName);
		//이미지파일에 접근해서 파일내용을 바이트 단위로 읽어들이기 위한 스트림 통로
		FileInputStream in = new FileInputStream(imageFile);
		
		//FileInputStream통로를 통해 이미지로부터 읽어들인 바이트데이터들을 저장할 배열생성
		byte[] buffer = new byte[1024 * 8];	//8kB
		
		while(true){	//무한반복해서 이미지파일의 바이트데이터를 8kB씩 읽어들여, 
						//출력스트림통로를 통해 웹브라우저로 8kB씩 내보내어 
						//미리보기 이미지화면이 조금씩조금씩 나오게 만들자
			int count = in.read(buffer);  	// read메소드 호출시.. byte배열 전달하여 
											// byte배열에 읽어들인 데이터를 저장한 후
											// 읽어들인 바이트 개수를 int로 반환한다.
											// 만약 파일로부터 데이터를 읽어들이지 못할 경우에는
											// read()메소드가 -1을 반환한다.
			
			//더이상 파일로부터 읽어들일 count변수에 값(바이트개수)이 없으면?
			if(count == -1){ break;	}
			
			//출력스트림통로 outputStream을 통해 FileInputStream통로로 읽어들인 데이터를 웹브라우저에 내보낸다.
			out.write(buffer, 0, count);
		}
		
		//입력스트림통로, 출력스트림통로 자원해제
		in.close();
		out.close();
		
	}
}
