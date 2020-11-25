<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
	표현언어 empty연산자에 대해...
						
		- empty연산자는 자바빈클래스의 변수에 값이 저장되어 있는지 
			또는 List, Map과 같은 배열 객체에 값이 존재하는지 판단을 하는 연산자이다
--%>

<%-- useBean액션 태그를 이용한 MemberBean클래스의 객체 생성 --%>
<jsp:useBean id="m1" class="sec01.ex01.MemberBean" scope="page"/>

<%-- 생성한 MemberBean객체에 name변수의 값을 저장 --%>
<jsp:setProperty property="name" name="m1" value="이순신"/>

<%-- useBean액션 태그를 이용한 ArrayList클래스의 배열 생성 --%>
<jsp:useBean id="m2" class="java.util.ArrayList" scope="page"/>

<h2> empty연산자 사용 <br>
	<%-- empty객체 -> 뒤에 존재하는 객체의 모든 속성에 값이 비어있냐라고 물어보는 연산자이다
		 				비어 있으면 true 반환, 비어있지 않으면 false를 반환					 --%>
	 ${empty m1} <br>
	 
	<%-- ArrayList배열객체를 뜻하는 m2참조변수에는 값이 저장되어 있지 않으므로 true를 반환함 --%> 
	 ${empty m2} <br>
	 
	<%-- 문자열에 대해서는 false를 반환함 --%>
	 ${empty "hello"} <br>
	  
	 ${empty ""} <br>
	 ${empty null} <br>
	</h2>