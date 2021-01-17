package service;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;

import dao.SignDao;
import util.C3P0Utils;

public class SignService implements SignDao {
    QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
    
    @Override
    public int signinById(int id) {
        String sql = "update checkinfo set checkstatus='ÒÑÇ©µ½' where staffid=?";
        int i = 0;
        try {
            i = qr.execute(sql, id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
}
