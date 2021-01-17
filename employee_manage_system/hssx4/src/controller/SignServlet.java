package controller;

import java.io.IOException;
import java.lang.reflect.Method;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.UserInfo;
import service.CheckService;
import service.SignService;
/**
 * 签到控制类
 * @author Jellfish 
 * update: 2021-01-16
 */
@WebServlet("*.sign")
public class SignServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CheckService usService= new CheckService();
    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
        // 权限控制
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        if (user == null || user.getId() == null) { // 未登录的跳转
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        }
        // response.setContentType("text/html;charset=utf-8");
        // req.setCharacterEncoding("UTF-8");
        // 获取请求的URI地址信息
        // http://localhost:8080/hssx/getuserinfo.user
        String url = request.getRequestURI();
        // 截取其中的方法名typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
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
    
    public void signin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        SignService sgService = new SignService();
        int i = sgService.signinById(user.getId());
        if (i > 0) {
            user.setCheckstatus("已签到");
            //System.out.println("SignServlet(60): " + user.getId() + " 签到成功"); // 调试语句)
            request.getSession().setAttribute("userInfo", user);
        }
    }
}
