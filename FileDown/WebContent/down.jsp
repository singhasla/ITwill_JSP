<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*"%>

<% 
	//다운로드할 파일 이름(업로드한 파일 이름)이 한글일경우 한글깨짐 방지를 위한 문자셋 방식을 EUC_KR로 지정 
    String filename = new String((request.getParameter("fileName")).getBytes("8859_1"), "EUC_KR");
    String filePath = "c:/test/"; // 다운로드(업로드)절대경로.
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    File viewFile = null;
    boolean skip = false;
    String client = "";

    try {
        String fname1 = "";
        String fname2 = "";
        String fname = "";
        fname = filename;
        fname1 = new String(fname.getBytes("8859_1"), "euc-kr");

        try {
            file = new File(filePath, fname);
            viewFile = new File(filePath, fname1);
            out.print("file : " + file);
            in = new FileInputStream(file);
        } catch (FileNotFoundException fe) {
            skip = true;
        } //catch

        fname2 = new String(fname1.getBytes("euc-kr"), "8859_1");

        response.reset();
        //클라이언트가 다운로드 요청시 사용한 웹브라우저 정보 얻기
        client = request.getHeader("User-Agent");
        
       // System.out.println(client); //https://blog.naver.com/dark9999/undefined  참고
        
       
        response.setContentType("application/x-msdownload;");
        response.setHeader("Content-Description", "JSP Generated Data");

        if (!skip) {
            if (client.indexOf("MSIE 5.5") != -1) {
                response.setHeader("Content-Type", "doesn/matter; charset=euc-kr");
                response.setHeader("Content-Disposition",
                        "filename=" + new String(fname.getBytes("euc-kr"), "8859_1"));
            } else {
                response.setHeader("Content-Type", "application/octet-stream; charset=euc-kr");
                response.setHeader("Content-Disposition",
                        "attachment; filename=" + new String(fname.getBytes("euc-kr"), "8859_1"));
            } //else
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setHeader("Content-Length", "" + file.length());
            response.setHeader("Pragma", "no-cache;");
            response.setHeader("Expires", "-1;");
			
            out.clear();
            out = pageContext.pushBody();
            
            os = response.getOutputStream();
            byte b[] = new byte[4096];
            int leng = 0;
            while ((leng = in.read(b)) > 0) {
                os.write(b, 0, leng);
            } //while
        } else {
            out.println("<script language='javascript'>");
            out.println("alert('File Downloading Fail !!');");
            out.println("</script>");
            return;
        } //else
    } catch (Exception e) {
        System.out.println(e);
    } finally {
        if (in != null)
            in.close();
        if (os != null)
            os.close();
    } //finally
%>


