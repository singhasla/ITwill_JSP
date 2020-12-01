package sec01.ex01;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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

@WebServlet("/upload.do")
public class FileUpload extends HttpServlet{

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
		
		//업로드할 파일 경로와 연결된 File객체 생성
		File currentDirPath = new File("C:\\Temp\\file_repo");
		
		//업로드할 파일 데이터를 임시로 저장해 놓을 객체 메모리 생성
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//파일 업로드시~ 사용할 임시 메모리 최대 크기 1메가바이트로 지정
		factory.setSizeThreshold(1 * 1024 * 1024);
		
		//임시 메모리에 파일업로드시~ 지정한 1메가바이트 크기를 넘길 경우 업로드될 파일 경로를 지정함
		factory.setRepository(currentDirPath);
		
		//참고
		//DiskFileItemFactory클래스는 업로드 파일의 크기가 지정한 크기를 넘기전까지는
		//업로드한 파일데이터를 임시로 메모리에 저장하고
		//지정한 크기를 넘길 경우, 업로드될 경로인? file_repo폴더에 업로드할 파일을 저장한다.
		
		
		//파일업로드할 객체 메모리(new DiskFileItemFactory()객체메모리)를 생성자 쪽으로 전달받아
		//저장한~ 파일업로드를 처리할 new ServletFileUpload(factory)객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try {
			//업로드할 파일에 대한 요청정보를 가지고 있는 request객체를 parseRequest()메소드 호출시
			//인자로 전달하면 request객체에 저장되어 있는 업로드할 파일의 정보들을 파싱해서
			//DiskFileItem객체에 저장후 DiskFileItem객체를 ArrayList배열에 추가한다.
			//그 후 ArrayList배열을 반환 받는다.
			List items = upload.parseRequest(request);
			
			//ArrayList배열에 저장된 DiskFileItem객체의 갯수만큼 반복
			//ArrayList에 저장된 DiskFileItem객체를 얻어 저장
			for(int i=0;i<items.size();i++){
				
				//ArrayList가변 배열에서.. DiskFileItem객체(요청한 아이템 하나의 정보)를 얻는다.
				FileItem fileItem = (FileItem)items.get(i);
				
				//DiskFileItem객체의 정보가 요청한 파일정보 아이템이 아닐 경우
				if(fileItem.isFormField()){
					System.out.println(fileItem.getFieldName() +"="+ fileItem.getString("UTF-8"));
				} else {	//DiskFileItem객체의 정보가 업로드할 파일 하나의 정보일 경우
					System.out.println("파라미터 :" + fileItem.getFieldName());
					System.out.println("파일이름 :" + fileItem.getName());
					System.out.println("파일크기 :" + fileItem.getSize() + "byte");
					
					//파일크기가 0보다 크다면(업로드할 파일이 존재한다면)
					if(fileItem.getSize() > 0){
						
						//업로드할 파일명을 얻어 파일명 뒤에서부터 \\문자열을 포함하고 있는지
						//인덱스 위치값을 알려주는데.. 없으면.. -1을 반환함.
						int idx = fileItem.getName().lastIndexOf("\\");
						System.out.println(idx);
						
						if(idx == -1){
							idx = fileItem.getName().lastIndexOf("/");	// -1 얻기
							System.out.println("안녕: " + idx);
						}
						
						//업로드할 파일명 얻기
						String fileName = fileItem.getName().substring(idx + 1);
						
						//업로드할 파일경로 + 업로드할 파일명을 이용해 File객체 생성
						File uploadFile = new File(currentDirPath+"\\"+fileName);
						
						//실제 파일 업로드
						fileItem.write(uploadFile);
						
					}// end if
					
				}// end else
				
			}// end for
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}//doHandle() 끝
	
}//FileUpload 끝
