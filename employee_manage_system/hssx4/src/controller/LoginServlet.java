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
 * ��¼���ܿ�����
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
        // System.out.println("LoginServlet(33): " + "�û���: " + username + "  ����: " + password + "  ���Ե�¼"); // �������
        // �����ݿ��ѯ
        UserService userScervie = new UserService();
        UserInfo user = userScervie.selectUser(username, password);
        // �жϲ�ѯ�Ƿ�Ϊ�գ�Ϊ�յ�¼ʧ��
        if (user == null || user.getId() == null) {
            response.getWriter().write("no");
            return;
        }
        // ��¼�ɹ�����¼Session
        HttpSession session = request.getSession();
        session.setAttribute("userInfo", user);
        // System.out.println("LoginServlet(44): " + user.getRole() + " " + user.getUsername() + " " + user.getCheckstatus() + " ��¼�ɹ�"); // �������
        response.getWriter().write("ok");
    }
}