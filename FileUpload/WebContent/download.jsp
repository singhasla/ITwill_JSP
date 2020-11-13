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
		//다운로드 처리하는 페이지(크랄이언트의 웹브라우저에 파일정보를 읽어들여서 내보냄)
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//multi_pro.jsp페이지에서 다운로드할 파일명을 클릭했을때..
		//전달받는 요청값 얻기
		//<a href="download.jsp?path=upload&name=saveFiles.get(i)">
		String path = request.getParameter("path");	//upload
		String name = request.getParameter("name");	//다운로드할 파일명(업로드된 파일명)
		
		//전달받은 upload라는 이름의 가상폴더경로를 이용해서
		//실제 다운로드할 파일 경로 얻기
		String realPath = getServletContext().getRealPath("/"+path);
		out.println(realPath);
		
		/* 
			(설명) 실행가능한 xml파일 일지라도, 무조건 다운로드 받게 처리해야하는데
					그러기 위해서는 지금까지는, 클라이언트 웹브라우저 <-- 응답(파일) -- 서버...
					응답할 데이터 + 응답할 파일데이터에 대한 헤더정보(어떤형식,누구한테전달,어떻게만들어졌고,응답할파일크기)등등...
					응답할 파일 데이터의 헤더정보 또한 같이 클라이언트의 웹브라우저에 전달해야한다.
		*/
		//다운로드할 파일을 서버페이지에서 클라이언트의 웹브라우저로 내보내기전에 헤더정보 설정하기
		response.setContentType("Application/x-msdownload");	//다운로드 문서형식으로 내보내겠다고 설정
		//->클라이언트의 웹브라우저는 위 코드를 인식함!
		
		//이미 정해져있는 헤더정보를 담는 Content-Disposition속성값에 다운로드할 파일명을 설정
		response.setHeader("Content-Disposition", "attachment;filename="+name);
		
		
		//실제 다운로드할 파일에 접근하여 파일의 내용을 읽어들이기 위해 File객체 생성
		//new File(실제 다운로드할 파일이 존재하는 파일경로)
		File file = new File(realPath + "/" + new String( name.getBytes("8859_1"),"UTF-8") );
		
	%>
</body>
</html>