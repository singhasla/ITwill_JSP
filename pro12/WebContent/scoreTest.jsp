<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%-- 
		2. scoreTest.html로부터 입력받은 점수를 다중 if ~ else문을 이용해 학점으로 변환합니다.
	 --%>
	 <%
	 	// 1. 한글처리
	 	request.setCharacterEncoding("utf-8");
	 	// 2. 입력받은 시험점수를 request객체 영역에서 꺼내와서 int score변수에 저장 시키기
	 	int score = Integer.parseInt(request.getParameter("score"));
	 %>
	 
	 <%-- 
		3. 시험 점수 100점 <--출력
	 --%>
	 <h1>시험 점수는? <%= score %>점</h1>
	 <%
	 	if(score == 100){
	 %>
	 	<h1>[경] 시험 점수 100점!! [축]</h1>
	 <%}
	 	/* 4. 입력받은 점수가 
	 	90점 이상이면 A학점 입니다/	80점 이상이면 B학점 입니다/	70점 이상이면 C학점 입니다/	60점 이상이면 D학점 입니다.
	 	그 외 점수는 F학점 입니다.
	 	*/
	 	if(score >= 90)
	 		%> <h1>A학점입니다</h1> <% 
	 	else if(score >=80)
	 		%> <h1>B학점입니다</h1> <%
	 	else if(score >=70)
			%> <h1>C학점입니다</h1> <%
		else if(score >=60)
			%> <h1>D학점입니다</h1> <%
		else 
			%> <h1>F학점입니다</h1>
	 <br>
	 <a href="scoreTest.html"> 시험점수 다시 입력하러 가기</a>
</body>
</html>