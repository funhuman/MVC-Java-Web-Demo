package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserInfo;
import service.UserService;

import javax.servlet.annotation.WebServlet;
/**
 * 登录功能控制类
 * @author YOUNG
 * update: 2021-01-15
 */
@WebServlet("/loginCheck")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // System.out.println("LoginServlet(33): " + "用户名: " + username + "  密码: " + password + "  尝试登录"); // 调试语句
        // 到数据库查询
        UserService userScervie = new UserService();
        UserInfo user = userScervie.selectUser(username, password);
        // 判断查询是否为空，为空登录失败
        if (user == null || user.getId() == null) {
            response.getWriter().write("no");
            return;
        }
        // 登录成功，记录Session
        HttpSession session = request.getSession();
        session.setAttribute("userInfo", user);
        // System.out.println("LoginServlet(44): " + user.getRole() + " " + user.getUsername() + " " + user.getCheckstatus() + " 登录成功"); // 调试语句
        response.getWriter().write("ok");
    }
}