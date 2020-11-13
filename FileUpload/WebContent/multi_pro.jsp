<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
		
		
		//multi.jsp페이지에서 입력한 이름, 주소, 하고싶은말의 정보를
		//request내장객체영역에서 꺼내오기 위해 MultiPartRequest객체의 getParameter()메소드호출
		//MultiPartRequest객체의 getParameter()메소드 호출
		String name = multi.getParameter("name");
		String addr = multi.getParameter("addr");
		String note = multi.getParameter("note");
		
		//웹서버 하드공간에 실제로 업로드된 파일의 이름을 저장할 가변길이 배열인? ArrayList객체 생성
		ArrayList saveFiles = new ArrayList();
		
		//클라이언트가 업로드할 파일의 원본 이름을 저장할 가변길이 배열인? ArrayList객체 생성
		ArrayList originFiles = new ArrayList();
		
		//실제 업로드하기 위해 파일을 선택하기위한 <input>태그의 name속성값을 모두~
		//Enumeration 반복기 역할을 하는 배열에 담아 Enumeration반복기 자체를 반환
		Enumeration e = multi.getFileNames();
		
		while(e.hasMoreElements()){
			//<input type="file">태그들의 name속성값들이 차례대로
			//Enumeration반복기역할을 하는 배열에서 꺼내온다.
			Object object = e.nextElement();
			String filename = (String)object;
			
			//웹서버 하드 공간에 실제로 업로드된 파일의 이름을 하나씩 꺼내와서
			//ArrayList배열에 추가하여 담기
			saveFiles.add(multi.getFilesystemName(filename));	//******************* 중요 ***********************
			
			//클라이언트가 업로드한 파일의 원본이름을 하나씩 얻어
			//ArrayList배열에 추가하여 담기
			originFiles.add(multi.getOriginalFileName(filename));
		}
	%>


	<ul>
		<li>이름 : <%=name %></li>
		<li>주소 : <%=addr %></li>
		<li>노트 : <%=note %></li>
	</ul>

	<hr>
	
	업로드한 파일 리스트 목록 <br>
	<ul>
		<% 
			//실제 웹서버 하드 공간에 저장된 파일명은?
			//ArrayList saveFiles = new ArrayList(); 배열에 저장되어 있다.
			//그러므로 saveFiles배열 크기만큼 반복
			for(int i=0;i<saveFiles.size();i++){
				
				%>
					<%-- ArrayList originFiles 배열에 저장된 업로드한 파일의 원본이름을 얻어 출력 --%>
					<li>
					
						<%-- 파일다운로드를 처리하는 download.jsp페이지로
							업로드한 파일이 존재하는(다운로드할 파일이 존재하는) 가상경로 주소와
							실제 업로드된 파일명을 전달하여 다운로드 처리 요청을 합니다.		 --%>
						<a href="download.jsp?path=upload&name=<%=saveFiles.get(i) %>">
							<%=originFiles.get(i) %>
						</a>
					</li>
				<%
			}
		%>
	</ul>
	
</body>
</html>
