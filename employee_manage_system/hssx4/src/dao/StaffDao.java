package dao;

import java.util.List;

import bean.StaffInfo;
/**
 * staffinfo 操作接口
 * @author Funhuman
 * update: 2021-01-15
 */
public interface StaffDao {
    // 查
    public StaffInfo selectStaffById(int id);
    public List<StaffInfo> selectStaff(String mode, String selectName, String selectClassName);
    // 增
    public int insertStaffBySt(StaffInfo st);
    // 删
    public int deleteStaffById(int id);
    // 改
    public int updateStaffBySt(StaffInfo st);
}
