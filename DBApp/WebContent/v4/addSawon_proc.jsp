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
		// 1> 인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("utf-8");
	%>

	<%-- 2> 3> addSawon.jsp에서 입력한 회원정보들을 request내장객체영역에서 꺼내어서 SawonDto객체에 저장 --%>
		<jsp:useBean id="dto" class="mybean.SawonDto"></jsp:useBean>
		<jsp:setProperty property="*" name="dto"/>

	<%-- 4> DB와 연결을 맺어 DB에 INSERT작업할 SawonDao객체를 생성 --%>
		<jsp:useBean id="dao" class="mybean.SawonDao"/>				
		
	<%
		// 5> 입력한 회원정보들은 SawonDto객체에 저장되어 있으므로
		//		SawonDao객체의 setSawon()메소드 호출시 매개변수로 SawonDto객체를 전달하여
		//		INSERT작업을 하게 됨
			dao.setSawon(dto);
	%>
	
	<h2>직원 정보가 정상적으로 추가되었습니다.</h2>
	<a href="addSawon.jsp">새로운 직원정보 추가</a>
	<a href="index.jsp">메인 화면으로...</a>
	
</body>
</html>