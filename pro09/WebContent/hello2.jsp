<%@ page 	contentType="text/html; charset=utf-8" 
			import="java.util.*"
			language="java"
			session="true"
			info="JSP페이지는 쇼핑몰관련 페이지이다."
			isELIgnored="true"
			errorPage="false"
			pageEncoding="utf-8"
%>
<!-- 
		*page디렉티브태그(지시자태그) - JSP페이지의 설정을 지시하는 태그

		contentType="text/html;"	<==		클라이언트의 웹브라우저로 출력(응답)할 데이터 종류 설정
		import="java.util.*"		<==		JSP페이지에서 사용할 다른 패키지의 클래스 설정
		language="java"				<==		JSP페이지에서 사용할 프로그래밍 언어를 지정 (생략하면 디폴트값은 java)
		session="true"				<==		JSP페이지에서 HttpSession내장객체의 사용여부를 설정(디폴트값은 true)
		info=""						<==		JSP페이지의 상세 설명 기술
		isELIgnored="true"			<==		JSP 2.0버전에서 추가된 기능으로, EL(Expression Language)태그 사용 유무를 설정,
											false로 설정하면 EL태그 사용함.
		errorPage="false"			<==		JSP페이지 처리 도중 예외가 발생할 경우 예외처리담당 JSP페이지를 지정함.
		pageEncoding="utf-8"		<==		JSP페이지에서 사용하는 문자열 인코딩 방식을 지정함.
		
		
		*인코딩 방식의 종류
		
		ISO-8859-1 방식		- 유럽문자 처리, 한글이 깨짐
		EUC-KR 방식			- 한글만 처리
		UTF-8 방식			- 모든 언어 깨짐을 처리(한글 포함)
 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>쇼핑몰 구현 중심 JSP페이지 입니다.</h1>
</body>
</html>