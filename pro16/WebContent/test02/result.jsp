<%@page import="java.net.URLEncoder"%>
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
		//first.jsp에서 result.jsp로 다운로드할 파일명은 request내장객체 영역에 저장된 상태로
		//전송되어 온다.
		
		//요청한 전체 URL중에서 컨텍스트패스 주소 얻기(/pro16)
 		String contextPath = request.getContextPath();
	
		//인코딩 방식 설정
		request.setCharacterEncoding("UTF-8");
		
		//다운로드할 파일명을 request내장객체영역으로부터 꺼내와 얻기
		String file1 = URLEncoder.encode(request.getParameter("param1"), "UTF-8");
		String file2 = URLEncoder.encode(request.getParameter("param2"), "UTF-8");
		
	%>
		<%-- 다운로드 처리할 서블릿 => FileDownload서블릿 클래스 --%>	
	
		파일 내려받기 1 : <br>
		<a href="<%=contextPath%>/download.do?fileName=<%=file1%>">파일 내려받기</a> <br>

		파일 내려받기 2 : <br>
		<a href="<%=contextPath%>/download.do?fileName=<%=file2%>">파일 내려받기</a> <br>
</body>
</html>