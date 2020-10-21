<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
		// 1. request내장객체 메모리에 저장되어있는 데이터 한글처리
		request.setCharacterEncoding("utf-8");
    
    	// 2. 요청한 값 얻기
    	String num = request.getParameter("num");
    	String name = request.getParameter("name");
    	String grade = request.getParameter("grade");
    	String subject = request.getParameter("subject");
    	
    	// 3. 응답할 값 마련
    %>
    
    <%-- 4. 클라이언트의 웹브라우저로 응답(출력) --%>
    <h2>입력한 학생 정보</h2>
    <table border="1" width="300">
    	<tr>
    		<th>학번</th>
    		<td><%=num %></td>
    	</tr>
    	<tr>
    		<th>이름</th>
    		<td><%=name %></td>
    	</tr>        
    	<tr>
    		<th>학년</th>
    		<td><%=grade %></td>
    	</tr>
    	<tr>
    		<th>과목</th>
    		<td><%=subject %></td>
    	</tr>    
    </table>