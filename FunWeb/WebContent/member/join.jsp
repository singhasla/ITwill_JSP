<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
 	<script type="text/javascript">
 		//중복체크 버튼을 눌렀을 때 호출되는 함수
 		function winopen() {
			//아이디를 입력하지 않았다면
			if(document.fr.id.value == ""){
				alert("아이디를 입력하세요.");
				document.fr.id.focus();
				return;
			} else {
				var fid = document.fr.id.value;
				
				var url = "join_IDCheck.jsp?userid=" + fid;
				var name = "";
		        var option = "width = 400, height = 200";
		        window.open(url, name, option);
			}
		}
 	</script>
 	
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<header>
			<div id="login">
				<a href="../member/login.jsp">login</a> | <a
					href="../member/join.jsp">join</a>
			</div>
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
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>Join Us</h1>
			<form action="joinPro.jsp" id="join" name="fr" method="post" >
				<fieldset>
					<legend>Basic Info</legend>
					<label>User ID</label> <input type="text" name="id" class="id">
					<input type="button" value="중복체크" class="dup" onclick="winopen();"><br>
					<label>Password</label> <input type="password" name="passwd"><br>
					<label>Retype Password</label> <input type="password" name="passwd2"><br>
					<label>Name</label> <input type="text" name="name"><br>
					<label>E-Mail</label> <input type="email" name="email"><br>
					<label>Retype E-Mail</label> <input type="email" name="email2"><br>
				</fieldset>

				<fieldset>
					<legend>Optional</legend>
					<label>Address</label> <input type="text" name="address"><br>
					<label>Phone Number</label> <input type="text" name="tel"><br>
					<label>Mobile Phone Number</label> <input type="text" name="mtel"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="회원가입" class="submit"> 
					<input type="reset" value="초기화" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<footer>
			<hr>
			<div id="copy">
				All contents Copyright 2011 FunWeb 2011 FunWeb Inc. all rights
				reserved<br> Contact mail:funweb@funwebbiz.com Tel +82 64 123
				4315 Fax +82 64 123 4321
			</div>
			<div id="social">
				<img src="../images/facebook.gif" width="33" height="33"
					alt="Facebook"> <img src="../images/twitter.gif" width="34"
					height="34" alt="Twitter">
			</div>
		</footer>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>