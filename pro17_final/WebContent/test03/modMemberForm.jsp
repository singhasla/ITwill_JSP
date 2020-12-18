<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<%--컨텍스트 주소 /pro17 얻기 --%>    
<c:set  var="contextPath" value="${pageContext.request.contextPath}"/>
    
<%
	//인코딩 방식 UTF-8설정
	request.setCharacterEncoding("UTF-8");
%>    
       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<style type="text/css">
		.cls1{
			font-size: 40px;
			text-align: center;
		}
	
	</style>

</head>
<body>

<h1 class="cls1">회원정보 수정창</h1>

<%--회원정보 수정창에서 수정할 회원정보를 입력하고 수정하기 버튼을 클릭했을떄.......
	action속성에 작성한 요청명  /pro17/member/modMember.do와  수정할 회원 id를 전달해 수정 요청을 함
 --%>
<form action="${contextPath}/member/modMember.do?id=${requestScope.memInfo.id}" method="post">
	
	<table align="center">
		<tr>
			<td width="200"> <p align="right">아이디</p> </td>  <%--조회한 ID를 표시  --%>
			<td width="400"> <input type="text" name="id" value="${memInfo.id}" disabled /> </td>
		</tr>
		<tr>
			<td width="200"> <p align="right">비밀번호</p> </td>  <%--조회한 비밀번호를 표시  --%>
			<td width="400"> <input type="text" name="pwd" value="${memInfo.pwd}" /> </td>
		</tr>		
		<tr>
			<td width="200"> <p align="right">이름</p> </td>  <%--조회한 이름을 표시  --%>
			<td width="400"> <input type="text" name="name" value="${memInfo.name}"  /> </td>
		</tr>	
		<tr>
			<td width="200"> <p align="right">이메일</p> </td>  <%--조회한 이메일를 표시  --%>
			<td width="400"> <input type="text" name="email" value="${memInfo.email}"  /> </td>
		</tr>
		<tr>
			<td width="200"> <p align="right">가입일</p> </td>  <%--조회한 가입일 표시  --%>
			<td width="400"> <input type="text" name="id" value="${memInfo.joinDate}" disabled/> </td>
		</tr>	
		<tr align="center">
			<td colspan="2" width="400">
				<input type="submit" value="수정하기" >
				<input type="reset" value="다시작성" >
			</td>
		</tr>
	</table>
</form>
	
</body>
</html>






