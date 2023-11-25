package bbs;

import java.sql.Connection;    
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class BbsDAO {

	public String getData() {
		String SQL = "select now()";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs= pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return ""; //데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "select bbsIndex from bbs order by bbsIndex desc";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs= pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -1; //데이터베이스 오류
	}
	
	public int write( String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into bbs values (?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getData());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6,1);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<BbsDTO> getList(int pageNumber) {
		String SQL = "select * from bbs where bbsIndex < ? and bbsAvailable = 1 order by bbsIndex desc limit 10";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs= pstmt.executeQuery();
			while (rs.next()) {
				BbsDTO bbsDTO = new BbsDTO();
				bbsDTO.setBbsIndex(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsDate(rs.getString(4));
				bbsDTO.setBbsContent(rs.getString(5));
				bbsDTO.setBbsAvailble(rs.getInt(6));
				list.add(bbsDTO);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return list;
	}
	
	
	public	boolean nextPage(int pageNumber) {
		String SQL = "select * from bbs where bbsIndex < ? and bbsAvailable = 1 order by bbsIndex desc limit 10";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs= pstmt.executeQuery();
			if (rs.next() ) {
				return true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return false;
	}
	
	
	public BbsDTO getBbsDTO(int bbsIndex) {
		String SQL = "select * from bbs where bbsIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsIndex);
			rs= pstmt.executeQuery();
			if (rs.next() ) {
				BbsDTO bbsDTO = new BbsDTO();
				bbsDTO.setBbsIndex(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsDate(rs.getString(4));
				bbsDTO.setBbsContent(rs.getString(5));
				bbsDTO.setBbsAvailble(rs.getInt(6));
				return bbsDTO;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return null;
	
	}
	
	public int update(int bbsIndex, String bbsTitle, String bbsContent) { //글 수정
		String SQL = "update bbs set bbsTitle = ?, bbsContent = ? where bbsIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsIndex);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -1; //데이터베이스 오류
	}
	
	
	public int delete(int bbsIndex) {
		String SQL = "update bbs set bbsAvailable = 0 where bbsIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsIndex);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -1; //데이터베이스 오류
	}
	
	
	public ArrayList<BbsDTO> getUserPosts(String userID) {
	    String SQL = "SELECT * FROM bbs WHERE userID = ? AND bbsAvailable = 1 ORDER BY bbsIndex DESC";
	    ArrayList<BbsDTO> userPosts = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DatabaseUtil.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            BbsDTO bbsDTO = new BbsDTO();
	            bbsDTO.setBbsIndex(rs.getInt(1));
	            bbsDTO.setBbsTitle(rs.getString(2));
	            bbsDTO.setUserID(rs.getString(3));
	            bbsDTO.setBbsDate(rs.getString(4));
	            bbsDTO.setBbsContent(rs.getString(5));
	            bbsDTO.setBbsAvailble(rs.getInt(6));
	            userPosts.add(bbsDTO);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        try {
	            if (pstmt != null) pstmt.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        try {
	            if (rs != null) rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return userPosts;
	}
}
