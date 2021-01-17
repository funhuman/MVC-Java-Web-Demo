package controller;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.StaffInfo;
import bean.UserInfo;
import service.StaffService;
import service.UserService;

import javax.servlet.annotation.WebServlet;
/**
 * staffinfo表控制类
 * @author YOUNG
 * update: 2021-01-15
 */
@WebServlet("*.st")
public class StaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 服务器到客户端的编码处理
//        response.setContentType("text/html;charset=utf-8");
//        request.setCharacterEncoding("UTF-8");
        // 获取请求的URI地址信息
        // http://localhost:8080/hssx/getuserinfo.user
        String url = request.getRequestURI();
        // 截取其中的方法名typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        //System.out.println("StaffServlet(40): " + methodName + " 被调用"); // 调试语句
        // 权限控制
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
//        System.out.println("StaffServlet(43): " + (user == null));
//        System.out.println("StaffServlet(44): " + !methodName.equals("insertStaff"));
        //System.out.println("StaffServlet(45): " + (boolean)((user == null || user.getId() == null || "".equals(user.getId())) && !(methodName.equals("insertStaff"))));
        if ((user == null || user.getId() == null || "".equals(user.getId())) && !methodName.equals("insertStaff") ) { // 未登录的跳转
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        } 
        try {
            if (!(user.getId() == null || "".equals(user.getId()))) {
                //System.out.println("StaffServlet(52): " + " 用户 " + user.getId() +" 不为空"); // 调试语句)
                if (!user.getRole().equals("经理")) { return; }
            }
        } catch (Exception e) {
            //System.out.println("StaffServlet(56): 用户为空，跳过经理权限验证");
        }
        //System.out.println("StaffServlet(53): 进入反射函数");
        Method method = null;
        try {
            // 使用反射机制获取在本类中声明了的方法
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // 执行方法
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("试图调用 " + methodName + " 方法出错！");
        }
    }
  
    // 查询页面跳转
    public void findStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = request.getParameter("mode");
        String selectName = request.getParameter("selectName");
        String selectPhone = request.getParameter("selectPhone");
//        System.out.println("StaffServlet(68): 试图查询" + selectName + " " + selectPhone); // 调试语句
//        if (selectName!=null) { selectName = new String(selectName.getBytes("iso-88859-1"), "utf-8"); }
//        if (selectPhone!=null) { selectPhone = new String(selectPhone.getBytes("iso-88859-1"), "utf-8"); }
        //System.out.println("StaffServlet(71): 试图查询" + selectName + " " + selectPhone); // 调试语句
        StaffService stService = new StaffService();
        //System.out.println("StaffServlet(73): 查询模式" + (!"".equals(mode) && mode != null)); // 调试语句
        List<StaffInfo> stList = stService.selectStaff(((!"".equals(mode) && mode != null) ? "like" : "nolike"), selectName, selectPhone);
        request.setAttribute("list", (stList==null?null:stList));
        request.setAttribute("selectName", selectName);
        request.setAttribute("selectPhone", selectPhone);
        request.getRequestDispatcher("/WEB-INF/page/staff-info.jsp").forward(request, response);
    }
    
    // 添加页面跳转
    public void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
    }
    // 添加
    public void insertStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //System.out.println("StaffServlet(91): " + "insertStaff 运行"); // 调试语句)
        // 获取到前端的信息
        String username = request.getParameter("username");
        UserService userService = new UserService();
        if (userService.selectUserByName(username)) { 
            //System.out.println("StaffServlet(96): " + "return \"re\";"); // 调试语句
            response.getWriter().write("re");
            return;
        }
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        // 存为StaffInfo类型
        StaffInfo st =new StaffInfo();
        st.setUsername(username);
        st.setPassword(password);
        st.setName(name);
        st.setPhone(phone);
        st.setAge(Integer.parseInt(age));
        st.setSex(sex);
        StaffService stService = new StaffService();
        int i = stService.insertStaffBySt(st);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    // 删除
    public void delStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        StaffService stService = new StaffService();
        int i = stService.deleteStaffById(Integer.parseInt(id));
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    
    // 修改页面跳转
    public void modStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        // System.out.println("StaffServlet(105): " + id + " 被调用"); // 调试语句
        // 通过ID查询到数据，发给修改页面
        StaffService stService = new StaffService();
        StaffInfo staffInfo = stService.selectStaffById(Integer.parseInt(id));
        // System.out.println("StaffServlet(109): " + staffInfo.getUsername()+" "+ staffInfo.getName()+ " 获取"); // 调试语句
        request.setAttribute("staffInfo", staffInfo);
        request.getRequestDispatcher("/WEB-INF/page/staff-mod.jsp").forward(request, response);
    }
    
    // 修改功能
    public void updateStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取到前端的信息
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String oldusername = request.getParameter("oldusername");
//        System.out.println("StaffServlet(119): " + username + " " + oldusername); // 调试语句
//        System.out.println("StaffServlet(119): " + new UserService().selectUserByName(username)); // 调试语句
//        System.out.println("StaffServlet(119): " + !username.equals(oldusername)); // 调试语句
        if (new UserService().selectUserByName(username) && !username.equals(oldusername)) { 
            //System.out.println("StaffServlet(120): " + "return \"no\";"); // 调试语句
            response.getWriter().write("re");
            return;
        }
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        String role = request.getParameter("role");
        // 存为StaffInfo类型
        StaffInfo st =new StaffInfo();
        st.setId(Integer.parseInt(id));
        st.setUsername(username);
        st.setName(name);
        st.setPhone(phone);
        st.setAge(Integer.parseInt(age));
        st.setSex(sex);
        st.setRole(role);
        StaffService stService = new StaffService();
        int i = stService.updateStaffBySt(st);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
}