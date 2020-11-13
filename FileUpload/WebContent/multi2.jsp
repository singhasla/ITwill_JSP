<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>다중 파일 업로드 요청</h2>
	
	<form action="multi_pro.jsp" method="post" enctype="multipart/form-data" name="f">
		이름 : <input type="text" name="name"> <br>
 		주소 : <input type="text" name="addr"> <br>
 		하고싶은말 :  <br>
 		<textarea rows="3" cols="70" name="note"></textarea> <br>
 		업로드할 파일개수 : <input type="text" name="add" size="2">
 		<input type="button" value="추가" onclick="addInput();"> <br>
		<div id="inputDiv"></div>
		<input type="button" value="파일업로드요청" onclick="Check(this.form);">
	</form>

	<script type="text/javascript">
	
		function addInput() {
			var filecnt = document.f.add.value;
			
			//div태그를 선택해서 가져오기
			var div = document.getElementById("inputDiv");
			
			var msg = "";
			
			//입력한 <input> 태그의 개수만큼 반복해서 <input type="file">태그를 생성하여 
			//div태그영역에 동적으로 추가
			for(i=0;i<filecnt;i++){
				
				msg += "<input type='file' name='upfile"+ i +"'/><br>";
				
			}
				//div태그영역 내부에 msg변수에 저장된 <input>태그를 추가
				div.innerHTML = msg;
		}
		
	</script>


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







