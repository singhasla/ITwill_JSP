<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL 라이브러리의 태그 사용을 위한 선언 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 프로젝트에 접근하기 위한 컨텍스트 경로를 request영역에서 얻어 contextPath변수에 저장 --%>
<%-- value="/pro16" --%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}"/>

<% 
	//인코딩 방식 UTF-8로 설정
	request.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%-- 
			서블릿(FileUpload.java)에게 요청해 파일을 업로드하기 위해  가상경로 주소 action속성에 작성
			파일 업로드할때 반드시 encType속성의 값을 multipart/form-data로 설정해야 한다.	
	--%>
	<form action="${contetPath}/upload.do" method="post" enctype="multipart/form-data">
		파일1 : <input type="file" name="file1"> <br>
		파일2 : <input type="file" name="file2"> <br>
		
		파라미터1 : <input type="text" name="param1"> <br>
		파라미터2 : <input type="text" name="param2"> <br>
		파라미터3 : <input type="text" name="param3"> <br>
		
		<input type="submit" value="업로드">
	</form>
	<form action="${contextPath}/upload.do"></form>

</body>
</html>