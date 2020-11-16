
package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//�옄諛붾퉰 �겢�옒�뒪�쓽 醫낅쪟以� DAO�뿭�븷�쓣 �븯�뒗 �겢�옒�뒪
//DB�뿰寃� �썑 �옉�뾽�븯�뒗 �겢�옒�뒪 (鍮꾩쫰�땲�뒪濡쒖쭅�쓣 泥섎━�븯�뒗 �겢�옒�뒪)
public class MemberDAO {

	Connection con = null; //DB�� 誘몃━�뿰寃곗쓣 留븐� �젒�냽�쓣 �굹���궡�뒗 媛앹껜瑜� ���옣�븷 議곗긽 �씤�꽣�럹�씠�뒪 ���엯�쓽 蹂��닔 
	PreparedStatement pstmt = null; //DB(jspbeginner)�뿉 SQL臾몄쓣 �쟾�넚�빐�꽌 �떎�뻾�븷 媛앹껜瑜� ���옣�븷 蹂��닔 
	ResultSet rs = null;//DB�뿉 SELECT寃��깋�븳 寃곌낵�뜲�씠�꽣�뱾�쓣 �엫�떆濡� ���옣�빐 �넃�쓣 �닔 �엳�뒗
						//ResultSet媛앹껜瑜� ���옣�븷 蹂��닔 
	
	
	//DataSource而ㅻ꽖�뀡���쓣 �뼸怨�
	//而ㅻ꽖�뀡�� �궡遺��뿉 �엳�뒗 Connection媛앹껜瑜� �뼸�뒗 硫붿냼�뱶
	private Connection getConnection() throws Exception{
		
		//�넱罹ｌ씠 媛� �봽濡쒖젥�듃�뿉 �젒洹쇳븷�닔 �엳�뒗 Context媛앹껜�쓽 寃쎈줈瑜� �븣怨� �엳�뒗 媛앹껜
		Context init = new InitialContext();
		
		//DataSource而ㅻ꽖�뀡�� �뼸湲� 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		//DataSource而ㅻ꽖�뀡�� �궡遺��뿉 �엳�뒗 Connection媛앹껜 �뼸湲�
		con = ds.getConnection();
		
		return con;//DB�� 誘몃━ �뿰寃곗쓣 留븐뼱 �넃�� �젒�냽�쓣 �굹���궡�뒗 Connection媛앹껜 諛섑솚
	}//getConnection硫붿냼�뱶 �걹
	
	public void ResourceFree(){
		try{
			if(pstmt != null){ pstmt.close();}
			if(rs != null){rs.close();}
			if(con != null){con.close();}
		}catch(Exception e){
			System.out.println("ResourceFree �떎�뙣 : " + e);	
		}
	}
	
	
	
