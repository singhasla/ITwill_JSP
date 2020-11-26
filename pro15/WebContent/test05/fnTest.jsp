<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위한 선언 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 문자열 처리 기능의 함수들이 들어있는 functions라이브러리를 사용하기 위해 작성 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여러가지 문자열 처리 함수</title>
</head>
<body>
	<c:set var="title1" value="Hello World!"/>
	<c:set var="title2" value="쇼핑몰 중심 JSP입니다!"/>
	<c:set var="string1" value="중심"/>
	
	<h1>여러가지 문자열처리 함수 기능</h1>
	
		title1 = "Hello World!"<br>
		title2 = "쇼핑몰 중심 JSP입니다!"<br>
		str1 = "중심"<br>
		t1 = " abcd "<br><br>
	
	<%-- fn:length(string)함수는 string변수에 저장된 전체 문자열의 문자개수를 반환 --%>
		fn:length("Hello World!")를 호출한 결과 = ${fn:length(title1)}<br>			<%-- 12 --%>
		
	<%-- fn:toUpperCase(string)함수는 string변수에 저장된 문자열을 대문자로 변환 --%>
	fn:toUpperCase("Hello World!")를 호출한 결과 = ${fn:toUpperCase(title1)}<br>	<%-- HELLO WORLD! --%>
	
	<%-- fn:toLowerCase(string)함수는 string변수에 저장된 문자열을 소문자로 변환 --%>
	fn:toLowerCase("Hello World!")를 호출한 결과 = ${fn:toLowerCase(title1)}<br>	<%-- hello world! --%>
	
	<%-- fn:substringing(string, StartIndexNum, EndIndexNum)함수는 string변수에 저장된 문자열의 일부분을 추출해 반환 --%>
	fn:substringing("Hello World!")를 호출한 결과 = ${fn:substring(title1, 0, 1)}<br>	<%-- H --%>
	
	<%-- fn:trim(string)함수는 string변수에 저장된 문자열의 앞뒤 공백을 제거해서 반환 --%>
	fn:trim("abcd ")를 호출한 결과 = ${fn:trim(t1)}<br>	<%--  --%>
	
	<%-- fn:replace(string, 바꾸려는 문자, 바꿀 문자를 대체할 문자)함수 --%>
	fn:replace("Hello World!")를 호출한 결과 = ${fn:replace(title1, " ", "/")}<br>	<%-- Hello/World! --%>
	
	<%-- fn:indexOf(title2, str1)함수는 
		title2변수에 저장된 전체 문자열 중에서 str1변수에 저장된 값의 인덱스 위치를 구해 반환 --%>
	fn:indexOf(title2, str1)를 호출한 결과 = ${fn:indexOf(title2, str1)}<br>	<%-- --%>
	
	<%-- fn:contains(title1, str1)함수는 
		title1변수에 저장된 전체 문자열 중에서 str1변수에 저장된 문자열이 포함되어 있는지 판단하여 반환 --%>
	fn:contains(title1, str1)를 호출한 결과 = ${fn:contains(title1, str1)}<br>	<%-- true --%>
	
	
</body>
</html>