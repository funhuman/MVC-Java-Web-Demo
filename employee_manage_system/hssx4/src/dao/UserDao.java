package dao;

import bean.UserInfo;

/**
 * userinfo �����ӿ�
 * @author Funhuman
 * update: 2021-01-15
 */
public interface UserDao {
    // �ӿ�û�з�����
	public UserInfo selectUser(String username, String password);
	public boolean selectUserByName(String username);
	public int saveUserById(UserInfo user);
	public int changePassword(int userid, String newpassword);
}
