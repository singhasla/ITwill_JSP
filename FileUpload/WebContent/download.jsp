<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
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
		//다운로드요청을 받는 서버페이지
		//다운로드 처리하는 페이지 (클라이언트의 웹브라우저에 파일정보를 읽어들여서 내보냄)
	
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//multi_pro.jsp페이지에서 다운로드할 파일명을 클릭했을떄..
		//전달 받는 요청값 얻기 (다운로드할 위치(가상경로), 다운로드할 파일명 )
		String path = request.getParameter("path"); //upload
		String name = request.getParameter("name"); //다운로드할 파일명(업로드된 파일명)
		
		//전달 받은 upload라는 이름의 가상폴더경로를 이용해서 
		//실제 다운로드할 파일 경로 얻기 
		String realPath = getServletContext().getRealPath("/" + path);
		out.println(realPath);//C:\workspace_javascript\FileUpload\WebContent\ upload 
		
/*
	(설명) 실행가능한 xml파일 일지라도 무조건 다운로드 받게 처리 해야 하는데..
	그러기 위해서는  지금까지는?  클라이언트 웹브라우저 <-----응답 (파일)----서버 할때....
       응답할 데이터  + 응답할 파일 데이터에 대한 헤더정보(어떤형식,누구한테전달,어떻게만들어졌고,응답할파일크기)등등...
        응답할 파일 데이터의 헤더 정보 또한 같이 클라이언트의 웹브라우저에 전달 해야 한다. 
*/
	//다운로드할 파일을 서버페이지에서 클라이언트의 웹브라우저로 내보내기전에  헤더정보 설정하기
	response.setContentType("Application/x-msdownload"); //다운로드 문서 형식으로 내보내겠다고 설정
	//->클라이언트의 웹브라우저는 위코드를 인식함!
	
	//이미 정해져 있는 헤더 정보를 담는 Content-Disposition속성값에  다운로드할 파일명을 설정하기
	response.setHeader("Content-Disposition", "attachment;filename=" + name);
	
	//실제 다운로드할 파일에 접근하여 파일의 내용을 읽어 들이기 위해 File객체 생성 	   
// 	new File(실제 다운로드할 파일이 존재하는 파일경로)	
	File file = new File(realPath + "/" + new String(name.getBytes("8859_1"),"UTF-8"));
	
	//1024바이트씩 파일의 내용을 읽어 들이 위해 배열 생성
	byte[] data = new byte[1024];
	
	if(file.isFile()){//File형식이 맞다면?
	
		try{
		/*다운로드할 파일의 내용을 읽어들이기 위한 스트림 통로준비*/
		//1바이트 단위로 파일의 데이터를 읽어 들이기 위한 통로 
		// - new FileInputStream(file)
		//1바이트 단위로 읽어 들인 파일의 데이터를 내부 버퍼에 저장해 두었다가 한번에 읽어 들이기 위한 통로
		// - new BufferedInputStream(...)
		BufferedInputStream input = new BufferedInputStream(new FileInputStream(file)); 
		 		   
		
		/*읽어들인 파일의 내용을 버퍼메모리 공간에서 바이트단위로 웹브라우저에 내보낼 스트림통로준비*/
		BufferedOutputStream output  = new BufferedOutputStream(response.getOutputStream());
		
		//파일내용을 1024바이트씩 끈어서 웹브라우저에 내보내기 위해 
		//파일 전체 크기 중에서  data배열의 바이트 크기만큼 파일데이터를 
		//BufferedInputStream스트림통로객체의 내부버퍼에서 읽어들여 저장하는 변수
		int read;
		
		//파일 내용을 1024바이트씩 끈어서 내부버퍼에서 읽어들이는데..
		//읽어들인 파일내용이 존재 하는 동안 반복 
		while( (read = input.read(data))  != -1 ){
			               //read()메소드의 반환값은 읽어들이기에 성공한 바이트수를  반환
			
			//전체 data배열의 0부터 1024개 바이트씩 묶어서 출력버퍼에서 클라이언트의 웹브라우저로 내보낸다.
			output.write(data, 0, read);	
		}//while
	
		//출력버퍼 공간이 가득차지 않아도 파일내용을 강제적으로 사용자의 화면에 내보내는 기능 제공
		output.flush();	
		//자원해제
		input.close();
		output.close();
		
		}catch(Exception err){
			err.printStackTrace();
		}
		
	}//if
	
	%>




</body>
</html>