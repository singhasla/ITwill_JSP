<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- JQuery Setup -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	
		//아래 버튼 클릭했을 때 호출되는 메소드로
		//Ajax기술을 이용하여 서블릿(서버페이지)으로 요청후 응답을 받아 처리함.
		//사용자가 입력한 ID와 DB에 저장된 ID가 중복되었는지 판단하는 요청
		function fn_process() {
			
			//사용자가 입력한 ID를 얻어 변수에 저장
			var _id = $("#t_id").val();	//서블릿(서버페이지)으로 요청하는 파라미터
			
			if(_id == '') {
				alert("ID를 입력하세요");
				return;	//function()를 빠져나감
			}
			//아이디를 입력했다면 AJAX기술을 이용하여 서버페이지로 아이디 중복확인을 요청함
			
			$.ajax({
				type : "post",
				async : true,
				url : "<%=request.getContextPath()%>/mem",	//mem : 서블릿 매칭주소
				dataType : "text",
				data : { id: _id },	//입력한 ID를 서블릿으로 요청시 요청할 데이터로 전송!
				success : function(m, textStatus){
							//서블릿(서버가 실행하는 페이지에서 전송되어 오는 응답메세지를
							//m 매개변수로 전달받아.. 아래의 div태그영역에 표시
							if(m == "useable"){
								//아래의 div요소를 선택해서 가져와서
								//text로 메세지 정보를 출력
								$("#message").text("사용 가능한 ID입니다.");
								
								//사용할 수 있는 ID이므로 ID중복체크버튼을 비활성화 시킴
								$("#btn_duplicate").prop("disable", true);
								
							} else {
								$("#message").text("사용할 수 없는 ID입니다.");
							}
				},
				error : function(m, textStatus){ 
							alert(m); //에러메세지 얻어서 출력
							alert("에러가 발생했습니다."); 
				}
			});
			
		}
	
	</script>
</head>
<body>
	
	<input type="text" id="t_id" />
	<input type="button" value="ID중복체크하기" id="btn_duplicate" onclick="fn_process();">
	
	<!-- 아이디 중복인지 아닌지 메세지를 나타내는 div요소영역 -->
	<div id="message"></div>
</body>
</html>