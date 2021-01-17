package dao;
import java.util.List;
import bean.CheckInfo;
/**
 * checkinfo 表操作接口
 * @author SXH
 * update: 2021-01-15
 */
public interface CheckDao {
    public List<CheckInfo> findStatus();
    public CheckInfo findUserStatusById(int id);
    public int updateUserStatusById(CheckInfo us);
    public int outUserStatus(String checkStatus);
    public int offUserStatus(String checkStatus1, String checkStatus2);
}
