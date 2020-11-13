<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	// 1번 form에서 요청한 데이터들 한글처리 
	request.setCharacterEncoding("UTF-8");
%>

<%!
	// 1번 form태그내부에 존재하는  <input>태그의 value속성값으로 요청하는 메소드 만들기
	public String getParam(HttpServletRequest request, String param){
		
		//매개변수로 전달받은 request객체에 요청한 데이터가 저장되어 있다면
		if(request.getParameter(param) != null){
			
			return request.getParameter(param);
		
		}else{//request객체에 요청한 데이터가 없을 경우 
			
			return "";	
		}
	}//getParam메소드 끝

%>



<%--
	스토리  설명 : 
	여러개의 파일을 다중업로드할수 있도록 여러개의 <input>태그들을 만드는데..
	이왕이면 딱 정해진 <input>태그를 만드는 것보다  사용자가 원하는 업로드할 파일의 개수만큼 
	<input>태그를 동적으로 늘려서 다중파일 업로드 요청후 업로드 해보자.
 --%>
 	<h2>다중 파일 업로드</h2>
 
 	<%-- 1번 form태그 - 요청하는 클라이언트가 업로드할 파일수를 입력받아 요청하는 디자인      --%>
 	<form action="multi.jsp" method="post">
 		이름 : <input type="text" name="name" value='<%=getParam(request, "name")%>'> <br>
 		주소 : <input type="text" name="addr" value='<%=getParam(request, "addr")%>'> <br>
 		하고싶은말 :  <br>
 		<textarea rows="3" cols="70" name="note"><%=getParam(request, "note")%></textarea> <br>
 		업로드할 파일개수 : <input type="text" name="add" size="2">
 		<input type="submit" value="확인">
 	</form>
 
 <%
 	//업로드할 파일개수를 저장할 변수 
 	int filecnt = 0;
 
 	//1번 form태그에서 입력한 업로드할 파일개수가 존재 한다면
 	if(request.getParameter("add") != null){
 		//입력한 업로드할 파일개수를 request에서 얻어 저장
 		filecnt = Integer.parseInt(request.getParameter("add"));
 	}

 %>



	<%-- 2번 form태그  - 입력한 업로드할 파일개수 만큼 
	                  <input>태그를 동적으로 만들어서 다중파일업로드 요청하는 <form>   --%>
	<form action="multi_pro.jsp"  method="post"  enctype="multipart/form-data">
	
		<input type="hidden" name="name" value='<%=getParam(request, "name")%>'>
		<input type="hidden" name="addr" value='<%=getParam(request, "addr")%>'>
		<input type="hidden" name="note" value='<%=getParam(request, "note")%>'>
		
		<%
			//for문을 이용하여  입력한 업로드할 파일개수만큼  
			//파일업로드를 위해 파일을 선택할수 있는 <input>디자인을 늘려서 만들어준다
			for(int i=0;  i<filecnt; i++){
		%>	
			 <%=i+1%>번째 파일 선택  : <input type="file" name="upFile<%=i%>"> <br>
		<%		
			}
		%>
		<input type="button" value="다중파일 업로드 요청" onclick="Check(this.form);"/>
	</form>

	<script type="text/javascript">
	
		//2번 form태그에서 다중파일업로드요청 버튼 클릭했을때 호출되는 함수로
		//		동적으로 만들어지는 <input type="file">태그 중.. 누락된 곳이 있다면 검사
		function Check(f) {
			
			//2번 form태그를 선택해서 가져와서 2번form태그 내부에 존재하는 모든 input태그의 개수 구함
			//forms[] 배열 	: <form>태그에 접근하는 방법
			//elements속성 	: <form>태그 내부에 있는 모든 <input>태그들을 말함
			//length		: 개수, 길이
			var cnt = f.elements.length;
			
			//누락된 파일업로드 위치를 나타낼 변수
			var filecnt = 1;
			/* 
				(설명) 2번 form태그에 업로드될 파일개수를 사용자에 의해서 동적으로 입력받기 때문에
						2번 form내부의 for문을 이용하여 <input type="file">태그가 동적으로 만들어진다.
						동적으로 만들어진 <input type="file">태그중에서	선택하지 않은 <input>태그가 존재한다면
						' x번째 파일정보를 선택하지 않았습니다. '	<-- 경고메세지창을 나타내자
			 */
			 //2번 form내부에 있는 모든 <input>의 개수만큼 반복하는데.
			 for(i=0;i<cnt;i++){
				 
				 //만약 2번 form내부에 있는 <input> type속성의 값이 file인 태그와 같고
				 if(f.elements[i].type == "file"){
					 
					 //만약 <input type="file">태그중에서 선택하지 않은 태그가 있다면
					 //(업로드할 파일을 지정하지 않았다면..)
					 if(f.elements[i].value == ""){
						 
						 var msg = filecnt + "번째 파일정보를 선택하지 않았습니다.\n 모두다 선택해주세요";
						 alert(msg);
						 
						 //누락된 <input>태그에 포커스 주기
						 f.elements[i].focus();
						 
						 //for문 빠져나가기
						 return;
					 }
					 
					 //<input>태그의 type속성의 값이 file일때만 filecnt변수의 값을 1 증가
					 filecnt++;
				 }
				 
			 }//for문 끝
			 
			 
			 //2번 form태그의 action속성에 작성된 서버페이지로 다중파일업로드 요청
			 f.submit();
			 
		}
	
	</script>

</body>
</html>







