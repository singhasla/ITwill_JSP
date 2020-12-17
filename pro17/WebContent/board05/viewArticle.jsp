<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<head>
   <meta charset="UTF-8">
   <title>글보기</title>
   <style>
     #tr_btn_modify{
       display:none;
     }
   
   </style>
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   <script type="text/javascript" >
     function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
     }
 
     //수정하기 버튼을 클릭했을때..  fn_enable(obj)함수를 호출하여 비활성화된 텍스트 박스를 수정할수 있도록 활성화 시킵니다
	 function fn_enable(obj){
    	 //텍스트 박스의 id로 접근해 disabled속성을 false로 설정 
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("i_imageFileName").disabled=false;
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
	 }
	 
     //글정보와 이미지를 수정한후 수정반영하기 버튼을 클릭했을때...
     //BoardController서블릿으로 수정 요청을 함.
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/board/modArticle.do";
		 obj.submit();
	 }
	 
     //삭제 하기 버튼 클릭했을때.. 호출되는 함수로 
     //BoardController서블릿으로 삭제요청할 주소, 삭제할 글번호를  매개변수로 전달 받아
     //Form태그를 동적으로 새로 생성 해서  method속성, action속성을 설정 하고 ,
     //input태그를 동적으로 만들어서 type="hidden", name="articleNO", value=삭제할글번호
     //동적으로 만든 Form태그에 자식 input태그로 설정 한후 ... form태그로 삭제요청을 서블릿으로 한다    
	 function fn_remove_article(url,articleNO){
		
    	 //<form></form>
    	 var form = document.createElement("form");
    	 
    	 //<form method="post" action="${contextPath}/board/removeArticle.do"></form>
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
		 
		 //<input type="hidden" name="articleNO" value="삭제할글번호" />
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
	     
	     //<form method="post" action="${contextPath}/board/removeArticle.do">
	     	 //<input type="hidden" name="articleNO" value="삭제할글번호" />
	     //</form>
	     form.appendChild(articleNOInput);
	     
	     //<body>
		     //<form method="post" action="${contextPath}/board/removeArticle.do">
		     	 //<input type="hidden" name="articleNO" value="삭제할글번호" />
		     //</form>
	     //</body>
	     document.body.appendChild(form);
	     
	     //form태그를 이용하여 action="${contextPath}/board/removeArticle.do"<--이용하여 서블릿으로 삭제 요청 전송을 함
		 form.submit();
	 
	 }
	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
 </script>
</head>
<body>
  <form name="frmArticle" method="post"  
        action="${contextPath}"  enctype="multipart/form-data">
  <table  border="0"  align="center">
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      글번호
   </td>
   <td >
    <input type="text"  value="${article.articleNO }"  disabled />
    <%--글 수정 시 글번호를 컨트롤러로 전송하기 위해 미리 <hidden>태그를 이용해 글번호를 저장합니다. --%>
    <input type="hidden" name="articleNO" value="${article.articleNO}"  />
   </td>
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      작성자 아이디
   </td>
   <td >
    <input type=text value="${article.id }" name="writer"  disabled />
   </td>
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      제목 
   </td>
   <td>
    <input type=text value="${article.title }"  name="title"  id="i_title" disabled />
   </td>   
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      내용
   </td>
   <td>
    <textarea rows="20" cols="60"  name="content"  id="i_content"  disabled />
	${article.content }
	</textarea>
   </td>  
  </tr>
 
<c:if test="${not empty article.imageFileName && article.imageFileName!='null' }">  
<tr>
   <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
      이미지
   </td>
   <td>
   	<%-- 이미지 수정에 대비해 미리 원래 이미지 파일 이름을 <hidden>태그에 저장합니다. --%>
     <input  type= "hidden"   name="originalFileName" value="${article.imageFileName }" />
    <img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}" id="preview"/><br>
       
   </td>   
  </tr>  
  <tr>
    <td>
    	<%-- 수정된 이미지 파일이름을 전송 합니다. --%>
       <input  type="file"  name="imageFileName" 
	   id="i_imageFileName"   disabled   onchange="readURL(this);"   />
    </td>
  </tr>
 </c:if>
  <tr>
	   <td width=20% align=center bgcolor=#FF9933>
	      등록일자
	   </td>
	   <td>
	    <input type=text value="<fmt:formatDate value="${article.writeDate}" />" disabled />
	   </td>   
  </tr>
  <tr   id="tr_btn_modify"  >
	   <td colspan="2"   align="center" >
	       <input type=button value="수정반영하기"   onClick="fn_modify_article(frmArticle)"  >
         <input type=button value="취소"  onClick="backToList(frmArticle)">
	   </td>   
  </tr>
    
  <tr  id="tr_btn"    >
   <td colspan=2 align=center>
	    <input type=button value="수정하기" onClick="fn_enable(this.form)">
	    <input type=button value="삭제하기" 
		onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">
	    <input type=button value="리스트로 돌아가기"  
		onClick="backToList(this.form)">
	    <input type=button value="답글쓰기"  
		onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})">
   </td>
  </tr>
 </table>
 </form>
</body>
</html>