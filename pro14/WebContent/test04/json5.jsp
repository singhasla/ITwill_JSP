<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSON ajax 연습</title>

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<script type="text/javascript">
	
		$(function() {
			$("#checkJson").click(function() {

				//전송할 회원정보를 JSONObject객체 형태의 문자열로 만들어서 변수에 저장
				var _jsonInfo = '{"name":"박지성","age":"25","gender":"남자","nickname":"날쌘돌이"}';
				
				$.ajax({
					
					type : "post",
					async : true,
					url : "<%=request.getContextPath()%>/json",		/* 서블릿을 요청할 주소 */
					data : {jsonInfo : _jsonInfo},					/* 매개변수이름(jsonInfo)으로 JSON데이터형식의 문자열을 ajax기술로 전송함 */
					success : function(data, textStatus) {
							
					},
					error : function() {
						alert("에러가 발생했습니다");
					}
				});	//$.ajax끝
				
			});	//.click(function() 끝
			
		});
	
	</script>
	
	
</head>
<body>
	<a id="checkJson" >전송</a> <br><br>
	
	<div id="output"></div>
</body>
</html>