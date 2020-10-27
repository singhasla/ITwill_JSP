package sec01.ex01;

import java.sql.Date;

//자바빈의 종류 중 VO클래스

// 역할1. 입력한 회원정보를 클래스 단위로 저장해서 객체 생성 후 DB에 한꺼번에 전송을 하기 좋게 도와주는 클래스
// 역할2. DB로부터 조회된 한 사람의 회원정보를 클래스단위로 저장하게 도와주는 클래스


// t_member테이블을 참고해 MemberBean클래스를 작성한다.
// MemberBean클래스의 속성은 t_member회원테이블의 각 컬럼이름을 그대로 사용하며
// 자료형도 컬럼 이름의 자료형과 동일하게 선언한다.
public class MemberBean {
	
	/* t_member회원테이블의 컬럼 이름과 동일하게 변수이름과 자료형을 선언 */
	private String id;
	private String pwd;
	private String name;
	private String email;
	private Date joinDate;

	/* 아무 일도 하지 않는 기본생성자 */
	public MemberBean(){}
	
	/* 파라미터가 4개인 생성자 */
	public MemberBean(String id, String pwd, String name, String email){
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
	}

	/* getter, setter */
	// 단축키 : alt + shift + s -> r
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
}
