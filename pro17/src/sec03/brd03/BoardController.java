package sec03.brd03;

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


/*	새 글 작성시 새 게시글별 폴더 만들기
 * 
 * 	1. 글쓰기창에서 새 글 전송시 컨트롤러의 upload()메소드를 호출해 입력한 새 글정보를 Map에 저장해서 Map을 반환받고
 * 		첨부한 파일은 임시로 temp라는 폴더에 업로드한다.
 * 	2. 컨트롤러는 Service클래스의 addNewArticle()메소드를 호출하면서 새 글정보를 인자로 전달해 t_board테이블에
 * 		INSERT(추가)한 후~ 추가한 새 글 정보중에 새 글의 글번호를 조회해서 반환받는다.
 *  3. 컨트롤러에서 반환받은 조회한 새글 글 번호를 이용해서, 새 글의 글 번호에 해당되는 글 번호폴더를 생성하고
 *  	temp폴더에 업로드된 파일을 글번호폴더로 이동시킨다.
 *  
 *  BoardController서블릿 클래스에서 upload()메소드를 호출해 첨부한 파일(업로드요청할 파일)을 temp폴더에 업로드 한 후
 *  DB에 추가시킬 입력한 새 글정보를 Map에 담아 Map을 반환받아 얻는다.
 *  그리고 새 글정보를 DB에 INSERT한 후 다시 추가된 새 글의 글번호를 조회해서 가져와서 새 글번호 폴더를 생성하고
 *  temp폴더에 저장된 업로드된 이미지 파일을 새 글번호 폴더로 이동시킨다.
 */


//@WebServlet("/board/*")                        //request    /board/articleForm.do
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
		String action = request.getPathInfo();
		
		System.out.println("action변수 : " + action);
		
		List<ArticleVO> articlesList = null;
		
		if(action == null){//요청한 주소가 없을때..
			
			//모든 회원정보 조회를 위한 호출
		    //리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList  = boardService.listArticles(); 
			
			request.setAttribute("articlesList", articlesList);
			
			nextPage = "/board02/listArticles.jsp";
			
			
		} else if(action.equals("/listArticles.do")){ 
			//모든 글정보 조회를 위한 호출
		    //리턴 받는 값은 조회된 ArticleVO객체들이 저장되어 있는 ArrayList배열
			articlesList  = boardService.listArticles(); 
			
			request.setAttribute("articlesList", articlesList);
			
			nextPage = "/board02/listArticles.jsp";
		
			
		//조회된 글목록창에서 글쓰기 <a>태그를 클릭해 요청 받은  주소가 /articleForm.do 이면
		//(글쓰기 디자인 화면으로 이동 하라는 요청주소를 받았을떄)
		} else if(action.equals("/articleForm.do")){
					
			nextPage = "/board02/articleForm.jsp";
			
			
		//articleForm.jsp페이지에서 새글내용을 입력하고 글쓰기 버튼을 클릭해 글쓰기 요청을 받았을때..
		} else if(action.equals("/addArticle.do")){		
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
			int articleNO = boardService.addArticle(articleVO);	//->테이블에 새 글을 INSERT한 후, 추가시킨 새 글의 글번호를 조회해서 반환받는다.
			
			
//글번호별 업로드폴더 생성하기	
			//파일을 첨부한 경우에만 일을 수행하게끔 하기위해 조건주기
			if(imageFileName != null && imageFileName.length() != 0){
				//1.먼저 temp폴더에 업로드 파일 생성 후, 
				//2.글번호 폴더를 생성한 후, 
				//3.생성한 글번호 폴더로 업로드 파일을 이동시킴
				
				//temp폴더에 임시로 업로드된 파일에 접근하기 위해 File객체를 생성한다
				File srcFile = new File(ARTICLE_IMAGE_REPO +"\\"+"temp"+"\\"+imageFileName);
				
				//C:\board\article_image폴더 내부에 글 번호를 생성한다
				File destDir = new File(ARTICLE_IMAGE_REPO +"\\"+articleNO);
				destDir.mkdir();//글번호에 대한 폴더 생성
				
				//temp폴더에 업로드된 이미지 파일을 글번호 폴더로 이동
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>"
						+" alert('새 글을 추가했습니다.');"
						+" location.href='"+request.getContextPath()+"/board/listArticles.do';"
					+"</script>");
//		

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
						File uploadfile = new File(currentDirPath + "\\temp\\" + fileName);
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





