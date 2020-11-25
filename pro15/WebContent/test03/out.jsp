<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%-- 
    		JSTL의 core라이브러리에 속한 태그들을 사용하기 위해
    		taglib 지시자 태그의 uri속성을 core라이브러리가 존재하는 곳으로 설정하고
    		태그사용을 위한 짧은 이름(접두사)을 설정할 속성인 prefix의 값을 설정하자.
     --%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <%-- 
			<c:out>태그는 out내장객체의 print() 또는 <%= %> 표현식 대신 사용할 목적의 태그.
			EL문법 ${ }를 이용하여 계산식도 넣을 수 있다.
	 --%>
	 
	 <c:out value="안녕하세요"/> <br>
	 <c:out value="${2*3}"/> <br>
	 
	 <%--
	 		member.gender은 null값이 들어있는데..
	 		EL은 null값은 공백으로 출력한다.
	 		공백을 default속성의 값으로 대처 할 수도 있음.
	  --%>
	 <c:out value="${member.gender}" default="null값 대신에 출력할 문장"/> <br>
	 
	 <br>
	 <hr><hr>
	 
	 <%-- <abc>는 html태그로 인식하여 그대로 화면에 출력되지 않는다. --%>
	 <abc>는 abc입니다.<br>
	 
	 <%-- EL ${ }언어의 문법 중에 entity 기호 &lt; -> '<' 를 사용해야한다는 단점이 있지만 사용가능함 --%>
	 &lt;abc>는 abc입니다.<br>
	 
	 <%-- 위 코드의 단점을 개선한 JSTL의 <c:out>태그를 이용해 쉽게 출력할 수 있음 --%>
	 <c:out value="<cde>는 cde입니다."/>
	 
	 
	 
</body>
</html>