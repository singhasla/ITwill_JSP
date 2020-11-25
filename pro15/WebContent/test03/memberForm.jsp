<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 회원 가입창에서 회원정보를 입력한 후 member8.jsp로 전송하도록 작성합니다. -->
	
	<form action="member8.jsp" method="post" >
	
		<h1 style="text-align: center" >회원 가입창</h1>
	
		<table align="center">	
			<tr>
				<td width="200"><p align="right">아이디</p></td>
				<td width="400"><input type="text" name="id"></td>
			</tr>
			<tr>
				<td width="200"><p align="right">비밀번호</p></td>
				<td width="400"><input type="text" name="pwd"></td>
			</tr>		
			<tr>
				<td width="200"><p align="right">이름</p></td>
				<td width="400"><input type="text" name="name"></td>
			</tr>		
			<tr>
				<td width="200"><p align="right">이메일</p></td>
				<td width="400"><input type="text" name="email"></td>
			</tr>		
			<tr>
				<td width="200"><p>&nbsp;</p></td>
				<td width="400">
					<input type="submit" value="가입하기">
					<input type="reset" value="다시입력" >
				</td>
			</tr>
		</table>
	</form>
	


</body>
</html>




