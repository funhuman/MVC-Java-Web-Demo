package service;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bean.UserInfo;
import dao.UserDao;
import util.C3P0Utils;
/**
 * userinfo��Ĳ����� 
 * update: 2021-01-15
 */
public class UserService implements UserDao {
	QueryRunner qr = new QueryRunner(C3P0Utils. getDataSource());
	
	// ��
	@Override
	public UserInfo selectUser(String username, String password) {
		String sql = "select userid as id, staffrole as role, checkstatus from userinfo u, checkinfo c where isdeleted=0 and u.userid=c.staffid and username=? and password=?;";
		UserInfo user = new UserInfo();
		try {
			user = qr.query(sql, new BeanHandler<>(UserInfo.class), username, password);
			// System.out.println("UserService(25): " + user == null? "null":("!null" + user.getUsername()) + " ����ȡ"); // �������)
	        // if (user != null) {
		    //     user.setUsername(username);
		    //     user.setPassword(password);
			// }
		} catch (SQLException e) {
			e.printStackTrace();
			//System.err.println("\n\n����: ���ݿ����ӳ�ʱ (UserService.java:32)\n\n"); // �������
			// return null;
		}
		// System.out.println("UserService(33): " + user == null? "null":("!null" + user.getUsername()) + " ����ȡ"); // �������)
		// System.out.println("StaffServlet(): " + user.getCheckstatus()); // �������
		return user;
	}
	
	@Override
	// true �鵽 false: �鲻��
    public boolean selectUserByName(String username) {
        String sql = "select userid from userinfo where username=?";
        UserInfo user = new UserInfo();
        try {
            //System.out.println("UserService(49): selectUserByName ������"); // �������)
            user = qr.query(sql, new BeanHandler<>(UserInfo.class), username);
            return (user.getId() == null || "".equals(user.getId())); // !(�ǿ�==�鵽)
        } catch (Exception e) {
            return false;
        }
    }
    
	@Override
	public int saveUserById(UserInfo u) {
        String sql = "update userinfo set username=?, password=?, staffrole=? where isdeleted=0 and userid=?;";
        int i = 0;
        try {
            i = qr.execute(sql, u.getUsername(), u.getPassword(), u.getRole(), u.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
	
	@Override
	public int changePassword(int id, String newpassword) {
	    String sql = "update userinfo set password=? where userid=?;";
        int i = 0;
        try {
            i = qr.execute(sql, newpassword, id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
	}
}
