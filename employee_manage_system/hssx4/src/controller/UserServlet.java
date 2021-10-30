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
 * userinfo�������
 * @author YOUNG
 * update: 2021-01-15
 */
@WebServlet("*.user") // ���ݽ�β�ж�
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
        // ��ȡ�����URI��ַ��Ϣ
        // http://localhost:8080/hssx4/getuserinfo.user
        String url = request.getRequestURI();
        // ��ȡ���еķ�����typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        //System.out.println("UserServlet(37): " +" ������"); // �������)
        // Ȩ�޿���
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
        //System.out.println("UserServlet(40): !methodName.equals(\"quit\"): " +!methodName.equals("quit")); // �������)
        //System.out.println("UserServlet(41): " + (user == null || user.getId() == null || !"".equals(user.getId()) && !methodName.equals("quit")) + " ������"); // �������)
        if (!methodName.equals("quit") && (user == null || user.getId() == null || !"".equals(user.getId()))) { // δ��¼����ת
            //System.out.println("UserServlet(42): " + "��ת�� ע��ҳ ������"); // �������)
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        }
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
	
	// ��ת
    public void quit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserInfo user = new UserInfo();
        request.getSession().setAttribute("userInfo", user);
        //System.out.println("UserServlet(66): �û��˳� ������"); // �������)
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
	// ��ѯ
    public void getuserinfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ��Session�л�ȡ�û���Ϣ
        UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
        StaffService staffScervie = new StaffService();
        StaffInfo staffInfo = staffScervie.selectStaffById(userInfo.getId());
        //System.out.println("UserServlet(76): " + staffInfo.getName() + " Session ����ȡ"); // �������
        request.setAttribute("userInfo", userInfo);
        request.setAttribute("staffInfo", staffInfo);
        request.getRequestDispatcher("/WEB-INF/page/userInfo.jsp").forward(request, response);
    }
    
    // �޸�
    public void updateUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ��ȡ��ǰ�˵���Ϣ
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        // ��ΪUserInfo����
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
    
    // �޸�����
    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ��ȡ��ǰ�˵���Ϣ
        String id = request.getParameter("id");
        String newpassword = request.getParameter("newpassword");
        // ����SQL���
        UserService stService = new UserService();
        int i = stService.changePassword(Integer.parseInt(id), newpassword);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
}