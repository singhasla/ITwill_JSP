<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	//현재 listArticles.jsp(View)페이지는 BoardController서블릿으로부터 재요청 받은 응답할 디자인 화면이다.
	
	//인코딩 방식 UTF-8설정
	request.setCharacterEncoding("UTF-8");
%>
	<%-- 컨텍스트 주소 얻기: /pro17 --%>
	<c:set var="contextPath" value="${pageConext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		.cls1 {
			text-decoration: none;
		}
		.cls2 {
			text-align: center;
			font-size: 30px;
		}
	</style>
</head>
<body>
	<table align="center" border="1" width="80%">
		<tr height="10" align="center" bgcolor="pink">
			<td>글번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
		</tr>
		
<c:choose>
	<%-- BoardController.java서블릿으로부터 재요청받아 전달받은 request영역에 
			ArrayList배열이 저장되어 있지 않다면?
		 DB로부터 조회된 글정보들이 존재하지 않다면... --%>
	<c:when test="${requestScope.articlesList == null}">
		<tr height="10" align="center">
			<td align="center" colspan="4">등록된 글이 없습니다.</td>
		</tr>
	</c:when>
	
	<%-- DB로부터 조회된 글정보들이 존재한다면... --%>
	<c:when test="${requestScope.articlesList != null}">
		<%-- BoardController.java서블릿으로부터 재요청받아 전달받은 request영역에 
			articlesList키로 바인딩된 ArrayList배열의 크기(조회한 글)만큼 반복하여
			검색한 글정보(ArticleVO객체)들을 ArrayList배열 내부의 각 인덱스 위치로부터 
			차례대로 꺼내와 글목록정보를 출력	--%>
		<c:forEach var="article" items="${articlesList}" varStatus="articleNum">
			<tr align="center">
				<td width="5%">${articleNum.count}</td> <%-- varStatus속성의 count속성을 이용해 글번호를 1부터 자동으로 표시--%>
				<td width="10%">${article.id}</td> <%-- ArticleVO객체(검색한 글하나의 정보)의 id변수값을 얻어서 출력 --%>
				<td width="35%" align="left">
					<span style="padding-right:30px"></span> <%-- 왼쪽여백에 글제목을 표시하기위해 --%>
					
					<%-- 조건  : <forEach>태그 반복시 각 글의 level값이 1보다 크면? 답글(자식글)이므로.. --%>
					<c:choose>
						<c:when test="${article.level > 1}">
							<%-- 다시 내부<foreEach>태그를 이용해 1부터 level값까지 반복하여
									부모글 밑에 공백으로 들여쓰기하여 답글(자식글)임을 표시함	 --%>
							<c:forEach begin="1" end="${article.level}" step="1">
								<span style="padding-left:20px"></span>
							</c:forEach>
							<%-- 공백 다음에 자식글 제목을 표시한다. --%>
							<span style="font-size:12px;">[답변]</span>
							<a href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}" class="cls1">${article.title}</a>
						</c:when>
						<%-- 조건  : 이때 검색한 글의 level값이 1보다 크지않으면 부모글이므로 공백없이 글제목을 표시함 --%>
						<c:otherwise>
							<a href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}" class="cls1">${article.title}</a>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<fmt:formatDate value="${article.writeDate}"/>
				</td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>
	</table>
	
	<a href="#" class="cls1"><p class="cls2">글쓰기</p></a>
	
</body>
</html>