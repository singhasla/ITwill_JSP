<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
	//현재 viewArticle.jsp(View)페이지는 BoardController서블릿으로 부터 재요청 받은 응답할 디자인 화면이다.
	//컨트롤러에서 request내장객체 영역에 저장한 조회한 글정보(ArticleVO객체의 정보)를 이용해 현재 화면에 표시함.
	//이미지 파일이 존재하는 경우는 글번호와 이미지파일이름을 FileDownloadController로 전송한 후
	//<img>태그에 다운로드하여 표시한다.
	
	//인코딩 방식 UTF-8설정
	request.setCharacterEncoding("UTF-8");
%>    
	<%--컨텍스트 주소 : /pro17 --%>
	<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
	
		//obj는 form태그를 말함.
		function backToList(obj) {
			obj.action="${contextPath}/board/listArticles.do";
			obj.submit();
		}
	
	</script>

</head>
<body>

	<form action="frmArticle" enctype="multipart/form-data" method="post">
		<table border="0" align="center">
			<tr>
				<td width="150px" align="center" bgcolor="#FF9933">글번호</td>
				<td>
					<input type="text" value="${article.articleNO}" disabled="disabled"/>
				</td>
			</tr>
			<tr>
				<td width="150px" align="center" bgcolor="#FF9933">작성자 ID</td>
				<td>
					<input type="text" value="${article.id}" name="id" disabled="disabled"/>
				</td>
			</tr>
			<tr>
				<td width="150px" align="center" bgcolor="#FF9933">글제목</td>
				<td>
					<input type="text" value="${article.title}" name="title" id="i_title" disabled="disabled"/>
				</td>
			</tr>
			<tr>
				<td width="150px" align="center" bgcolor="#FF9933"></td>
				<td>
					<textarea rows="20" cols="60" name="content" id="i_content">${article.content}</textarea>
				</td>
			</tr>
			
			<%-- 조회된 이미지명이 존재 하면? --%>
			<c:if test="${not empty article.imageFileName && article.imageFileName != 'null'}">
				<tr>
					<td width="20%" align="center" bgcolor="#FF9933" rowspan="2">이미지</td>
					<td>
						<%-- FileDownloadCOntroller서블릿에 조회된 글의 이미지 파일이름과 글 번호를 전송해
							 이미지를 <img>태그에 표시함 --%>
						<img src="${contextPath}/download.do?imageFileName=${article.imageFileName}&articleNO=${article.articleNO}" id="preview"/><br>
					</td>
				</tr>
				<td>
					<input type="file" name="imageFileName" id="i_imageFileName" onchange="readURL(this);" disabled="disabled"/>
				</td>
			</c:if>
				<tr>
					<td width="20%" align="center" bgcolor="#FF9933">등록일자</td>
					<td>
						<input type="text" value="<fmt:formatDate value="${article.writeDate}"/>" disabled="disabled"/>
					</td>
				</tr>
				<tr id="tr_btn_modify">
					<td colspan="2" align="center">
						<input type="button" value="수정하기" onclick="fn_modify_article(frmArticle)"/>
						<input type="button" value="취소하기" onclick="backToList(frmArticle)"/>
					</td>
				</tr>
			
				<tr id="tr_btn">
					<td colspan="2" align="center">
						<input type="button" value="수정하기" onclick="fn_enable(this.form)">
						<input type="button" value="삭제하기" onclick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})"/>
						<input type="button" value="리스트로 돌아가기" onclick="backToList(this.form)">
						<input type="button" value="답글쓰기" onclick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})"/>
					</td>
				</tr>
		</table>
	</form>

</body>
</html>