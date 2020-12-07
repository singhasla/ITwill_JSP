<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%-- JSTL라이브러리에 속한 core태그들을 사용하기 위한 선언 --%>    
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
      
<%--컨텍스트 주소  /pro17  저장 --%>
<c:set  var="contextPath"  value="${pageContext.request.contextPath}" />
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 회원 가입창에서 회원정보를 입력한 후 
	     action속성에 작성한 /member/addMember.do로  MemberController서블릿에게 회원 추가 요청     -->
	
	<form action="${contextPath}/member/addMember.do" method="post" >
	
		<h1 style="text-align: center" >회원 등록창</h1>
	
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




