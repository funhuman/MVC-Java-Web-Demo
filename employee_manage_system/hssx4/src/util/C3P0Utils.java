package util;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * c3p0���ӳع�����
 * @author Administrator
 *
 */
public class C3P0Utils {

	private static ComboPooledDataSource dataSource;
	static {
		// ���������ļ���Ϣ��������Դ
		dataSource = new ComboPooledDataSource("ems"); // ���ݿ����ƣ���c3p0-config.xml��һ��
	}
	
	public static ComboPooledDataSource getDataSource() {
		return dataSource;
	}
	
	public void closeConn(Connection conn){
        try {
            if(conn!=null && conn.isClosed()){
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
