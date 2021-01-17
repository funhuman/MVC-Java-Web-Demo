package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import bean.StaffInfo;
import dao.StaffDao;
import util.C3P0Utils;
/**
 * staffinfo 表的操作类 
 * @author YOUNG
 * update: 2021-01-15
 */
public class StaffService implements StaffDao {
    QueryRunner qr = new QueryRunner(C3P0Utils. getDataSource());
    
    @Override
    public StaffInfo selectStaffById(int id) {
        String sql = "select s.staffid as id, u.username, s.staffname as name, s.staffphone as phone, s.staffsex as sex, s.staffage as age, u.staffrole as role from staffinfo as s, userinfo as u where u.isdeleted=0 and s.staffid=u.userid and s.staffid=?;";
        StaffInfo staffInfo = new StaffInfo();
        try {
            staffInfo = qr.query(sql, new BeanHandler<>(StaffInfo.class), id);
            //System.out.println("StaffServic(28): " + staffInfo.getUsername() +" " + staffInfo.getName()+ " "); // 调试语句
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffInfo;
    }
    
    @Override
    public List<StaffInfo> selectStaff(String mode, String selectName, String selectPhone) {
        String sql = "select s.staffid as id, u.username, s.staffname as name, s.staffphone as phone, s.staffsex as sex, s.staffage as age, u.staffrole as role from staffinfo as s, userinfo as u where u.isdeleted=0 and s.staffid=u.userid ";
        if (!"".equals(selectName) && selectName!=null){
            if (mode.equals("like")) {
                sql+=" and u.username like '%"+ selectName + "%'";
                //System.out.println("StaffService(44): " + " 模糊查询"); // 调试语句)
            } else {
                sql+=" and u.username = '"+ selectName + "' ";
            }
        }
        if (!"".equals(selectPhone) && selectPhone !=null){
            if (mode.equals("like")) {
                sql+=" and s.staffphone like '%"+ selectPhone + "%'";
                //System.out.println("StaffService(44): " + " 模糊查询"); // 调试语句)
            } else {
                sql+=" and s.staffphone = '"+ selectPhone + "' ";
            }
        }
        List<StaffInfo> staffList = new ArrayList<StaffInfo>();
        try {
            staffList = qr.query(sql, new BeanListHandler<>(StaffInfo.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }
    
    @Override
    public int insertStaffBySt(StaffInfo st) {
        String sql = "insert into userinfo set username=?, password=?, staffrole='员工', isdeleted=0;";
        String sql2 = "insert into staffinfo set staffid=(select userid from userinfo where username=?), staffname=?, staffphone=?, staffsex=?, staffage=?;";
        String sql3 = "insert into checkinfo set staffid=(select userid from userinfo where username=?), checkstatus='未签到';";
        int i = 0;
        try {
            i += qr.execute(sql, st.getUsername(), st.getPassword());
            i += qr.execute(sql3, st.getUsername());
            i += qr.execute(sql2, st.getUsername(), st.getName(), st.getPhone(), st.getSex(), st.getAge());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //System.out.println("StaffService(76): i=="+i);//调试语句
        return (i == 3 ? 1 : 0);
    }
    
    @Override
    public int deleteStaffById(int id) {
        String sql = "update userinfo set isdeleted=1 where userid=?";
        int i = 0;
        try {
            i = qr.execute(sql, id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    @Override
    public int updateStaffBySt(StaffInfo st) {
        String sql = "update userinfo set username=?, staffrole=? where userid=?;";
        String sql2 = "update staffinfo set staffname=?, staffphone=?, staffsex=?, staffage=? where staffid=?;";
        int i = 0;
        try {
            i += qr.execute(sql, st.getUsername(), st.getRole(), st.getId());
            i += qr.execute(sql2, st.getName(), st.getPhone(), st.getSex(), st.getAge(), st.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i==2 ? 1 : 0;
    }
}