	/*joinPro.jsp�뿉�꽌 �샇異쒗븯�뒗 硫붿냼�뱶濡�   �엯�젰�븳 �쉶�썝�젙蹂대�� DB�뿉 異붽��븯�뒗 硫붿냼�뱶*/
	public void insertMember(MemberBean memberBean){
		
		String sql = "";
		
		try {
			//1.而ㅻ꽖�뀡���뿉�꽌 而ㅻ꽖�뀡�뼸湲�(DB�뿰寃�)
			con = getConnection();
			
			//2.insert臾몄옣 留뚮뱾湲�
			sql = "insert into member(id,passwd,name,reg_date,email,address,tel,mtel)"
				+ "values(?,?,?,now(),?,?,?,?)";
			
			//3.PreparedStatement insert臾� �떎�뻾 媛앹껜 �뼸湲�
			pstmt = con.prepareStatement(sql);
			//3-1. ? 湲고샇�뿉 ���쓳 �릺�뒗 媛믪쓣 �슦由ш� �엯�젰�븳 媛��엯�븷 �궡�슜�쑝濡� �꽕�젙 
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getEmail());
			pstmt.setString(5, memberBean.getAddress());
			pstmt.setString(6, memberBean.getTel());
			pstmt.setString(7, memberBean.getMtel());
			//4.insert臾몄옣�쓣 DB�뿉 �쟾�넚 �븯�뿬 �떎�뻾
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertMember硫붿냼�뱶 �궡遺� �삤瑜� : " + e);
		} finally{
			//5.ResourceFree
			ResourceFree();	
		}
	}//insertMember硫붿냼�뱶 �떕�뒗 湲고샇 
	
	
	//�쉶�썝媛��엯�쓣 �쐞�빐 �궗�슜�옄媛� �엯�젰�븳 id瑜� 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆븘..
	//DB�뿉 ���옣�맂 id�� 鍮꾧탳 �븯�뿬  以묐났, 以묐났�씠�깘瑜� �뙋�떒 �빐�꽌 諛섑솚�빐二쇰뒗 硫붿냼�뱶
	public int idCheck(String id){		
		String sql = "";		
		//�븘�씠�뵒 以묐났�씠�깘, 以묐났�씠 �븘�땲�깘 �쓽 �뙋�떒 �뜲�씠�꽣瑜� ���옣�븷 蹂��닔 �꽑�뼵
		int check = 0;
		
		try {
			//DataSource�뿉�꽌 Connection�뼸湲� (DB�뿰寃�)
			con = getConnection();
			//留ㅺ컻蹂��닔濡� �쟾�떖諛쏆� �엯�젰�븳 �븘�씠�뵒�뿉 �빐�떦�릺�뒗 �쉶�썝 寃��깋 SELECT臾몄옣 留뚮뱾湲� 
			sql = "select * from member where id=?";
			//SELECT臾몄옣�쓣 �떎�뻾�븷 PreparedStatement�떎�뻾 媛앹껜 �뼸湲�
			pstmt = con.prepareStatement(sql);
			//? �꽕�젙
			pstmt.setString(1, id);
			//DB�뿉 SELECT�쟾�넚�븯�뿬 �떎�뻾�썑 寃��깋�맂 �쉶�썝 �븳�궗�엺�쓽 �젙蹂대�� ResultSet媛앹껜�뿉 �떞�븘 諛섑솚諛쏆뒿�땲�떎.
			rs = pstmt.executeQuery();
			
			if(rs.next()){//�엯�젰�븳 �븘�씠�뵒�뿉 �빐�떦�릺�뒗 �쉶�썝 �븳以꾩씠 議고쉶�릺硫�?
						  //(�엯�젰�븳 �븘�씠�뵒媛� DB�뿉 ���옣�릺�뼱 �엳�떎硫�?)
				check = 1; //�븘�씠�뵒 以묐났
			}else{//�엯�젰�븳 �븘�씠�뵒媛� DB�뿉 議댁옱 �븯吏� �븡�쑝硫�? 議고쉶媛� �릺吏� �븡�쑝硫�?
				check = 0; //�븘�씠�뵒 以묐났 �븘�떂 
			}	
		} catch (Exception e) {
			System.out.println("idCheck硫붿냼�뱶�궡遺��뿉�꽌 �삤瑜� : " + e.toString());
		} finally{
			ResourceFree();
		}
		return check;//join_IDCheck.jsp濡� 由ы꽩(諛섑솚) , check蹂��닔媛� 1�삉�뒗 0�쓣 諛섑솚 
	}//idCheck硫붿냼�뱶 �떕�뒗 湲고샇 
	
	
	//loginPro.jsp�뿉�꽌 �샇異쒗븯�뒗 硫붿냼�뱶濡� 
	//�궗�슜�옄濡� 遺��꽣 �엯�젰諛쏆� ID,PWD瑜� 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆븘..
	//DB�뿉 議댁옱�븯�뒗 ID,PWD媛� 媛숈쑝硫� 濡쒓렇�씤 泥섎━ �븯�뒗 硫붿냼�뱶
	public int userCheck(String id, String passwd){
		
		int check = -1;  //  1 -> �븘�씠�뵒, 鍮꾨�踰덊샇 留욎쓬 
						 //  0 -> �븘�씠�뵒 留욎쓬, 鍮꾨�踰덊샇 ��由�
						 //  -1 -> �븘�씠�뵒 ��由�
		try {
			//�쐞�뿉 留뚮뱾�뼱 �넃�� getConnection硫붿냼�뱶瑜� �샇異쒗빐
			//Connection媛앹껜 �뼸湲� (DB�젒�냽)
			con = getConnection();
			//留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆� �엯�젰�븳 id�뿉 �빐�떦�릺�뒗 �쉶�썝 寃��깋 SQL臾�
			String sql = "select * from member where id=?";
			//PreparedStatement�떎�뻾媛앹껜 �뼸湲� 
			pstmt = con.prepareStatement(sql);
			//?�꽕�젙
			pstmt.setString(1, id);
			//�엯�젰�븳 id�뿉 �빐�떦�릺�뒗 �쉶�썝 寃��깋�썑 �뼸湲� 
			rs = pstmt.executeQuery();
			
			if(rs.next()){//�엯�젰�븳 id媛� DB�뿉 議댁옱 �븯硫�(�븘�씠�뵒 媛숈쑝硫�)
				
				if(passwd.equals(rs.getString("passwd")) ){//鍮꾨�踰덊샇 媛숈쑝硫�
					
					check = 1; //�엯�젰�븳 �븘�씠�뵒 鍮꾨�踰덊샇媛� DB�뿉 ���옣�맂 媛믨낵 �룞�씪 �븯�떎�뒗 �쑜�엫
				
				}else{//�븘�씠�뵒�뒗 媛숈쑝�굹 鍮꾨�踰덊샇媛� �떎瑜대㈃
					check = 0; //�븘�씠�뵒 留욎쓬 , 鍮꾨�踰덊샇 ��由� 
				}			
			}else{//�엯�젰�븳 id媛� DB�뿉 議댁옱 �븯吏� �븡�쑝硫�
				check = -1; //�븘�씠�뵒 �뾾�쓬 
			}	
		} catch (Exception e) {
			System.out.println("userCheck硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜�:"+ e);
 		} finally {
			ResourceFree();
		}
		return check;//loginPro.jsp�럹�씠吏�濡� 諛섑솚
	}
	
	
	
}//MemberDAO�겢�옒�뒪 �걹





