package bean;
/**
 * staffinfo表对应实体类
 * @author SXH
 * update: 2021-01-15
 */
public class CheckInfo {
    private Integer staffid;
    private String checkstatus;
    public Integer getStaffid() {
        return staffid;
    }
    public void setStaffid(Integer staffid) {
        this.staffid = staffid;
    }
    public String getCheckstatus() {
        return checkstatus;
    }
    public void setCheckstatus(String checkstatus) {
        this.checkstatus = checkstatus;
    }
}
