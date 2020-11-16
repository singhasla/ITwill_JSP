<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*" %>
<%
 String fileName = request.getParameter("fileName");
 new File("c:/test/"+fileName).delete();
 out.print("파일 삭제 완료!");
%>

