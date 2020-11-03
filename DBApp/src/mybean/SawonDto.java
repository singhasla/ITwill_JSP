package mybean;


//여러 데이터를 하나로 묶어서 처리한 SawonDto클래스
//DB에 있는 내용을 클래스 단위로 저장할 SawonDto클래스
public class SawonDto {

	//인스턴스 변수
	private int no;
	private String id;
	private String name;
	private String pass;
	private int age;
	private String addr;
	private String extension;
	private String dept;

	//getter, setter 인스턴스 메소드
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}

}
