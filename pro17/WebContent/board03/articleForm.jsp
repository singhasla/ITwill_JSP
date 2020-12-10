<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
	//현재 listArticles.jsp(View)페이지는 BoardController서블릿으로 부터 재요청 받은 응답할 디자인 화면이다.
	
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

	
	<%-- javascript언어의 고급프레임워크인 Jquery사용을 위해 설치 링크 작성 --%>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">
	
		//제이쿼리를 이용해 아래쪽의 <input type="file">태그에서 이미지 파일 첨부시 ..
		//미리보기 기능을 구현하는 함수 
		function readURL(input){// <input type="file">태그를 매개변수로 전달 받음 
			
			//크롬 웹브라우저의 F12눌러 개발자모드로 가서 console탭에 뛰운 로그메세지를 확인 한다.
			console.debug(input);
			console.debug(input.files);
			//참고 : 
			//<input type="file">인 태그 객체의  files메소드를 호출하면
			//FileList라는 배열이 생성되면서  FileList배열 내부의 0번재 인덱스 위치에...
			//아래에서 선택한 (업로드할) 파일 정보들을 key:value쌍으로 저장한 File객체가 저장되어 있음
			
			//FileList라는 배열이 존재하고
			//FileList라는 배열의 0번째 인덱스 위치에 아래에서 파일업로드하기 위해 선택한 File객체가 저장되어 있다면
			//요약 : 아래의 <input type="file">태그에서 업로드를 하기 위한 이미지 파일을 선택 했다면?
			if(input.files && input.files[0]){
				
				//동적으로 <img>태그를 만들어서  id속성값이 tdImg인 <td>태그영역에  추가함
				$("#tdImg").html("<img id='preview' src='#' width=200 height=200 />"   );
				
				//파일의 내용을 읽어올 객체 생성
				var reader = new FileReader();
				
				//지정한 <img>태그에 첫번째 파일 input에 첨부한 파일에 대한 정보를 가지고 있는
				//File객체의 정보를 읽어 드립니다.
				reader.readAsDataURL(input.files[0]);
				
				//파일내용을 모두 읽어 들였다면
				reader.onload = function(ProgressEvent){
					//읽어 들인 File객체 정보는 매개변수로 넘어오는 ProgressEvent객체내부의?
					//target속성에 대응되는 객체(JSON객체 데이타 형식)로 저장되어 있다.
					//또한 JSON객체 데이터 내부에는 result속성에 읽어들인  File객체 정보가 저장되어 있다.
					
					console.debug(ProgressEvent);
					
					//id속성값이 preview인 <img>태그를 선택해서 
					//attr()메소드를 이용해 파일 첨부시 미리 보기 이미지를 나타내기 위해..
					//src속성에  new FileReader()객체를 이용해 읽어들인 첨부할 File객체정보를 지정하여
					//추가함으로써  이미지 파일의 미리보기 기능이 가능 한것이다.
					$("#preview").attr("src", ProgressEvent.target.result);
					
				}//function끝
				
			}//if문끝
		
		}//readURL함수 끝
		
		
		//글목록 보기 버튼 클릭했을떄 호출되는 함수 
		function backToList(obj){//클릭한 버튼이 속해 있는 <form>태그를 매개변수로 전달 받는다.
			
			obj.action="${contextPath}/board/listArticles.do";
			obj.submit();//form태그로 서블릿에  모든 글 조회 요청	
		}
	
	
	</script>

</head>
<body>
<%--
	쇼핑몰 게시판에 글을 작성할떄 보통 사진을 첨부하는 경우가 많죠?
	이처럼 글쓰기 작업할때 첨부파일도 같이 업로드 할수 있도록  반드시 <form>태그의 encType속성을 multipart/form-data로
	설정 해야 합니다.
 --%>
		<h1 style="text-align: center;" >새글 쓰기</h1>

		<%--action속성의 값을  /addArticle.do로 작성해서  새글등록 요청을 BoardController서블릿으로 할것이다. --%>
		<form action="${contextPath}/board/addArticle.do" 
		      method="post"
		      enctype="multipart/form-data">
		
			<table border="0" align="center">
				<tr>
					<td align="right">글제목 :</td>
					<td colspan="2"><input type="text" size="67" maxlength="500" name="title"></td>
				</tr>
				<tr>
					<td align="right"><br>글내용 :</td>
					<td colspan="2">
						<textarea name="content" rows="10" cols="65" maxlength="4000"></textarea>    
					</td>
				</tr>
				<tr>
					<td align="right">이미지 파일 첨부 :</td>
					
					<%--첨부할 다른 이미지파일을 선택해서 변화가 일어나면?  
					    readURL()함수 호출시 변화가 일어난 <input>태그 자체를 매개변수로 전달 --%>
					<td><input type="file" name="imageFileName" onchange="readURL(this);" >        </td>
					
					<%--첨부할 이미지 선택시 나타날 미리보기 화면 영역 --%>
					<td id="tdImg">   </td>
				</tr>
				<tr>
					<td align="right"></td>
					<td colspan="2">
						<input type="submit" value="글쓰기" />
						<input type="button" value="글목록보기" onclick="backToList(this.form)" />
					</td>
				</tr>						
			</table>
		</form>
	 



</body>
</html>




