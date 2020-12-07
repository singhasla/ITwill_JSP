package sec02.ex02;

import java.sql.Date;

//MVC중에 Model의 역할을 하는 클래스 

public class MemberVO {
	
	private String id, pwd, name, email;
	private Date joinDate;
	
	public MemberVO() {
		System.out.println("MemberVO 생성자 호출");
	}
	
	
	public MemberVO(String id, String pwd, String name, String email) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
	}

	//객체 생성시 멤버변수값을 초기화 시킬 생성자
	public MemberVO(String id, 
					String pwd, 
					String name, String email, Date joinDate){
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.joinDate = joinDate;		
	}

	//getter,setter메소드 
	//Source메뉴클릭 -> getter,setter메소드 메뉴 클릭 
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




