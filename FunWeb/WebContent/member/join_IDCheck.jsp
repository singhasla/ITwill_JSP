<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
		// 6. 사용함 버튼을 눌렀을 때 호출되는 메소드로
		//		자식창(팝업창)join_IDCheck.jsp에 입력되어 있는 아이디값을?
		//		부모창(join.jsp)의 아이디 입력<input>태그에 넣어주고,
		//		팝업창을 닫는 메소드
		function result(){
			
			//부모창 아이디 입력하는곳 ← 자식창의 아이디 입력값 대입;
			opener.document.fr.id.value = document.nfr.userid.value;
			
			//팝업창 닫기
			window.close();
		}
	</script>
	
</head>
<body>
	<%
		// 1. join.jsp의 function winopen()함수에 의해서 전달 받은 입력한 아이디 얻기
		// 2. 밑의 중복확인 버튼을 눌렀을때 form태그로부터 전달 받은 아이디 얻기.
		// 		1. 과 2. 두가지 역할을 함
		String id = request.getParameter("userid");
	
		// 3. DB에 저장된 아이디와 회원가입을 위해 입력한 아이디를 비교하기 위해..
		//		MemberDAO객체를 생성하여 메소드 호출시 입력한 아이디를 매개변수로 전달하여 DB작업
		MemberDAO mdao = new MemberDAO();
		//아이디 중복 체크 유무 반환 받기 (1을 반환 받으면 중복, 0을 반환 받으면 중복아님)
		int check = mdao.idCheck(id);
		
		// 4. check변수의 값이 1이면 "사용중인 ID입니다."
		//						0이면 "사용가능한 ID입니다."
		if(check == 1)
			out.println("사용중인 ID입니다.");
		else{
			out.println("사용가능한 ID입니다.");
	%>
		<%--
			5. 사용가능한 아이디이므로 사용함 버튼을 눌러 부모창에 사용가능한 아이디 출력하고,
				자식창(팝업창)join_IDCheck.jsp 닫기		
		--%>	
		<input type="button" value="사용함" onclick="result()">
	<%
		}
	%>
	
	<%-- 
		위 1번에서 입력한 아이디를 아래의 디자인<input>에 출력해주고
		확인 후, 중복확인 버튼을 눌렀을때 중복체크를 다시 확인해준다. join_IDCheck.jsp페이지로 요청한다.
	 --%>
	<form action="join_IDCheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="userid" value="<%=id %>"/>
				 <input type="submit" value="중복확인"/>
	</form>
</body>
</html>