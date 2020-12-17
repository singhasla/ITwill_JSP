package sec03.brd05;

import java.sql.Date;

//DTO
public class ArticleVO {// 조회한 글의 정보를 저장하는 VO(DTO)역할을 하는 클래스

	private int level;// 글의 들여쓰기 정도(깊이)
	private int articleNO;// 글번호
	private int parentNO;// 부모글번호
	private String title;// 글제목
	private String content;// 글내용
	private String imageFileName;// 글작성시 추가한 이미지명
	private String id;// 글을 작성한 사람의 id
	private Date writeDate;// 글을 작성한 날짜

	public ArticleVO() {

	}

	public ArticleVO(int level, int articleNO, int parentNO, String title, String content, String imageFileName,
			String id) {
		this.level = level;
		this.articleNO = articleNO;
		this.parentNO = parentNO;
		this.title = title;
		this.content = content;
		this.imageFileName = imageFileName;
		this.id = id;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getArticleNO() {
		return articleNO;
	}

	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}

	public int getParentNO() {
		return parentNO;
	}

	public void setParentNO(int parentNO) {
		this.parentNO = parentNO;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	
	
	
}







