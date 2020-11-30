<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 현재 실행중인 웹프로젝트에 대한 정보를 지니고 있는 
	//   ServletContext객체 얻기 
	ServletContext ctx = getServletContext();

	//2. ServletContext객체의 getRealPath()메소드를 이용하여
	//   웹프로젝트에 대한 기본 경로를 얻어온다.
	//-> 업로드할 폴더 경로 upload를 getRealPath메소드호출시 전달하면
	//-> 실제 업로드 되는 폴더의 경로를 찾아 얻을수 있다.
	String realPath  = ctx.getRealPath("upload"); 
	//C:\workspace_javascript\FileUpload\WebContent\ upload 
	
	//3.업로드 할수 있는 파일의 최대 크기 설정
	int max = 100 * 1024 * 1024; //100MB
	
	//4.실제 파일 업로드 
	//-> cos.jar압축파일 내부에 존재하는  MultipartRequest클래스 사용하여 업로드함
	MultipartRequest multi = 
	new MultipartRequest(request,realPath,max,"UTF-8", new DefaultFileRenamePolicy());
	//인수1. form태그에서 전달 받은 요청데이터 (request객체)를 생성자로 전달 !
	//인수2. 업로드될 파일의 위치 경로를 생성자로 전달!
	//인수3. 업로드 할수 있는 파일의 최대 크기를 생성자로 전달!
	//인수4. 업로드할 파일이름이 한글일경우 문제가 되므로 인코딩 방식을 UTF-8로 설정하기 위해 전달!
	//인수5. 똑같은 이름의 파일을 같은경로에 업로드시 파일이름이 중복되지 않게 하기 위해
	//      업로드되는 파일이름을 자동으로 변환 시켜줄 new DefaultFileRenamePolicy();객체전달!
 
	/*MultipartRequest객체에  request객체가 저장되어 있기 때문에 
	  MultipartRequest객체의 getParameter()메소드를 이용하여 입력한 텍스트 값을 꺼내올수 있다.
	*/
	String user = multi.getParameter("user");
	String title = multi.getParameter("title");
	out.println(user + "," + title);
	
	//파일업로드를 하기 위해 선택했던 <input type="file" name="...">의  name속성값을
	//Enumeration반복기 역할을 하는 배열에 저장후 
	//Enumeration반복기 배열 자체를 리턴(반환)
	Enumeration e = multi.getFileNames();
	
	//Enumeration반복기 배열에 데이터가 저장되어 있는 동안 반복
	while(e.hasMoreElements()){
		
		//파일업로드를 하기위해 선택했던 <input>의 name속성값을 
		//Enumeration배열에서 얻는다
		String name = (String)e.nextElement();
		
		out.println("클라이언트가 업로드요청한 파일의 원본이름 : "
		            + multi.getOriginalFileName(name) + "<br>");
		
		out.println("서버에 실제로 업로드된 파일의 이름:"  
					+ multi.getFilesystemName(name) + "<br>");
		
		out.println("업로드된 파일의 유형 : " 
		            + multi.getContentType(name) + "<br>");
		
		//서버에 실제로 업로드된 파일에 접근해서 조작을 위한 File객체 생성
		File f = multi.getFile(name);
		
		out.print("업로드된 파일 크기 :" + f.length() + "byte<br>");
	}
	
	
	

%>







