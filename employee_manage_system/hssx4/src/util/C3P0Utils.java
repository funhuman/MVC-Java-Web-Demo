package util;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * c3p0连接池工具类
 * @author Administrator
 *
 */
public class C3P0Utils {

	private static ComboPooledDataSource dataSource;
	static {
		// 根据配置文件信息生成数据源
		dataSource = new ComboPooledDataSource("ems"); // 数据库名称，与c3p0-config.xml的一致
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
