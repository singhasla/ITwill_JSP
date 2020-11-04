<%@page import="mybean.SawonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//삭제후 ~삭제성공! <--메시지창 띄우고 index.jsp로 이동!
	//1.
	request.setCharacterEncoding("utf-8");

	//2.
	String no = request.getParameter("no");
	//정수로 변환
	int newno = Integer.parseInt(no);
	
	//3. SawonDao객체를 생성하여 delSawon메소드 호출시 삭제할 직원no전달하여 DELETE작업함
	new SawonDao().delSawon(newno);
%>
		<script type="text/javascript">
			window.alert("삭제성공!");
			location.href="index.jsp";
		</script>