<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    
    //1. 수정하기 위해 입력한 정보들은 request객체 메모리에 저장되어 있기 때문에..
    //		request객체 메모리영역에서 꺼내오기 전에 한글처리
		request.setCharacterEncoding("utf-8");
    
	//2. 수정할 직원의 정보를 request영역에서 얻기
  		String no = request.getParameter("no");
	
  	//3. SawonDto객체를 생성하여 모두 저장
	%>
	
		<jsp:useBean id="dto" class="mybean.SawonDto"/>
		<jsp:setProperty property="*" name="dto"/>
		
		<%-- 
			4. SawonDto객체에 저장된 수정할 내용을 DB에 전달하여 UPDATE하기위해
				SawonDao객체 생성 후 메소드 호출 
		--%>
		<jsp:useBean id="dao" class="mybean.SawonDao"/>
		<%
			dao.modifySawon(dto);	//DB에 UPDATE하기 위해 메소드 호출
		%>
				
		
		<script type="text/javascript">
			window.alert("업데이트 성공!");
			
			//자바스크립트의 재요청(포워딩)기술?
			//index.jsp로 이동
			location.href="index.jsp";
		</script>