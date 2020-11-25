<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--클라이언트가 요청한 전체 주소는 request내장객체영역에 저장되어 있음
	요청한 전체 주소 -> http://localhost:8080/pro14/test03/NewFile.jsp
 --%>

<%=request.getContextPath()%>
<%--  http://localhost:8080/pro14  
           클라이언트가 요청한 전체 주소 중에서 컨텍스트주소 pro14까지를 받아볼수 있다 --%>
           
<a href="<%=request.getContextPath()%>/test03/ajax4.jsp">메인으로</a>