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

				
				$.ajax({
					
					type : "post",
					async : true,
					url : "<%=request.getContextPath()%>/json2",	/* 서블릿을 요청할 주소 */
					success : function(data, textStatus) {
						
								//서블릿(서버페이지)에서 응답한 data매개변수의 값은
								//JSONObject객체배열 데이터형태의 문자열이다.
								// -> data = '{"members":[{"gender":"남자","name":"박지성","nickname":"날쌘돌이","age":"25"},{"gender":"여자","name":"김연아","nickname":"칼치","age":"20"}]}'
							
								//parse(data)메소드를 호출하면..
								//JSONObject객체 형태의 문자열을? 추출하여 JSONObject객체로 변환해서 반환함
								var jsonInfo = JSON.parse(data);
								var memberInfo = "회원정보<br>==========<br>";
								
								for(var i in jsonInfo.members){
									memberInfo += "이름 : " + jsonInfo.members[i].name + "<br>";
									memberInfo += "나이 : " + jsonInfo.members[i].age + "<br>";
									memberInfo += "성별 : " + jsonInfo.members[i].gender + "<br>";
									memberInfo += "별명 : " + jsonInfo.members[i].nickname + "<br>";
									memberInfo += "==========<br>";
								}
								
								//아래의 <div>요소를 선택해 그 영역에 memeberInfo변수에 저장된 문자열 출력
								$("#output").html(memberInfo);
								
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
	<%-- 
		흐름)
			1. 클라이언트가 웹브라우저 주소창에 http://localhost:8080/pro14/test04/json6.jsp입력하여 요청함
			2. json6.jsp화면에서 회원정보 수신하기 라는 <a>링크를 클릭했을 때.. Ajax통신을 이용하여
				서블릿(서버페이지)으로 회원정보를 요청함
			3. 서블릿 페이지에서 JSONObject객체를 이용하여 회원정보 데이터들을 완성한 후
			4. json6.jsp요청화면으로 응답할 데이터를 전송함
			5. 응답받은 데이터를 json6.jsp의 <div id="output"></div>요소 영역에 출력하여 
				클라이언트의 웹브라우저로 응답
	 --%>

	<a id="checkJson" style="cursor: pointer;">회원정보 수신하기</a> <br><br>
	
	<div id="output"></div>
</body>
</html>