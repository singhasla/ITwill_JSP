<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL태그라이브러리 중에서 core라이브러리의 태그들을 사용하기 위해서 불러와 로딩 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		/*
			전체흐름 :
						자바코드로 ArrayList객체를 생성하여 문자열을 저장한 후
						<c:foreach>반복문 태그에서 사용할 수 있도록 <c:set>태그로 변수 list를 선언하고
						list변수에 ArrayList를 저장한다.
						그리고 varStatus속성에 loop속성을 이용해서 반복할 횟수를 출력.
						<c:foreach>반복문태그의 items속성에 ArrayList배열을 설정한 후
						반복문 수행시 ArrayList에 저장된 문자열을 반복변수 data에 한개씩 가져와 저장 후 출력.		
		*/
		
		/* 자바코드로 ArrayList객체를 생성하여 문자열들을 저장	*/
		List dataList = new ArrayList();
		dataList.add("hello");
		dataList.add("world");
		dataList.add("안녕하세요");
	%>

	<%-- 표현언어에서 사용할 수 있도록 <c:set>태그를 이용해 변수를 선언하고 변수에 ArrayList배열을 저장 --%>
	<c:set var="list" value="<%=dataList%>"/>
	
	
	<%-- 반복변수 i를 1부터 10까지 증가시키면서 반복문을 수행함 --%>
	<c:forEach var="i" begin="1" end="10" step="1" varStatus="loop">
		i = ${i} &nbsp;&nbsp;&nbsp; 반복횟수: ${loop.count}<br>
	</c:forEach>
	
	<br>
	
	<%-- 반복변수 i를 1부터 10까지 2씩 증가시키면서 반복문을 수행함 --%>
	<c:forEach var="i" begin="1" end="10" step="2">
		5*${i} = ${5*i}<br>
	</c:forEach>
	
	<br>
	
	<%-- ArrayList같은 컬렉션프레임워크에 속해 있는 배열을 items속성에 넣어주면
		forEach반복문은 ArrayList배열의 크기만큼 반복한다.
		반복변수 data에는 ArrayList배열의 0번째 인덱스 위치에 저장된 문자열객체부터 저장하게 된다.
	--%>
	<c:set var="L" value="<%=dataList%>"/>
	<c:forEach var="data" items="${L}">
		${data}<br>
	</c:forEach>
	
	<br>

	<%-- 구분자 콤마(,)를 이용해 문자열을 분리해서 출력할 수 있다 --%>	
	<c:set var="fruits" value="사과, 파인애플, 바나나, 망고, 귤"/>
	<c:forTokens var="tk" items="${fruits}" delims=",">
		${tk} <br>
	</c:forTokens>
	
</body>
</html>