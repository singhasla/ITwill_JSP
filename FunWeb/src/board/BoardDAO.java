package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//�옄諛붾퉰 �겢�옒�뒪�쓽 醫낅쪟以� DAO�뿭�븷�쓣 �븯�뒗 �겢�옒�뒪
//DB�뿰寃� �썑 �옉�뾽�븯�뒗 �겢�옒�뒪 (鍮꾩쫰�땲�뒪濡쒖쭅�쓣 泥섎━�븯�뒗 �겢�옒�뒪)
public class BoardDAO {
	
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
	
	//DB�뿉 �깉湲� 異붽� 硫붿냼�뱶
	public void insertBoard(BoardBean bBean){
		
		//DB�뿉 異붽��븷 湲�踰덊샇瑜� ���옣�븷 蹂��닔 
		int num = 0;
		
		//SQL臾� ���옣�븷 蹂��닔�꽑�뼵
		String sql = "";
		
		try {
			//而ㅻ꽖�뀡���뿉�꽌 而ㅻ꽖�뀡媛앹껜 �뼸湲�(DB�뿰寃�)
			con = getConnection();
			
			//DB�뿉 ���옣�맂 湲��쓽 媛��옣 理쒖떊 湲�踰덊샇 寃��깋�빐 �삤�뒗 SELECT臾�
			sql = "select max(num) from board";
			//李멸퀬 : DB�뿉 湲��씠 ���옣�릺�뼱 �엳吏� �븡�뒗寃쎌슦  �깉濡쒖텛媛��븷 湲�踰덊샇 �뒗? 1
			//      DB�뿉 湲��씠 ���옣�릺�뼱 �엳�뒗 寃쎌슦  寃��깋�븳 媛��옣 理쒖떊湲�踰덊샇 + 1 �뜲�씠�꽣瑜� �깉濡쒖텛媛��븷 湲�踰덊샇濡� 吏��젙
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){//媛��옣 理쒖떊 湲�踰덊샇媛� 寃��깋�맂�떎硫�?
				//媛��옣理쒖떊 湲�踰덊샇  + 1 �뜲�씠�꽣瑜� �깉濡� 異붽��븷 湲�踰덊샇濡� 吏��젙
				num = rs.getInt(1) + 1;
			}else{//媛��옣 理쒖떊 湲�踰덊샇媛� 寃��깋�릺吏� �븡�쑝硫�?(DB�뿉 湲��씠 �뾾�떎硫�)
				num = 1; //�깉濡쒖텛媛��븷 湲�踰덊샇瑜� 1濡� �꽕�젙 
			}
			
			sql = "insert into board(num,name,passwd,"
				+ "subject,content,re_ref,re_lev,re_seq,readcount,date,ip)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?);";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//異붽��븷 �깉湲��쓽 湲�踰덊샇
			pstmt.setString(2, bBean.getName());//�깉湲��쓣 �옉�꽦�븳 �궗�엺�쓽 �씠由�(id)
			pstmt.setString(3, bBean.getPasswd());//異붽��븷 �깉湲��쓽 鍮꾨�踰덊샇
			pstmt.setString(4, bBean.getSubject());//異붽��븷 �깉湲��쓽 �젣紐�
			pstmt.setString(5, bBean.getContent());//湲��궡�슜
			pstmt.setInt(6, num); // �깉湲��쓽 洹몃９踰덊샇�뒗 �깉湲��쓽 湲�踰덊샇濡� �꽔�뒗�떎.
			pstmt.setInt(7, 0); //�깉湲� (二쇨�) 異붽��떆 �뱾�뿬�벐湲� �젙�룄媛믪� 0�쑝濡� �꽔�뒗�떎.
			pstmt.setInt(8, 0); //二쇨��쓽 �닚�꽌媛� 
			pstmt.setInt(9, 0); //異붽��븯�뒗 �깉湲��쓽 議고쉶�닔 0
			pstmt.setTimestamp(10, bBean.getDate()); //�깉湲��쓣 異붽��븳 �궇吏� �젙蹂� 
			pstmt.setString(11, bBean.getIp());//�깉湲��쓣 �옉�꽦�븳 �궗�엺�쓽  IP二쇱냼 �젙蹂� 
			
			//insert臾몄옣 �떎�뻾
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBoard硫붿냼�뱶 �궡遺��뿉�꽌 �떎�뻾 �삤瑜� : " + e);
		} finally {
			ResourceFree();
		}	
	}//insertBoard硫붿냼�뱶 �걹
	
	
	//DB�뿉 ���옣�맂 �쟾泥� 湲� 媛쒖닔瑜� 寃��깋�빐�꽌 諛섑솚 �빐二쇰뒗 硫붿냼�뱶 
	public int getBoardCount(){
		
		int count = 0; //寃��깋�븳 湲�媛쒖닔瑜� ���옣�븷 蹂��닔 
		
		String sql = "";
		
		try {
			//DB�뿰寃�
			con = getConnection();
			
			//�쟾泥� 湲��닔 議고쉶 SELECT臾몄옣 留뚮뱾湲�
			sql = "select count(*) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount�뿉�꽌 �삤瑜�:" + e);
		}finally {
			ResourceFree();
		}
		return count;//議고쉶�븳 湲� 媛쒖닔 由ы꽩 
		
	}//getBoardCount()硫붿냼�뱶 �걹
	
	//notice.jsp�럹�씠吏��뿉�꽌 �샇異쒗븯�뒗 硫붿냼�뱶濡�
	//媛곹럹�씠吏�留덈떎 泥ル쾲吏몃줈 蹂댁뿬吏� �떆�옉湲�踰덊샇��  �븳�럹�씠吏��떦 蹂댁뿬吏� 湲� 媛쒖닔瑜� 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆븘
	//�븳�럹�씠吏��떦 蹂댁뿬吏� 湲�媛쒖닔留뚰겮 寃��깋�빐�꽌 媛��졇�삤�뒗 硫붿냼�뱶 
	public List<BoardBean>  getBoardList(int startRow,  int pageSize){
		
		String sql = "";
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection(); //DB�뿰寃�
			//SELECT臾몄옣 留뚮뱾湲�
			//�젙�젹 re_ref �궡由쇱감�닚�젙�젹 �썑 re_seq �삤由꾩감�닚�젙�젹 �븯�뒗�뜲..
			//limt 媛곹럹�씠吏�留덈떎 泥ル쾲吏몃줈 蹂댁뿬吏� �떆�옉湲�踰덊샇, �븳�럹�씠吏��떦 蹂댁뿬以� 湲�媛쒖닔 
			sql = "select  * from board order by re_ref desc, re_seq asc limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				//BoardBean媛앹껜 => Arraylist諛곗뿴�뿉 異붽�
				boardList.add(bBean);
			}
			
		} catch (Exception e) {
			System.out.println("getBoardList硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		} finally{
			ResourceFree();
		}
		return boardList;//ArrayList由ы꽩
	
	}//getBoardList硫붿냼�뱶 �걹
	
	//�븯�굹�쓽 湲��쓣 �겢由��뻽�쓣�븣  湲�踰덊샇瑜� 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆븘.
	//湲�踰덊샇�뿉 �빐�떦�릺�뒗 湲� 議고쉶�닔 �젙蹂대�� 1 利앷� (�뾽�뜲�씠�듃) �떆�궎�뒗 硫붿냼�뱶
	public void updateReadCount(int num){
		String sql = "";
		try {
			//DB�뿰寃�
			con = getConnection();
			//UPDATE援щЦ 留뚮뱾湲�-> 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏅뒗 湲�踰덊샇�뿉 �빐�떦�릺�뒗 湲��쓽 議고쉶�닔�젙蹂대�� 1利앷�(�뾽�뜲�씠�듃)
			sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount硫붿냼�뱶�뿉�꽌 �삤瑜� : " + e);
		} finally{
			ResourceFree();
		}
	}//updateReadCount硫붿냼�뱶 �걹
	
	
	//湲�踰덊샇瑜� 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏆븘 湲�踰덊샇�뿉 �빐�떦�릺�뒗 湲��쓽 �젙蹂대�� 寃��깋 �븯�뒗 硫붿냼�뱶
	public BoardBean getBoard(int num){
		
		String sql = "";
		
		BoardBean bBean = new BoardBean();
		
		try {
			//DB�뿰寃�
			con = getConnection();
			//SELECT臾몄옣 留뚮뱾湲� - 留ㅺ컻蹂��닔濡� �쟾�떖 諛쏅뒗 湲�踰덊샇�뿉 �빐�떦�릺�뒗 湲��젙蹂닿��깋
			sql = "select  * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
			}
		} catch (Exception e) {
			System.out.println("getBoard硫붿냼�뱶�뿉�꽌 �삤瑜� :" + e);
		} finally {
			ResourceFree();
		}	
		return bBean;
	}//getBoard硫붿냼�뱶 �걹
		
	
	//�궘�젣�븷 湲�踰덊샇�� 湲��쓣 �궘�젣�븯湲� �쐞�빐 �엯�젰�뻽�뜕 鍮꾨�踰덊샇瑜� 留ㅺ컻蹂��닔濡� �쟾�떖諛쏆븘..
	//�궘�젣�븷 湲�踰덊샇�뿉 �빐�떦�릺�뒗 鍮꾨�踰덊샇瑜� 寃��깋�븯�뿬
	//寃��깋�븳 鍮꾨�踰덊샇�� �엯�젰�뻽�뜕 鍮꾨�踰덊샇媛� �룞�씪�븯硫� 湲��쓣 DELETE�빀�땲�떎.
	//DELETE�뿉 �꽦怨듯븯硫�  check = 1 濡� ���옣�븯�뿬 諛섑솚 �븯怨� 
	//DELETE�뿉 �떎�뙣�븯硫�  check = 0 濡� ���옣�븯�뿬  deletePro.jsp濡� 諛섑솚�븿.
	public int deleteBoard(int num, String passwd){
		int check = 0;
		String sql = "";
		try {
			//DB�뿰寃�
			con = getConnection();
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){//�빐�떦�궘�젣�븷 湲�踰덊샇�뿉 ���븳 湲��쓽 鍮꾨�踰덊샇媛� 寃��깋�릺硫�
				//�엯�젰�븳 鍮꾨�踰덊샇�� 寃��깋�븳 湲��쓽 鍮꾨�踰덊샇媛� �룞�씪 �븯硫�?
				if(passwd.equals(rs.getString("passwd"))){
					//check = 1;
					check = 1;
					//delete臾몄옣 �옉�꽦
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}else{//�엯�젰�븳 鍮꾨�踰덊샇�� 寃��깋�븳 湲��쓽 鍮꾨�踰덊샇媛� �떎瑜대㈃?
					check = 0;
				}
			}		
		} catch (Exception e) {
			System.out.println("deleteBoard硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		} finally{
			ResourceFree();
		}		
		return check;//deletePro.jsp濡� 鍮꾨�踰덊샇 �씪移� �쑀臾� 1 �삉�뒗 0�쓣 諛섑솚
	}//deleteBoard硫붿냼�뱶 �걹
	
	
	//�닔�젙�쓣 �쐞�빐 �엯�젰�븳 湲��젙蹂닿� ���옣�맂 BoardBean媛앹껜瑜� 留ㅺ컻蹂��닔濡� �쟾�떖諛쏆븘
	//UPDATE臾몄옣 �셿�꽦�썑 DB�� �뿰寃고븯�뿬 UPDATE援щЦ �떎�뻾�븷 硫붿냼�뱶
	//議곌굔 : DB�뿉 ���옣�맂 湲��쓽 鍮꾨�踰덊샇�� 湲��쓣 �닔�젙�븯湲� �쐞�빐 �엯�젰�븳 鍮꾨�踰덊샇媛� �씪移섑븷 �븣留� UPDATE�븿
	public int updateBoard(BoardBean bBean){
		
		int check = 0;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "SELECT passwd FROM board WHERE num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bBean.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				//湲��닔�젙�쓣 �쐞�빐 �엯�젰�븳 鍮꾨�踰덊샇�� 寃��깋�븳 湲��쓽 鍮꾨�踰덊샇瑜� 鍮꾧탳�빐 �룞�씪�븯硫�
				if( bBean.getPasswd().equals(rs.getString("passwd")) ){
					check = 1;
					sql = "UPDATE board SET name=?, subject=?, content=? WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					pstmt.executeUpdate();
				} else {	//湲��닔�젙�쓣 �쐞�빐 �엯�젰�븳 鍮꾨�踰덊샇媛� ��由щ㈃
					check = 0;
				}
			}
			
		} catch (Exception e) {
			System.out.println("updateBoard硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		} finally {
			ResourceFree();
		}
		
		return check;	//updatePro.jsp濡� check蹂��닔媛� 諛섑솚
		
	}//updateBoard硫붿냼�뱶 �걹
	
	
	
	/* 
	 * �떟蹂� �떖湲� 洹쒖튃 
	 * 
	 *	1. �떟湲� 洹몃９踰덊샇(re_ref)�뒗 二쇨��쓽 洹몃９踰덊샇(re_ref)瑜� �궗�슜�븳�떎.
	 * 	2. 媛숈� 洹몃９�쓽 湲��뱾 �궡�쓽 �닚�꽌媛�(re_seq)�� 二쇨��쓽 re_seq�뿉�꽌 +1利앷��븳 媛믪쓣 �꽔�뼱以��떎.
	 * 	3. �떟湲��쓽 �뱾�뿬�벐湲� �젙�룄媛�(re_lev)�� 二쇨��쓽 re_lev媛믪뿉 +1 利앷��븳 媛믪쓣 �꽔�뼱�꽌 �궗�슜�븳�떎.
	 *  
	 *  �떟蹂�湲��쓣 DB�뿉 INSERT�븯�뒗 硫붿냼�뱶 留뚮뱾湲�
	 */
	public void reInsertBoard(BoardBean bBean){	//reWritePro.jsp�뿉�꽌 �샇異쒗븯�뒗 硫붿냼�뱶濡�
												//bBean媛앹껜 �궡�뿉�뒗 �떟湲��젙蹂댁� 二쇨��젙蹂닿� �떞寃⑥엳�떎.
		String sql = "";
		//�떟湲��쓽 湲�踰덊샇瑜� 留뚮뱾�뼱�꽌 ���옣�븷 蹂��닔
		int num = 0;
		
		try {
			
			con = getConnection();
			
			//�떟湲��쓽 湲�踰덊샇瑜� 援ы븯湲� �쐞�빐 DB�뿉 ���옣�맂 媛��옣 理쒖떊湲� 踰덊샇 �뼸湲�
			sql = "SELECT max(num) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	//理쒖떊湲�踰덊샇媛� 寃��깋�맂�떎硫�
				num = rs.getInt(1) + 1;
			} else {	//DB�뿉 湲��씠 �뾾�떎硫�
				num = 1;
			}
			
			//re_seq �떟湲��뱾 �궡�쓽 �닚�꽌�옱諛곗튂
			//二쇨��쓽 洹몃９怨� 媛숈� 洹몃９�씠硫댁꽌 二쇨��쓽 seq媛믩낫�떎 �겙 �떟蹂�湲��뱾��? seq媛믪쓣 1 利앷��떆�궓�떎.(re_seq = re_seq+1)
			sql = "UPDATE board SET re_seq = re_seq+1 WHERE re_ref = ? AND re_seq > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref());
			pstmt.setInt(2, bBean.getRe_seq());
			pstmt.executeUpdate();
			
			/* �떟蹂� �떖湲� */
			//insert
			sql = "INSERT INTO board VALUES(?,?,?, ?,?,?, ?,?,?, ?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);	//異붽��븷 �떟蹂�湲��쓽 湲�踰덊샇
			pstmt.setString(2, bBean.getName());	//�떟蹂�湲��쓣 �옉�꽦�븯�뒗 �궗�엺�쓽 �씠由�
			pstmt.setString(3, bBean.getPasswd());	//�떟蹂�湲��쓽 鍮꾨�踰덊샇
			pstmt.setString(4, bBean.getSubject());	//�떟蹂�湲��쓽 �젣紐�
			pstmt.setString(5, bBean.getContent());	//�떟蹂�湲��쓽 �궡�슜
			pstmt.setInt(6, bBean.getRe_ref());		//�떟蹂�湲��쓽 洹몃９踰덊샇
			pstmt.setInt(7, bBean.getRe_lev()+1);	//�떟蹂�湲��쓽 �뱾�뿬�벐湲곗젙�룄媛믪� 二쇨��쓽 �뱾�뿬�벐湲곗젙�룄媛믪뿉 +1 �븳媛믪쓣 �궗�슜
			pstmt.setInt(8, bBean.getRe_seq()+1);	//�떟蹂�湲��쓽 �닚�꽌
			pstmt.setInt(9, 0);						//�떟蹂�湲��쓽 議고쉶�닔
			pstmt.setTimestamp(10, bBean.getDate());//�떟蹂�湲��쓽 �옉�꽦�궇吏� 諛� �떆媛꾩젙蹂�
			pstmt.setString(11, bBean.getIp());		//�떟蹂�湲��쓣 �옉�꽦�븳 �겢�씪�씠�뼵�듃�쓽 IP二쇱냼
			
			pstmt.executeUpdate();	//�떟蹂�湲��쓣 DB�뿉 INSERT
			
		} catch (Exception e) {
			System.out.println("reInsertBoard硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		} finally {
			ResourceFree();
		}
	}//reInsertBoard硫붿냼�뱶 �걹
	
}//BoardDAO�겢�옒�뒪 �걹













