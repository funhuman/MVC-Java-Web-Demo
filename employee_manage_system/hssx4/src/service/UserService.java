package service;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import bean.UserInfo;
import dao.UserDao;
import util.C3P0Utils;
/**
 * userinfo表的操作类 
 * update: 2021-01-15
 */
public class UserService implements UserDao {
	QueryRunner qr = new QueryRunner(C3P0Utils. getDataSource());
	
	// 查
	@Override
	public UserInfo selectUser(String username, String password) {
		String sql = "select userid as id, staffrole as role, checkstatus from userinfo u, checkinfo c where isdeleted=0 and u.userid=c.staffid and username=? and password=?;";
		UserInfo user = new UserInfo();
		try {
			user = qr.query(sql, new BeanHandler<>(UserInfo.class), username, password);
			// System.out.println("UserService(25): " + user == null? "null":("!null" + user.getUsername()) + " 被获取"); // 调试语句)
	        // if (user != null) {
		    //     user.setUsername(username);
		    //     user.setPassword(password);
			// }
		} catch (SQLException e) {
			e.printStackTrace();
			//System.err.println("\n\n错误: 数据库连接超时 (UserService.java:32)\n\n"); // 调试语句
			// return null;
		}
		// System.out.println("UserService(33): " + user == null? "null":("!null" + user.getUsername()) + " 被获取"); // 调试语句)
		// System.out.println("StaffServlet(): " + user.getCheckstatus()); // 调试语句
		return user;
	}
	
	@Override
	// true 查到 false: 查不到
    public boolean selectUserByName(String username) {
        String sql = "select userid from userinfo where username=?";
        UserInfo user = new UserInfo();
        try {
            //System.out.println("UserService(49): selectUserByName 被调用"); // 调试语句)
            user = qr.query(sql, new BeanHandler<>(UserInfo.class), username);
            return (user.getId() == null || "".equals(user.getId())); // !(非空==查到)
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
