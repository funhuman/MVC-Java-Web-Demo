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
 * ǩ��������
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
        // Ȩ�޿���
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        if (user == null || user.getId() == null) { // δ��¼����ת
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        }
        // response.setContentType("text/html;charset=utf-8");
        // req.setCharacterEncoding("UTF-8");
        // ��ȡ�����URI��ַ��Ϣ
        // http://localhost:8080/hssx/getuserinfo.user
        String url = request.getRequestURI();
        // ��ȡ���еķ�����typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        Method method = null;
        try {
            // ʹ�÷�����ƻ�ȡ�ڱ����������˵ķ���
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // ִ�з���
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("���÷�������");
        }
    }
    
    public void signin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        SignService sgService = new SignService();
        int i = sgService.signinById(user.getId());
        if (i > 0) {
            user.setCheckstatus("��ǩ��");
            //System.out.println("SignServlet(60): " + user.getId() + " ǩ���ɹ�"); // �������)
            request.getSession().setAttribute("userInfo", user);
        }
    }
}
