<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>

	<%
		//session영역에 저장된 값 얻기
		Object obj = session.getAttribute("id"); //반환받은 객체는 입력한 아이디를 문자열객체.
		
		//다운캐스팅 하여 저장
		//이유 : String객체에는 equalse(), toString() 호출해 서 사용 하기 위함.
		String id = (String)obj;
	
		//session내장객체 메모리영역에 세션id값이 저장되어 있지 않으면?  -> 로그인이 되지않는 화면
		if(id == null || id.equals("")){
	%>
		<div id="login">
			<a href="../member/login.jsp">login</a> | 
			<a href="../member/join.jsp">join</a>
		</div>
	<%		
		}else{//session내장객체 메모리영역에 세션id값이 저장되어 있으면? -> 로그인이 된 화면
	%>	
		<div id="login">
	 		<%=id %>님 로그인중...
	 		<a href="../member/logout.jsp">logout</a>
	 	</div>
	<%			
		}
		
	%>	
	<div class="clear"></div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<img src="../images/logo.gif" width="265" height="62" alt="Fun Web">
	</div>
	<!-- 로고들어가는 곳 -->
	<nav id="top_menu">
	<ul>
		<li><a href="../index.jsp">HOME</a></li>
		<li><a href="../company/welcome.jsp">COMPANY</a></li>
		<li><a href="#">SOLUTIONS</a></li>
		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
		<li><a href="#">CONTACT US</a></li>
	</ul>
	</nav>
</header>