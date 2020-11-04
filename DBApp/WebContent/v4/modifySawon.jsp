<%@page import="mybean.SawonDto"%>
<%@page import="mybean.SawonDao"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modifySawon.jsp 직원정보 수정 페이지</title>
</head>
<body>
	<%
		//흐름 : index.jsp에서 수정<a>태그를 클릭했을때
		//수정할 직원 no를 전달받아.. no에 해당되는 직우너 한사람의 정보를 검색해서
		//현재 페이지에 출력하고, 출력한 정보를 보고 사용자가 직원정보를 수정한 후
		//DB에 UPDATE작업을 함.
		
		//1. index.jsp에서 전송받은 수정할 직원번호를 얻기 전에 인코딩 방식 지정
		request.setCharacterEncoding("utf-8");
		
		//2. 수정할 직원번호를 request영역에서 얻기
		String no = request.getParameter("no");
		
		//3. DB에 정보를 수정하기전 직원 한사람의 정보를 SELECT하기 위해
		//	SawonDao객체 생성 후 getSawon()메소드 호출하여 작업
		SawonDao dao = new SawonDao();
		
			//수정할 직원 한사람의 정보를 검색하기 위해 getSawon메소드 호출시 직원 no전달함
			//검색한 한 사람의 정보를 SawonDto객체에 저장 후 반환 받는다.
			SawonDto dto = dao.getSawon(Integer.parseInt(no));
			
	%>
	
	<%-- 7. 수정하기 전에 먼저 검색한 직원 한 명의 정보를 나타내자 --%>
	<%-- 8. 나타낸 정보를 다시 수정하기 위해 입력 후 modifySawon_pro.jsp로 수정요청! --%>
	<form action="modifySawon_proc.jsp" method="post">
	
		<%-- 수정할 직원번호는 <input>태그는 노출하지않고 수정할 직원번호만 request에 담아 전송 --%>
		<input type="hidden" name="no" value="<%=no%>">
	
		<div align="center">
			<h1>직원 정보 수정</h1>
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" value="<%=dto.getId() %>"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" value="<%=dto.getName() %>"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text" name="pass" value="<%=dto.getPass() %>"></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="text" name="age" value="<%=dto.getAge() %>"></td>
				</tr>
				<tr>
					<th>근무지</th>
					<td>
						<select name="addr">
							<option value="서울" <% if(dto.getAddr().equals("서울")){%> selected <%} %>>서울</option>
							<option value="경기" <% if(dto.getAddr().equals("경기")){%> selected <%} %>>경기</option>
							<option value="인천" <% if(dto.getAddr().equals("인천")){%> selected <%} %>>인천</option>
							<option value="수원" <% if(dto.getAddr().equals("수원")){%> selected <%} %>>수원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td><input type="text" name="extension" value="<%=dto.getExtension() %>"></td>
				</tr>
				<tr>
					<th>부서명</th>
					<td>
						<select name="dept">
							<option value="영업" <% if(dto.getDept().equals("영업")){%> selected <%} %>>영업</option>
							<option value="기술" <% if(dto.getDept().equals("기술")){%> selected <%} %>>기술</option>
							<option value="기획" <% if(dto.getDept().equals("기획")){%> selected <%} %>>기획</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="수정할 정보 다시 입력">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>