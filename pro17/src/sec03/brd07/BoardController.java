package sec03.brd07;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

//http://localhost:8080/pro17/board/listArticles.do로 모든 글정보 조회 요청을하여  
//BoardController서블릿이 위 주소를 받아 처리 

//컨트롤러 역할을 하는 BoardController서블릿 
//주요역할 : action변수에 저장된 요청주소값이  /articleForm.do이면 글쓰기 창화면으로 이동해 웹브라우저에 표시하고,
//        action변수의 값이 /addArticle.do면 다음과정으로 새글을 DB에 추가 합니다.
//        upload()메소드를 호출해 글쓰기 창에서 전송된 글 관련 정보를  Map에  key/value쌍으로 저장합니다.
//        파일을 첨부한 경우 먼저 파일이름을  Map에 저장한 후  첨부한 파일을 저장소(폴더)경로에 업로드 합니다.
//        upload()메소드를 호출한 후에는 반환한  Map에서 새글정보를 가져옵니다.
//        그런다음  service클래스의 addArticle()메소드 호출시 인자로 새글 정보를 전달하면  새글정보가 DB에 등록됩니다.

/*
	1. 글쓰기창에서 새글 전송시 컨트롤러의 upload()메소드를 호출해 입력한 새글정보를 Map에 저장해서 Map을 반환 받고
	      첨부한 파일은 임시로  temp폴더에 업로드 합니다.
	2. 컨트롤러는 Service클래스의 addNewArticle()메소드를 호출하면서 새 글 정보를 인자로 전달해 t_board테이블에
	   INSERT(추가)한 후 ~~  추가한 새글정보중에 새글의 글번호를 조회해서 반환 받습니다.   
	   
	3. 컨트롤러에서 반환 받은  조회한 새글 글번호를 이용해  새 글의 글번호에 해당되는 글번호폴더를 생성하고
	   temp폴더에 업로드된 파일을  글번호폴더로 이동 시킵니다.


 BoradController서블릿 클래스에서 upload()메소드를 호출해 첨부한 파일(업로드요청할 파일)을 temp폴더에 업로드 한후 
 DB에 추가시킬 입력한 새글 정보를 Map에 담아 Map을 반환 받아 얻습니다.
 그리고 새글 정보를 DB에 INSERT추가시킨후 다시 추가된 새글의 글번호를 조회해서 가져와서 새글 글번호 폴더를 생성하고
 temp폴더에 저장된 업로드된 이미지 파일을  새글 글번호 폴더로 이동 시킵니다.


 listArticles.jsp(글목록화면)에서 글제목을 클릭했을때...
 /viewArticle.do로  요청하여 글 번호를 받아옵니다.
 그리고 그 번호에 해당하는 글정보를 DB에서 조회한후 가져와  request메모리에 바인딩한후  viewArticle.jsp뷰페이지로 전송함
*/
// 글제목을 클릭했을떄 -->  /board/viewArticle.do?articleNo=${article.articleNO}

/*
viewArtilce.jsp페이지에서 수정반영하기 버튼 클릭시...
/board/modArticle.do주소로 BoardController서블릿에 수정 요청을 하게 된다.

컨트롤러에서 수정을 요청하면 upload()메소드를 이용해 수정 데이터를 Map에 저장후 가져 옵니다.
Map의 데이터를 다시 ArticleVO객체의 변수에 저장한 후  UPDATE SQL문으로 전달하여 수정 데이터를 t_board테이블에 UPDATE함
마지막으로 temp폴더에 업로드된 수정 이미지를 다시 글번호 폴더로 이동 시키고  글 번호 폴더의 원래미이지를 삭제 합니다.

*/


/*
viewArticle.jsp페이지에서 삭제하기 버튼을 눌러 
/board/removeArticle.do라는 요청주소(글 삭제 요청 주소)를 받았을때...
삭제할 글번호에 대한 글과 그 자식글을 삭제하기 전에  먼저 삭제할 글번호와 자식 글번호를 조회해서 가져옵니다.
그리고  글을 삭제한 후 글번호로 이루어진 이미지 저장 폴더 까지 모두 삭제 합니다.
*/

