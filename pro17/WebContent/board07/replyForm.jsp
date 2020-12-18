<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>    

<%-- 컨텍스트 주소 /pro17 얻기 --%>
<c:set  var="contextPath"  value="${pageContext.request.contextPath}" />
    
<%
	request.setCharacterEncoding("UTF-8");
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


	<%--Jquery사용을 위한 선언 --%>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
			
		//취소 버튼 클릭시  모든 글목록을 조회 하기 위해 컨트롤러 요청
		function backToList(obj) {
			obj.action = "${contextPath}/board/listArticles.do";
			obj.submit();
		}
		//답글을 입력할때 첨부파일의 미리보기 와면 구현 하기 위한 함수
		function readURL(input){		
			if(input.files  && input.files[0]){			
				var reader = new FileReader();			
				readr.onload = function(e){
					$('#preview').attr('src', e.target.result); //<img 태그에 src속성에 경로 설정>
				}			
				reader.readAsDataURL(input.files[0]);
			}		
		}	
	</script>
</head>
<body>

<%--  답글을 입력한 후 BoardController서블릿에  /board/addReply.do주소로 답글 추가 요청함. --%>
<h1 style="text-align: center;">답글 쓰기</h1>
	
<form action="${contextPath}/board/addReply.do" name="frmReply" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td align="right">글쓴이:&nbsp;</td>
			<td><input type="text" size="5" value="lee"  disabled /></td>
		</tr>
		<tr>
			<td align="right">글제목:&nbsp;</td>
			<td><input type="text" size="67" maxlength="100" name="title" /></td>
		</tr>
		<tr>
			<td align="right"><br>글내용:&nbsp;</td>
			<td><textarea name="content"  rows="10" cols="65" maxlength="40000"></textarea></td>
		</tr>
		<tr>
			<td align="right">이미지파일 첨부:&nbsp;</td>
			<td><input type="file" name="imageFileName" onchange="readURL(this);" /></td>
			<td><img id="preview" src="#" width=200 height=200 /></td>
		</tr>
		<tr>
			<td align="right"></td>		
			<td>
				<input type="submit" value="답글반영하기"/>
				<input type="button" value="취소" onclick="backToList(this.form)"/>
			</td>
		</tr>
	</table>
</form>
	
	

</body>
</html>










