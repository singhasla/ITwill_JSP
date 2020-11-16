<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%
    request.setCharacterEncoding("euc-kr");
%>
<%
    // C: 드라이브에 미리 test라는 폴더를 만들어 놓으세요
			String savePath = "c:/test/"; // 저장할 디렉토리 (절대경로)
			int sizeLimit = 10 * 1024 * 1024; // 10메가까지 제한 넘어서면 예외발생
			String fileName = "";
			String originalFileName = "";
			try {
				MultipartRequest multi = 
				        new MultipartRequest(request, savePath, sizeLimit, "euc-kr",
											 new DefaultFileRenamePolicy());
				Enumeration formNames = multi.getFileNames(); // 폼의 이름 반환
				String formName = (String) formNames.nextElement(); // 자료가 많을 경우엔 while 문을 사용
				fileName = multi.getFilesystemName(formName); // 파일의 이름 얻기
				originalFileName = multi.getOriginalFileName(formName); //원래 이름 가져오기
				String userName = "";

				if (fileName == null) { // 파일이 업로드 되지 않았을때
					out.print("파일 업로드 되지 않았음");
				} else { // 파일이 업로드 되었을때
					userName = multi.getParameter("userName");
					out.print("올린 사람 : " + userName + "<br>");
					out.print("file 태그 이름 : " + formName + "<br>");
					out.print("저장된 파일명 : " + fileName + "<br>");
					out.print("원래 파일명 : " + originalFileName + "<br>");
				} //else 끝
			} catch (Exception e) {
				out.print("예외 상황 발생..! ");
			} //catch
%>

<html>
<head>
<script language="javascript">
	function delfile() {
		document.myform.action = './delup.jsp'
		document.myform.submit();
	}

	function down() {
		document.myform.action = './down.jsp'
		document.myform.submit();
	}
</script>
</head>
<body>
	<form name="myform" method=post>
		<input type="text" value="<%=fileName%>" name="fileName"> 
		<input type=button value='파일삭제' size=30 onClick="delfile()"> 
		<input type=button value='파일다운' size=30 onClick="down()">
	</form>
</body>
</html>


