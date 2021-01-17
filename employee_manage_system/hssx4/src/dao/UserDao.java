package dao;

import bean.UserInfo;

/**
 * userinfo 操作接口
 * @author Funhuman
 * update: 2021-01-15
 */
public interface UserDao {
    // 接口没有方法体
	public UserInfo selectUser(String username, String password);
	public boolean selectUserByName(String username);
	public int saveUserById(UserInfo user);
	public int changePassword(int userid, String newpassword);
}
