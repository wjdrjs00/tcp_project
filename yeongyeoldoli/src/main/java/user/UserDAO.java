package user;

import java.sql.Connection;       
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseUtil;

public class UserDAO {
	//로그인
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 틀림
			}
			return -1; // 아이디 없음
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -2; // 데이터베이스 오류
	}
	
	//회원가입
	public int join(UserDTO user) {
		String SQL = "insert into user values (?,?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserPhoneNumber());
			pstmt.setString(5, user.getUserName());
			pstmt.setString(6, user.getUserBirthDate());
			String userType = String.join(",", user.getUserType());
			pstmt.setString(7, userType);
			
			/*
			 * pstmt.setString(7, user.getPostcode()); pstmt.setString(8,
			 * user.getRoadAddress()); pstmt.setString(9, user.getJibunAddress());
			 * pstmt.setString(10, user.getDetailAddress()); pstmt.setString(11,
			 * user.getExtraAddress());
			 */
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace(); }
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace(); }
		}
		return -1; // 회원가입 실패
	}
	
	
    public UserDTO getUserInfo(String userID) {
    	String SQL = "SELECT userName,userPassword,userEmail,userType FROM user WHERE userID = ?";
    	Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
        UserDTO user = new UserDTO(); // UserDTO 클래스는 사용자 정보를 담는 클래스입니다.

        try {
        	conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 사용자 이름을 가져와 UserDTO 객체에 설정
                String userName = rs.getString("userName");
                String userPassword = rs.getString("userPassword");
                String userEmail = rs.getString("userEmail");
                String userType = rs.getString("userType");
                user.setUserName(userName);
                user.setUserPassword(userPassword);
                user.setUserEmail(userEmail);
                user.setUserType(userType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 여기서는 리소스를 닫는 부분을 가정합니다.
            // 실제로는 적절한 예외처리와 리소스 해제를 수행해야 합니다.
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user; // 사용자 정보를 담고 있는 UserDTO 객체 반환
    }
    
    public int updateUser(UserDTO user) {
        String SQL = "UPDATE user SET userPassword = ?, userEmail = ? WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserPassword());
            pstmt.setString(2, user.getUserEmail());
            pstmt.setString(3, user.getUserID());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제 코드는 생략되어 있습니다.
        }
        return result;
    }

    
    public boolean isEmailAlreadyInUse(String userEmail) {
        String SQL = "SELECT COUNT(*) FROM user WHERE userEmail = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // 이미 해당 이메일이 존재하면 true 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제 코드는 생략
        }
        return false; // 에러 발생 시 또는 이메일이 존재하지 않는 경우 false 반환
    }

    public boolean deleteUser(String userID) {
        String SQL = "DELETE FROM user WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            
            int result = pstmt.executeUpdate();
            return result > 0; // 삭제가 성공하면 true 반환
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            // ...
        }
        
        return false; // 삭제 실패 시 false 반환
    }
    
}
