package bean;

/**
 * userinfo表对应的实体类
 * @author YOUNG
 * @update 2021-01-15
 */
public class UserInfo {
	// 数据
	private Integer id;
	private String username;
	private String password;
	private String role;
	private String checkstatus;
	
    // get/set 方法
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getCheckstatus() {
        return checkstatus;
    }
    public void setCheckstatus(String checkstatus) {
        this.checkstatus = checkstatus;
    }
}