/*
	답글도 새글이므로  답글 기능도 새글 쓰기 기능과 비슷합니다
	다른점은 답글창 요청(/board/replyForm.do)시 미리 부모글번호를 parentNO속성으로 세션영역에 저장해 놓고,
	답글을 작성한후 답글등록 요청(/board/addReply.do)시  세션영역에서  parentNO을 가져와 
	t_board테이블에 추가한다는 점입니다.
*/
@WebServlet("/board/*")                        
public class BoardController extends HttpServlet {

	//새글 추가시 첨부할 이미지 저장위치의 경로를 상수로 선언합니다.
	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
	
	//재료준비
	BoardService boardService;
	ArticleVO articleVO;
	
	//서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		boardService = new BoardService();
		articleVO = new ArticleVO();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}	
	
	protected void doHandle(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		//재요청(포워딩)할 요청주소를 저장할 변수 
		String nextPage = "";
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		//요청한 전체 주소중에서 2단계 요청주소 얻기 
		//     http://localhost:8080/pro17/board/listArticles.do 주소중에서
		//    /listArticles.do얻기
		//
		//    글쓰기 링크를 클릭했을떄...
		//    http://localhost:8080/pro17/board/articleForm.do 주소중에서
		//    /articleForm.do얻기 
		
		//    글쓰기 버튼을 눌렀을때...
		//    http://localhost:8080/pro17/board/addArticle.do 주소중에서
		//    /addArticle.do 얻기
		
		//   글제목을 클릭 했을떄...
		//   http://localhost:8080/pro17/board/viewArticle.do 주소중에서
		//   /viewArticle.do 얻기
			
//		viewArtilce.jsp페이지에서 수정반영하기 버튼 클릭시...
//		/board/modArticle.do주소로 BoardController서블릿에 수정 요청을 하게 된다.
		//   /modArticle.do얻기 
		
//     viewArticle.jsp페이지에서 삭제하기 버튼 클릭시...
//     /board/removeArticle.do주소로 서블릿에 삭제 요청을 하게 된다.
	 //     /removeArticle.do얻기 
		
//     viewArticle.jsp페이지에서 답글쓰기 버튼 클릭시...
//    /board/replyForm.do주소로 서블릿에  답글을 작성할수 있는 화면이동 요청을 하게 된다.
//    /replyForm.do얻기 	

//     replyForm.jsp페이지에서 답글을 입력한 후 답글 반영하기 버튼 클릭시..
//     BoardController서블릿에  /board/addReply.do주소로 답글 추가 요청함
//     /addReply.do얻기 
		String action = request.getPathInfo();
		
		//답글에 대한 부모글번호를 저장하기 위해 세션영역을 담을 변수 선언
		HttpSession session;
		
		
		System.out.println("action변수 : " + action);
		
		List<ArticleVO> articlesList = null;
		
		if(action == null){//요청한 주소가 없을때..
			
			//모든 회원정보 조회를 위한 호출
		    //리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList  = boardService.listArticles(); 
			
			request.setAttribute("articlesList", articlesList);
			
			nextPage = "/board06/listArticles.jsp";
			
		}else if(action.equals("/listArticles.do")){ 
			//모든 글정보 조회를 위한 호출
		    //리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList  = boardService.listArticles(); 
			
			request.setAttribute("articlesList", articlesList);
			
			nextPage = "/board06/listArticles.jsp";
		
		//조회된 글목록창에서 글쓰기 <a>태그를 클릭해 요청 받은  주소가 /articleForm.do 이면
		//(글쓰기 디자인 화면으로 이동 하라는 요청주소를 받았을떄)
		}else if(action.equals("/articleForm.do")){
					
			nextPage = "/board06/articleForm.jsp";
			
			
		//articleForm.jsp페이지에서 새글내용을 입력하고 글쓰기 버튼을 클릭해 글쓰기 요청을 받았을때..
		}else if(action.equals("/addArticle.do")){		
			//upload()메소드를 호출해 글쓰기 입력화면에서 입력하여 전송된 글관련 정보들을 HashMap에 key/value쌍으로 저장합니다
			//그런후, 글 입력시 추가적으로 업로드할 파일을 선택하여 글쓰기 요청을 했다면..
			//업로드한 파일명, 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 HashMap을 리턴 받는다
			//그렇지 않을 경우에는???
			//업로드한 파일명을 제외한 ~~ 입력한 글제목, 입력한 글내용을 key/value 형태의 값들로 저장되어 있는 
			//HashMap을 리턴 받는다
			Map<String, String>  articleMap  = upload(request, response);		
			//HashMap에 저장된 입력하여 DB에 추가할 새글정보(업로드할 파일명,입력한 글제목,입력한 글내용)을 다시 꺼내옵니다
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			//DB에 새글정보를 추가 하기 위해 사용자가 입력한 글정보 + 업로드할 파일명을  ArticleVO객체의 각변수에 저장함
			articleVO.setParentNO(0);//추가할 새글의 부모글번호를 0으로 저장
			articleVO.setId("hong");//추가할 새글 작성자 ID를 hong으로 저장
			articleVO.setTitle(title);//추가할 새글의 글제목 저장
			articleVO.setContent(content);//추가할 새글의 글내용 저장
			articleVO.setImageFileName(imageFileName);//추가할 새글 정보중 업로드할 파일명 저장
			
			
			//그런다음 service클래스의 addArticle()메소드 호출시 .. 인자로 새글 정보(ArticleVO객체)를 전달하면
			//새글이  DB에 INSERT할수 있다.
			//요약 : 글쓰기 창에서 입력된 정보를 ArticleVO객체에 저장한후 
			//      service클래스의 addArticle()메소드를 호출하면서 매개변수로 전달 함
			
			//->테이블에 새글을 INSERT추가 시킨 후 추가시킨 새글의 글번호를 조회해서 반환받습니다.
			int articleNO = boardService.addArticle(articleVO);
			
			//파일을 첨부한 경우에만 일을 수행 하게 끔 하기 위해 조건 주기 
			if(imageFileName != null && imageFileName.length() != 0 ){
				
				//temp폴더에 임시로 업로드된 파일에 접근하기 위해 File객체를 생성합니다
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				
				// C:\board\article_image 폴더 내부에  글번호 폴더를 생성합니다
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();//글번호에 대한 폴더 생성 ~
				
				//temp폴더에 업로드된 이미지 파일을  글번호 폴더로 이동
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
			}
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					 + " alert('새글을 추가 했습니다.');"  
			         + " location.href='" + request.getContextPath() + "/board/listArticles.do';"
					 +"</script>");
				
			return;
		
		//글제목을 클릭해 글내용 조회요청을 받았을때..	
		}else if(action.equals("/viewArticle.do")){
			//글을 조회할 글번호를 request영역에서 얻기(요청한 값 얻기)      
			String articleNO = request.getParameter("articleNo"); 
			//글번호에 해당되는 글정보를 조회하기 위해 BoardService객체의 viewArticle()메소드 호출시
			//글번호를 전달하여 조회해 옴
			articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
			//조회한 글정보(articleVO객체)를 View페이지(/board03/viewAritle.jsp)로 보여 주기 위해
			//request내장객체 영역에   조회한 글정보(articleVO객체)를 저장(바인딩)
			request.setAttribute("article", articleVO);
			//View페이지 주소 저장
			nextPage = "/board06/viewArticle.jsp";
		
		//수정반영하기 버튼을 눌러 수정 요청을 받았을떄...	
		}else if(action.equals("/modArticle.do")){
			
			//수정한 정보들을 request로부터 꺼내어서 HashMap에 저장후 HashMap을 반환 
			Map<String, String>  articleMap = upload(request, response);
			//HashMap에 저장된 수정할 정보들을 다시 꺼내어서  ArticleVO객체의 각변수에 저장
			//1.HashMpa에 저장된 수정할 정보들 꺼내오기				
			int articleNO = Integer.parseInt(articleMap.get("articleNO"));//수정할 글번호 
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			//2.꺼내온 수정할 정보들을 ArticleVO객체의 각변수에 저장
			articleVO.setArticleNO(articleNO);//글번호 저장
			articleVO.setParentNO(0);//부모글번호
			articleVO.setId("hong");//글을 수정할 사람의 id저장
			articleVO.setTitle(title);//수정할 글제목 저장
			articleVO.setContent(content);//수정할 글내용 저장
			articleVO.setImageFileName(imageFileName);//수정을 위해 다시 선택했던 이미지 파일명 저장 
			
			//BoardService객체의 modArticle()메소드 호출시 ArticleVO객체를 인자로 전달 하여 UPDATE명령 함
			boardService.modArticle(articleVO); 
			
			//UPDATE수정에 성공 했을때.....
			//수정을 위해 다시 선택했던 이미지 파일명이 존재 하면???
			if(imageFileName != null  && imageFileName.length() != 0){
				
				//추가되어 있던 원래 이미지 명을  HashMap에서 꺼내와 변수에 저장
				String originalFileName = articleMap.get("originalFileName");
				
				//수정된 이미지 파일을  temp폴더에서 -> 수정한 글번호 폴더로 이동 
				//1.수정시 업로드되는 이미지 파일의 경로를 설정
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				//2.수정한 글번호 폴더 경로를 설정
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				//2-1.수정한 글번호 폴더 생성
				destDir.mkdirs();
				//3.수정되어 업로드된  이미지 파일을 temp -> 수정한 글번호 폴더로 이동 시킴
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
				//기존에 업로드되어 있던 원본이미지 파일을 삭제 합니다.
				File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + originalFileName);
				//삭제
				oldFile.delete();
				
			}//if 끝
	
			//글 수정 후 location객체의 href속성을 이용해 수정한 글번호로 글을 조회한후 글상세 화면을 나타냅니다.
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					+ "  alert('글을 수정했습니다.');" 
					+ " location.href='" + request.getContextPath()
					+ "/board/viewArticle.do?articleNo=" + articleNO + "';" 
					+ "</script>");
			return;
		
		
		//삭제 요청 주소를 받았을때...
		}else if(action.equals("/removeArticle.do")){
			//삭제할 글번호 얻기 
			int articleNO =  Integer.parseInt(request.getParameter("articleNO"));
			//BoardService객체의 removeArticle()메소드 호출시 삭제할 글번호를 전달하여 
			//DB에 존재하는 글을 삭제한 후  삭제된 부모글과 자식글의 articleNO(글번호)글을 조회하여  ArrayList배열에 담아 리턴 받기
			List<Integer> articleNOList = boardService.removeArticle(articleNO);
			
			//삭제된 글들의 이미지 저장 폴더들을 삭제 합니다.
			for( int _articleNO     :  articleNOList ){
				
				//DB에는 모든 글들이 삭제 되었으므로
				//삭제된 글번호 폴더 까지 모두 삭제 하기 위해 경로 지정
				File imgDir = new File(ARTICLE_IMAGE_REPO + "\\" + _articleNO);
				
				if(imgDir.exists()){
					//DB에 삭제된 글에 대한    글번호 폴더 삭제 
					FileUtils.deleteDirectory(imgDir);		
				}	
			}//for  
			
		      
			PrintWriter pw  = response.getWriter();
			pw.print("<script>" + "   alert('글을 삭제 했습니다.');" + " location.href='"
					            + request.getContextPath() + "/board/listArticles.do';"
					            + "</script>");
			
			return;
			
		//답글쓰기 버튼을 클릭해 답글을 작성할수 있는 화면으로 이동 시켜줘~~ 라는 요청 주소를 받았을때..	
		}else if(action.equals("/replyForm.do")){
			
			System.out.println(request.getParameter("parentNO"));
			
			//답글창 요청시 .. 미리 ~~ 부모글번호(주글의 글번호)를 세션영역에  parentNO속성으로 갖게 하여 저장 함
			//1.request에서 부모글번호를 얻어온다
			int parentNO  = Integer.parseInt(request.getParameter("parentNO"));
			//2.세션영역 얻기  -> request객체의 getSession()메소드를 호출하면 반환 값으로 Session영역을 얻을수 있다.
			session = request.getSession();
			//3.세션영역에  주글(부모글)번호를 저장
			session.setAttribute("parentNO", parentNO);
			//답글을 작성할수 있는 화면(답글창) 재요청 할 주소 저장
			nextPage = "/board06/replyForm.jsp";
		
		//답글 반영하기 버튼 클릭해 답글내용을  DB에 추가해줘~ 라는 요청 주소를 받았을때...
		}else if(action.equals("/addReply.do")){
			//부모 글번호(parentNO)를  세션영역에서 꺼내오기 
			session = request.getSession();//기존에 존재 했던 session영역 그대로 사용하기 위해 얻기 
			int parentNO = (Integer)session.getAttribute("parentNO");
			//session영역에 다시 접근해서  저장되어 있는 부모글번호 삭제
			session.removeAttribute("parentNO");
			
			Map<String, String>  articleMap = upload(request, response);
			String title = articleMap.get("title");
			String content = articleMap.get("content");
			String imageFileName = articleMap.get("imageFileName");
			
			//articleVO객체에 DB에 insert할 답글정보들을 임시로 저장 
			articleVO.setParentNO(parentNO);//DB에 추가시킬 답글의 부모글번호(주글번호) 저장 
			articleVO.setId("lee");//DB에 추가시킬 답글을 작성하는 사람의 id
			articleVO.setTitle(title);//DB에 추가시킬 작성한 답글 제목 
			articleVO.setContent(content);//DB에 추가시킬 작성한 답글 내용 
			articleVO.setImageFileName(imageFileName); //DB에 추가시킬 첨부한 답글의 이미지 파일명 저장 
			
			//BoardService객체의 addReply메소드 호출시 articleVO객체를 전달하여 DB에 작성한 답글정보를 insert하는 명령!
			//답글 정보를 DB에 insert후에 답글의 글번호를 다시 조회 해 온다
			int articleNO = boardService.addReply(articleVO);
			
			//파일을 첨부한 경우에만 일을 수행 하게 끔 하기 위해 조건 주기 
			//답글에 첨부한 이미지파일을 temp폴더에서 답글의 글번호 폴더로 이동시키는 부분 
			if(imageFileName != null && imageFileName.length() != 0 ){
				
				//temp폴더에 임시로 업로드된 파일에 접근하기 위해 File객체를 생성합니다
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				
				// C:\board\article_image 폴더 내부에  글번호 폴더를 생성합니다
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdir();//글번호에 대한 폴더 생성 ~
				
				//temp폴더에 업로드된 이미지 파일을  글번호 폴더로 이동
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
			}
			
			//DB에 추가한 답글의 글번호를 조회 하기 위해...
			///board/viewArticle.do?추가한답글의 글번호 전달 
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					 + " alert('답글을 추가 했습니다.');"  
			         + " location.href='" 
					 + request.getContextPath() 
					 + "/board/viewArticle.do?articleNo=" + articleNO +"';"
					 +"</script>");
				
			return;				
		}
		
			
		//뷰페이지로 포워딩시 request전달 
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
		
	}//doHandle메소드 끝
	
	//파일 업로드 처리를 위한 메소드
	private Map<String, String> upload(HttpServletRequest request, 
									   HttpServletResponse response)
											   throws ServletException,IOException{
		
		Map<String, String> articleMap = new HashMap<String,String>();
		
		String encoding = "utf-8";
		
		//글쓰기를 할때 첨부한 이미지를 저장할 폴더 경로에 접근 하기 위한 File객체 생성
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		
		//업로드할 파일 데이터를 임시로 저장할 객체 메모리 생성
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//파일업로드시~ 사용할 임시 메모리 최대 크기 1메가 바이트로 설정
		factory.setSizeThreshold(1024*1024*1);
		
		//임시메모리에 파일 업로드시  지정한 1메가 바이트 크기를 넘길경우 업로드될 파일 경로(폴더)를 지정함
		factory.setRepository(currentDirPath);
		
		//파일을 업로드할 메모리를 생성자쪽으로 전달받아 저장한 파일업로드를 처리할 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try{
			//업로드할 파일에 대한 요청 정보를 가지고 있는 request객체를 parseRequest메소드 호출시 인자로 전달 하면
			//request객체에 저장되어 있는 업로드할 파일의 정보들을 추출(파씽)해서 DiskFileItem객체에 저장후
			//DiskFileItem객체를 ArrayList에 추가합니다.
			//그후 ArrayList를 반환 받습니다.
			List items  = upload.parseRequest(request);
			
			//ArrayList배열 크기 만큼 (DiskFileItem객체(요청할 아이템 하나의 정보)의 갯수 만큼 )반복 
			for(int i=0;   i<items.size(); i++ ){
				
				//ArrayList 가변길이 배열에서 DiskFileItem객체를 얻는다.
				FileItem fileItem = (FileItem)items.get(i);
				
				//DiskFileItem객체의 정보가 업로드한 파일 아이템이 아닐 경우 
				if(fileItem.isFormField()){
					
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding) );
					
					//articleForm.jsp페이지에서 입력한 글제목 과 글내용만 따로 HashMap에 key-value형식으로 저장
					//HashMap에 저장된 데이터의 예 ->  {title=입력한글제목   , content=입력한글내용       }
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
							
				}else{//DiskFileItem객체의 정보가 파일 아이템일 경우 ~~ 
					  //글을 입력할때  첨부파일을 선택하여 글을 입력 했을  경우~~
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize() + "bytes");
					
					//articleForm.jsp페이지에서 입력한 글제목, 글내용, 요청할 업로드 파일등.. 정보를?
					//HashMap에  (key=value) 형식으로 저장합니다
					//(imageFileName = 업로드할 파일이름, title=입력한글제목, content=입력한 글내용)형식으로 저장
					//HashMap에 저장된 데이터의 예 -> {imageFileName=3.png, title=글제목, content=글내용 }
					articleMap.put(fileItem.getFieldName(), fileItem.getName());
					
					//전체 : 업로드할 파일이 존재 하는 경우 업로드할 파일의 이름으로 저장소에 업로드합니다
					//파일크기가 0보다 크다면(업로드할 파일이 있다면)
					if(fileItem.getSize() > 0){
						//업로드할 파일명을 얻어 파일명의 뒤에서부터 \\문자열이 들어 있는지 인덱스 위치를 알려주는데..
						//없으면 -1을 반환
						//뒤에서 부터 문자열이 들어 있는지 확인후 있으면 인덱스 위치를 알려준다
						int idx = fileItem.getName().lastIndexOf("\\");
						
						if(idx == -1){
							idx = fileItem.getName().lastIndexOf("/");// -1얻기 
						}

						//업로드할 파일 명 얻기 
						String fileName = fileItem.getName().substring(idx + 1);
						
						
						//업로드할 파일 경로 + 업로드할 파일명 을 하나의 문자열로 만들어서 접근할 File객체 생성
						//참고 : 첨부한 파일을 먼저 temp폴더에 업로드 합니다.
						File uploadfile = new File(currentDirPath + "\\temp\\" +  fileName);
						//실제 파일 업로드
						fileItem.write(uploadfile);				
					}//end if
				}//end if	
			}//end for
	
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleMap;//해쉬맵을 리턴
	}//upload메소드 끝
	
}//BoardController클래스 끝





