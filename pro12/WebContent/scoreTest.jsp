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
		2. scoreTest.html�κ��� �Է¹��� ������ ���� if ~ else���� �̿��� �������� ��ȯ�մϴ�.
	 --%>
	 <%
	 	// 1. �ѱ�ó��
	 	request.setCharacterEncoding("utf-8");
	 	// 2. �Է¹��� ���������� request��ü �������� �����ͼ� int score������ ���� ��Ű��
	 	int score = Integer.parseInt(request.getParameter("score"));
	 %>
	 
	 <%-- 
		3. ���� ���� 100�� <--���
	 --%>
	 <h1>���� ������? <%= score %>��</h1>
	 <%
	 	if(score == 100){
	 %>
	 	<h1>[��] ���� ���� 100��!! [��]</h1>
	 <%}
	 	/* 4. �Է¹��� ������ 
	 	90�� �̻��̸� A���� �Դϴ�/	80�� �̻��̸� B���� �Դϴ�/	70�� �̻��̸� C���� �Դϴ�/	60�� �̻��̸� D���� �Դϴ�.
	 	�� �� ������ F���� �Դϴ�.
	 	*/
	 	if(score >= 90)
	 		%> <h1>A�����Դϴ�</h1> <% 
	 	else if(score >=80)
	 		%> <h1>B�����Դϴ�</h1> <%
	 	else if(score >=70)
			%> <h1>C�����Դϴ�</h1> <%
		else if(score >=60)
			%> <h1>D�����Դϴ�</h1> <%
		else 
			%> <h1>F�����Դϴ�</h1>
	 <br>
	 <a href="scoreTest.html"> �������� �ٽ� �Է��Ϸ� ����</a>
</body>
</html>