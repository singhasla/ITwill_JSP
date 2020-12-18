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

//viewArticle.jsp에서 전송한 글번호와 이미지파일이름으로 파일 경로를 만든후  해당 파일을 내려 받습니다.

@WebServlet("/download.do")
public class FileDownloadController extends HttpServlet{ //이미지를 다운받아 <img>태그에 제공 해주는 클래스 

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
		//클라이언트의 웹브라우저 화면에 이미지의 내용을 읽어들여서 보여줘야 하기 떄문에 ...
		//response객체의 헤더 정보를  text/html; charset=utf-8로 설정
		response.setContentType("text/html; charset=utf-8");
		
		//viewArticle.jsp페이지의 <img>태그로 부터 요청받은  이미지파일명 과  조회한 글의글번호를 전달 받아 저장
		String imageFileName = request.getParameter("imageFileName");
		String articleNO = request.getParameter("articleNO");
		
		//요청한 클라이언트의 웹브라우저와 연결된 출력 스트림 통로 역할을 하는 객체생성
		OutputStream out = response.getOutputStream();
		
		//글번호에 대한 파일 경로를 설정 합니다
		String path = ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + imageFileName;
					  //C:\board\article_image\9\예6_13.jpg
		File imageFile = new File(path);
		
		response.setHeader("Cache-Control", "no-cache");
		//이미지 파일을 내려 받는데 필요한 response객체에 헤더 정보를 설정
		response.addHeader("Content-disposition", "attachment;filename=" + imageFileName);
		
		//이미지 파일에 접근해서 파일 내용을 바이트데이터 단위로 읽어 들이기 위한 스트림 통로 
		FileInputStream in = new FileInputStream(imageFile);
		
		//FileInputStream통로를 통해 이미지로 부터 읽어 들인 바이트데이터들을 저장할 배열 생성
		byte[] buffer = new byte[1024*8]; //8kb
		
		while (true) {//무한 반복해서 이미지파일의 바이트데이터를 8kb바이트씩 읽어 들여 읽어들인 8kb바이트데이터를 출력스트림통로를 통해 
					  //웹브라우저로 8kb씩 내보내어 미리보기 이미지 화면이 조금씩 조금씩 나오게 만들자
			int count = in.read(buffer);//read메소드호출시.. byte배열 전달 하여 byte배열에 읽어들인 데이터를 저장한후 
										//읽어들인 바이트 개수 를 int로 반환 한다.
										//만약 파일로부터 데이터를 읽어 들이지 못할 경우에는  -1를 read()메소드가 반환 한다
			//더이상 파일로부터 읽어들일 count변수에 값(바이트 개수)가 없으면?
			if(count == -1){
				break;//더이상 파일로부터 읽어 들일 내용이 없으므로 while반복문을 빠져나가서 종료한다
			}
			
			//출력 스트림 통로 outputStream을 통해  FileInputStream읽어드리는 통로로 부터 읽어 들인 데이터를 웹브라우저에 내보낸다
			out.write(buffer, 0, count);
			
		}
		
		//입력 스트림 통로, 출력 스트림 통로  자원해제 
		in.close();
		out.close();
	
	}		
	
	
}






