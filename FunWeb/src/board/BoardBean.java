package board;

import java.sql.Timestamp;

//자바빈 클래스 중에 dto 역할
public class BoardBean {
	
	//변수
	private int num;		//게시물 번호
	private String name;	//게시물 작성자 이름
	private String passwd; 	//게시물 비밀번호
	private String subject;	//게시물 제목
	private String content;	//게시물 내용
	private int re_ref;		//답변글 작성시 주글과 답변글이 속한 그룹의 값
	private int re_lev;		//답변글의 들여쓰기 정도값
	private int re_seq;		//답변글들 내의 순서값
	private int readcount; 	//게시물 조회수
	private Timestamp date;	//게시물 작성 날짜
	private String ip;		//게시물 작성 클라이언트의 IP주소

	
	//getter, setter메소드
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
}