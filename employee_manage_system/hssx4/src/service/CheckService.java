package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import bean.CheckInfo;
import dao.CheckDao;
import util.C3P0Utils;

public class CheckService implements CheckDao{
    QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
    
    @Override
    public List<CheckInfo> findStatus() {
        String sql = "select * from checkinfo";
         List<CheckInfo> userStatusList=new ArrayList<CheckInfo>();
         try{
             userStatusList=qr.query(sql, new BeanListHandler<>(CheckInfo.class));
         }
         catch(SQLException e)
         {
             e.printStackTrace();
         }
         return userStatusList;
    }
    @Override
    public CheckInfo findUserStatusById(int id) {
        String sql = "select * from checkinfo where staffid =?";
        CheckInfo us =new CheckInfo();
         try {
                us=qr.query(sql, new BeanHandler<>(CheckInfo.class),id);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            return us;
    }
    @Override
    public int updateUserStatusById(CheckInfo us) {
        String sql ="update checkinfo set checkstatus=? where staffid=?";
         int i = 0;
            try {
                i = qr.execute(sql, us.getCheckstatus(),us.getStaffid());
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return i;
    }
    @Override
    public int outUserStatus(String checkStatus) {
        String sql = "update checkinfo set checkstatus=?";
        int i = 0;
        try {
            i = qr.execute(sql,checkStatus);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    public int offUserStatus(String checkStatus1,String checkStatus2) {
        String sql = "update checkinfo set checkstatus=? where checkstatus <>?";
        int i = 0;
        try {
            i = qr.execute(sql,checkStatus1,checkStatus2);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
}
