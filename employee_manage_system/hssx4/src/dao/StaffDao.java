package dao;

import java.util.List;

import bean.StaffInfo;
/**
 * staffinfo �����ӿ�
 * @author Funhuman
 * update: 2021-01-15
 */
public interface StaffDao {
    // ��
    public StaffInfo selectStaffById(int id);
    public List<StaffInfo> selectStaff(String mode, String selectName, String selectClassName);
    // ��
    public int insertStaffBySt(StaffInfo st);
    // ɾ
    public int deleteStaffById(int id);
    // ��
    public int updateStaffBySt(StaffInfo st);
}
