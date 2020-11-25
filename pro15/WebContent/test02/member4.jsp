<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//forward4.jsp에서 request내장객체에 address속성이름으로 바인딩(저장) 했었습니다.
	//현재 member4.jsp에서 session내장객체영역에 똑같은 address속성이름으로 다른값을 저장 해 봅시다.
	session.setAttribute("address", "수원시 팔달구");
	//그리고 아래의 EL식으로 address속성이름으로 값을 얻어 출력하면 어떤것이 출력될까요?
	//request내장객체 영역의 address-"서울시 강남구" 가 출력될까요?
	//session내장객체 영역의 address-"수원시 팔달구" 가 출력될까요? 
%>    
      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<tr align="center" bgcolor="#99ccff">
			<td width="20%"><b>아이디</b></td>
			<td width="20%"><b>비밀번호</b></td>
			<td width="20%"><b>이름</b></td>
			<td width="20%"><b>이메일</b></td>
			<td width="20%"><b>주소</b></td>
		</tr>
		
		<tr align="center">
			<td>${id}</td>   <%--${requestScope.id}  requestScope생략--%>
			<td>${pwd}</td>  <%--${requestScope.pwd}  requestScope생략--%>
			<td>${name}</td>    <%--${sessionScope.name}  sessionScope생략--%>
			<td>${email}</td>   <%-- ${applicationScope.email}  applicationScope생략 --%>
			<td>${address}</td>
			<%--requestScop 또는 sessionScope를 생략하여 address만 적으면? 
				어떤 영역에서 값을 꺼내와 출력 하는 걸가요?
			답 :
			request내장객체영역에 저장되어 있는 address속성의 값이 출력 된다.
			이유는 위표현 언어 EL ${ }로  address속성의 값을 얻어 출력하면 session보다 request가 우선순위가 높으므로
			request의 address값이 출력됩니다.
				
			결론 : 표현언어 EL에서는 동일한 속성이름에 접근할 경우 page내장객체영역을 먼저 찾는다.
			우선순위
			page  >  request  > session > application 		
				
			 --%>
			
		</tr> 
			
	</table>


</body>
</html>










