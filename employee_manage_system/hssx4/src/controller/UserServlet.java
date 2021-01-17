package controller;
import java.io.IOException;
import java.lang.reflect.Method;
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
 * userinfo表控制类
 * @author YOUNG
 * update: 2021-01-15
 */
@WebServlet("*.user") // 根据结尾判断
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // response.setContentType("text/html;charset=utf-8");
        // request.setCharacterEncoding("UTF-8");
        // 获取请求的URI地址信息
        // http://localhost:8080/hssx4/getuserinfo.user
        String url = request.getRequestURI();
        // 截取其中的方法名typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        //System.out.println("UserServlet(37): " +" 被调用"); // 调试语句)
        // 权限控制
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        //System.out.println("UserServlet(40): !methodName.equals(\"quit\"): " +!methodName.equals("quit")); // 调试语句)
        //System.out.println("UserServlet(41): " + (user == null || user.getId() == null || !"".equals(user.getId()) && !methodName.equals("quit")) + " 被调用"); // 调试语句)
        if (!methodName.equals("quit") && (user == null || user.getId() == null || !"".equals(user.getId()))) { // 未登录的跳转
            //System.out.println("UserServlet(42): " + "跳转到 注册页 被调用"); // 调试语句)
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        }
        Method method = null;
        try {
            // 使用反射机制获取在本类中声明了的方法
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // 执行方法
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("调用方法出错！");
        }
	}
	
	// 跳转
    public void quit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserInfo user = new UserInfo();
        request.getSession().setAttribute("userInfo", user);
        //System.out.println("UserServlet(66): 用户退出 被调用"); // 调试语句)
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
	// 查询
    public void getuserinfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从Session中获取用户信息
        UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
        StaffService staffScervie = new StaffService();
        StaffInfo staffInfo = staffScervie.selectStaffById(userInfo.getId());
        //System.out.println("UserServlet(76): " + staffInfo.getName() + " Session 被获取"); // 调试语句
        request.setAttribute("userInfo", userInfo);
        request.setAttribute("staffInfo", staffInfo);
        request.getRequestDispatcher("/WEB-INF/page/userInfo.jsp").forward(request, response);
    }
    
    // 修改
    public void updateUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取到前端的信息
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        // 存为UserInfo类型
        UserInfo user =new UserInfo();
        user.setId(Integer.parseInt(id));
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);
        UserService stService = new UserService();
        int i = stService.saveUserById(user);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    
    // 修改密码
    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取到前端的信息
        String id = request.getParameter("id");
        String newpassword = request.getParameter("newpassword");
        // 调用SQL语句
        UserService stService = new UserService();
        int i = stService.changePassword(Integer.parseInt(id), newpassword);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
}