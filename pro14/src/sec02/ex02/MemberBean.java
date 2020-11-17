package sec02.ex02;

import java.sql.Date;
public class MemberBean {

	//변수
	private String	id;  //회원아이디
	private String pwd;  //회원비밀번호
	private String name; //회원이름
	private String email;//회원이메일
	private Date joinDate;//회원가입한 날짜 

	public void setId(String id){
		this.id = id;
	}
		
	public String getId(){
		return id;
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
