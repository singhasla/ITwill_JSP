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
	 	// 1. 한글처리
	 	request.setCharacterEncoding("utf-8");
	 	// 2. 입력받은 시험점수를 request객체 영역에서 꺼내와서 int score변수에 저장 시키기
	 	int dan = Integer.parseInt(request.getParameter("dan"));
	 %>
	 <%-- 3. 테이블 태그를 이용해 입력받은 단수의 구구단을 출력. for문이용 --%>
	 <table border="1" >
	 <th align="center" bgcolor="yellow" colspan="2"> <%=dan %>단 출력</th>
	
	<%for(int i=1;i<=9;i++){%> 
	
		<% if(i%2 == 0){%>
		<tr align="center" bgcolor="skyblue">
			<td width="300" align="center"><%=dan %> * <%=i %></td>
			<td width="300"align="center"><%=dan*i %></td>
		</tr>
		<%} else {%>
		<tr align="center" bgcolor="lightgreen">
			<td width="300" align="center"><%=dan %> * <%=i %></td>
			<td width="300" align="center"><%=dan*i %></td>
		</tr>
		
		<%}%>
	<%}%>
	 
	 </table>
</body>
</html>