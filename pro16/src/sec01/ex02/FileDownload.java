package sec01.ex02;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//파일 업로드 처리 프로그램
/*
 *  파일 업로드를 처리하는 서블릿인 FileUpload클래스이다.
 *  
 *  .jar라이브러리 파일에서 제공하는 DiskFileItemFactory클래스를 이용해
 *  저장위치와  업로드 가능한 최대파일크기를 설정한다.
 *  그리고 ServletFileUpload클래스를 이용해 파일 업로드창에서 업로드요청한 파일과
 *  요청한 텍스트값(파라미터)에 대한 정보를 가져와 파일을 업로드하고
 *  요청한 텍스트값을 얻어서 출력한다.
 */

//파일 다운로드 처리하는 서블릿
//참고 : 파일 다운로드 기능은 자바 IO를 이용해 구현합니다.

@WebServlet("/download.do")
public class FileDownload extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	//get,post방식으로 요청이 들어오면 처리하는 메소드
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("UTF-8");
		
		//클라이언트의 웹브라우저로 내보낼(응답할, 출력할, 다운로드시킬) 데이터 타입 설정
		response.setContentType("text/html;charset=UTF-8");
		
		
		//다운로드할 파일 경로를 문자열로 저장
		String file_repo = "C:\\Temp\\file_repo";
		//result.jsp페이지로부터 요청받은 다운로드할 파일명 얻기
		String fileName = request.getParameter("fileName");
		// C:\\Temp\\file_repo\\파일
		String downFile = file_repo + "\\" + fileName;
		
		//실제 다운로드할 파일에 접근하기 위해 'C:\\Temp\\file_repo\\파일'에 대한 File객체 생성
		File f = new File(downFile);
		
		
		//org.apache.catalina.connector.CoyoteOutPutStream@32d8fcdd
		//파일 다운로드를 요청한 클라이언트의 웹브라우저에게
		//다운로드할 파일을 바이트단위로 읽어들인 버퍼공간의 데이터를 내보내기 위한 출력 스트림 객체 생성
		OutputStream out = response.getOutputStream();
		
		
		
		/*웹브라우저 캐시에 대해 설명하기 위한 내용*/
		/*
		 * 	웹개발을 하다보면 게시글 등의 데이터를 DB에 등록했는데도
		 * 	브라우저에서 새로고침시 해당 데이터에 대한 내용이 반영되지 않는 경우가 있습니다.
		 * 	혹은 데이터 뿐만 아닌 자바스크립트, html, css등의 정적 자원을 서버에서 수정했는데도
		 *  많은 원인이 있을 수 있으나, 이는 웹브라우저 캐시가 원인일 수 있습니다.
		 */
			/*웹브라우저의 캐시공간이란*/
			/*	브라우저에는 캐시가 있는데, 이것은 서버와의 불필요한 통신을 하지 않기 위해 마련된 공간입니다.
			 *	최초 서버로부터 요청한 자원들(javascript, HTML, CSS, 이미지 등)을 내려받고
			 *	같은 자원을 새로고침 등을 통해서 다시 요청하는 경우
			 *	브라우저는 실제로는 서버로 HTTP요청을 하지 않고
			 *	브라우저 자신의 캐시에 저장해 두었떤 자원들을 사용하게 됩니다.
			 *
			 *	예를 들어 test.jsp를 최초로 요청한 경우 서버로부터 응답된 자원들을 브라우저 캐시공간에 저장하고
			 *	F5나 주소표시줄에 주소를 입력해 test.jsp를 요청한 경우 불필요하게 다시 HTTP요청하는 것이 아니라 
			 *	캐시에서 꺼내서 화면에 보여주는 것입니다.
			 *	이러한 브라우저 캐시 기능이 성능상 이점을 가져다 줄 수는 있겠으나
			 *	게시판이나 네이버의 실시간 검색어처럼 자주 변하는 부분까지는
			 *	브라우저 캐시공간을 사용한다면 사용자는 계속 변화하는 데이터를 웹브라우저 화면에서 볼 수 없고
			 *	같은 화면만 보게 될 것입니다.
			 */
		
			/*응답 헤더를 통한 캐시 제어 설명*/
			/*
			 * 	HTTP응답 메세지의 몇가지 헤더 속성을 통해서 브라우저가 현재 내용을 캐시를 사용하지 않도록 할 수 있습니다.
			 * 	response객체의 해당 속성들에 값을 설정해 웹브라우저가 캐시를 사용하지 않고
			 * 	매번 새로운 요청을 통해 결과를 얻어오도록 할 수 있습니다.
			 */
		
			// HTTP 1.1버전에서 지원하는 헤더로 no-cache로 설정하면 브라우저는 응답받는 결과를 캐싱하지 않습니다.
			// 또한 뒤로가기 등을 통해서 페이지 이동하는 경우 페이지를 캐싱할 수 있으므로
			// no-store값 또한 추가로 설정해야 합니다.
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Cache-Control", "no-store");
			
			//웹브라우저에서 다운로드한 파일명 클릭시...
			//	1. Content-disposition속성에 attachment;을 지정하여
			//		무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성의 값 설정
			//	2. 다운로드 파일명이 깨지는 현상(파일명이 한글일 경우)을 방지하기 위해
			//		Content-disposition속성에 다운로드할 파일명 설정
			response.setHeader("Content-disposition"
					, "attachment;fileName=\""+URLEncoder.encode(fileName,"UTF-8"));
				//참고
				//	* Content-disposition : attachment
				//		브라우저 인식 파일 확장자를 포함하여 모든 확장자의 파일들에 대해 
				//		무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성의 값 설정
				//	* Content-disposition : inline
				//		브라우저 인식 파일 확장자를 가진 파일들에 대해서는 웹브라우저 상에서 바로 파일을 열고,
				//		그 외 파일들에 대해서는 "파일 다운로드" 대화상자가 뜨도록 하는 헤더 속성.
			
			
		//다운로드할 파일의 데이터들을 바이트 단위로 읽어들이기 위한 스트림 통로 역할의 객체 생성
		FileInputStream in = new FileInputStream(f);
		
		//다운로드할 파일에서 데이터를 8KB씩 읽어와 저장할 용도의 byte단위의 배열 생성
		byte[] buffer = new byte[1024 * 8];
		
		while (true) {
			
			//위 new FileInputStream(f)객체 통로를 이용하여 위 buffer배열단위(8KB)만
			//파일의 내용을 읽어 들인다.
			int count = in.read(buffer);
			
			if(count == -1){	//읽어들인 값이 없으면(-1)
				break;				
			}
			
			//읽어들일 값이 존재한다면?
			//8KB만큼 읽어들인 내용을 출력스트림 통로를 이용하여 웹브라우저로 내보낸다(다운로드를 위하여)
			out.write(buffer, 0, count);
			
		}
		
		//스트림 통로는 사용하고난 후 자원해제
		in.close();
		out.close();
		
	}//doHandle() 끝
	
}//FileUpload 끝
