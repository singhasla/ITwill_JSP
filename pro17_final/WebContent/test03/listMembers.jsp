<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--JSTL라이브러리 태그들을 사용하기 위한 선언 --%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
%>
<%--톰캣이 웹프로젝트까지 접근할수 있는 주소(컨텍스트 주소 /pro17)를 얻어 변수에 저장 --%>
<c:set  var="contextPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


		
		<c:choose>
			<%--MemberConteroller서블릿으로 부터 재요청을 통해 전달 받은  request내장객체 메모리 영역에
				저장된 msg값에 따라  작업결과를 alert창에 출력 합니다.
			 --%>
			<c:when test='${requestScope.msg == "modified" }'>
				<script type="text/javascript">
					
					//웹브라우저가 현재 페이지의 HTML코드를 모두 로딩 했을때..
					window.onload = function(){
						alert("회원 정보를 수정 했습니다.");
					}
				</script>
			</c:when>
			
			<c:when test="${requestScope.msg == 'addMember'}">
				<script type="text/javascript">
				
					window.onload = function(){
						window.alert("회원을 등록 했습니다.");
					}
				</script>
			</c:when>
			<c:when test="${requestScope.msg == 'deleted'}">
				<script type="text/javascript">
				
					window.onload = function(){
						window.alert("회원정보가 삭제 되었습니다.");
					}
				</script>
			</c:when>			
		</c:choose>




</head>
<body>
		<p class="cls1">회원정보</p>
		<table align="center" border="1">
			<tr align="center" bgColor="aqua">
				<td width="7%" ><b>아이디</b></td>
				<td width="7%" ><b>비밀번호</b></td>
				<td width="7%" ><b>이름</b></td>
				<td width="7%" ><b>이메일</b></td>
				<td width="7%" ><b>가입일</b></td>
				<td width="7%" ><b>수정</b></td>
				<td width="7%" ><b>삭제</b></td>
			</tr>
<c:choose>
<%--request내장객체에서 ArrayList배열을 꺼내오지 못하면? --%>
	<c:when test="${requestScope.membersList == null }">
			<tr>
				<td cospan="5">
					<b>등록된 회원이 없습니다.</b>
				</td>
			</tr>
	</c:when>
<%--request내장객체영역에서 조회한 회원정보들을 저장하고 있는 ArrayList배열을 꺼내온다면 --%>
	<c:when test="${membersList != null}">
		<c:forEach   var="mem"   items="${membersList}">
			<tr align="center">
				<td>${mem.id}</td>
				<td>${mem.pwd}</td>
				<td>${mem.name}</td>
				<td>${mem.email}</td>
				<td>${mem.joinDate}</td>
				<%-- 삭제,수정할 회원의 ID를 전달해 삭제,수정요청을 합니다.  --%>
				<td><a href="${contextPath}/member/modMemberForm.do?id=${mem.id}">수정</a></td>
				<td><a href="${contextPath}/member/delMember.do?id=${mem.id}">삭제</a></td>
				
				
			</tr>
		</c:forEach>
	</c:when>
</c:choose>		
		</table>
		
	
		
		
		<%--MVC중에 C컨트롤러(MemberController.java서블릿)으로 
		       회원가입 입력 화면으로 이동시켜줘~ 라는 요청을 하고 있다 --%>
		<a href="${contextPath}/member/memberForm.do">
			<p class="cls2">회원 가입하기</p>
		</a>
		
		
		
</body>
</html>




