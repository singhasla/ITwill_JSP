<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSON ajax 연습</title>

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

	<script type="text/javascript">
		$(function(){
			$("#checkJson").click(function(){
				
				
			    $.ajax( 
			    		{
			    		  type : "post",//전송방식
			    		  async : true,//비동기 방식으로 요청
			    		  url : "<%=request.getContextPath()%>/json4",//서블릿을 요청할 주소
			    	      success : function(data,textStatus){

			    	      },
			    		  error : function(){
			    			  alert("에러가 발생했습니다.");
			    		  }
			    		}     
			          ); //end ajax	
				
					
			});
		});
	</script>
</head>
<body>
<%--
흐름
1. 클라이언트가 웹브라우저 주소창에 http://localhost:8080/pro14/test04/json7.jsp입력하여 요청함
2. json7.jsp화면에서  데이터 수신하기 <a>링크를 클릭했을때.. Ajax통신을 이용하여 서블릿(서버페이지)으로
     회원정보와 도서정보를 요청합니다.
3. 서블릿 페이지에서  JSONObject객체 2개 를 이용하여 회원정보 데이터와 도서정보 데이터를 각각  완성한 후 
4. json7.jsp요청화면으로 응답데이터를 전송함.	
5. 응답받은 데이터를 json7.jsp의  <div id="output"></div>요소 영역에 출력하여 클라이언트의 웹브라우저로 응답함
--%>
	<a id="checkJson" style="cursor:pointer">데이터 수신하기</a> <br><br>
	<div id="output"></div>	
</body>
</html>










