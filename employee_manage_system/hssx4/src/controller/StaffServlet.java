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
 * staffinfo�������
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
        // ���������ͻ��˵ı��봦��
//        response.setContentType("text/html;charset=utf-8");
//        request.setCharacterEncoding("UTF-8");
        // ��ȡ�����URI��ַ��Ϣ
        // http://localhost:8080/hssx/getuserinfo.user
        String url = request.getRequestURI();
        // ��ȡ���еķ�����typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        //System.out.println("StaffServlet(40): " + methodName + " ������"); // �������
        // Ȩ�޿���
        UserInfo user = (UserInfo)request.getSession().getAttribute("userInfo");
//        System.out.println("StaffServlet(43): " + (user == null));
//        System.out.println("StaffServlet(44): " + !methodName.equals("insertStaff"));
        //System.out.println("StaffServlet(45): " + (boolean)((user == null || user.getId() == null || "".equals(user.getId())) && !(methodName.equals("insertStaff"))));
        if ((user == null || user.getId() == null || "".equals(user.getId())) && !methodName.equals("insertStaff") ) { // δ��¼����ת
            request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
            return;
        } 
        try {
            if (!(user.getId() == null || "".equals(user.getId()))) {
                //System.out.println("StaffServlet(52): " + " �û� " + user.getId() +" ��Ϊ��"); // �������)
                if (!user.getRole().equals("����")) { return; }
            }
        } catch (Exception e) {
            //System.out.println("StaffServlet(56): �û�Ϊ�գ���������Ȩ����֤");
        }
        //System.out.println("StaffServlet(53): ���뷴�亯��");
        Method method = null;
        try {
            // ʹ�÷�����ƻ�ȡ�ڱ����������˵ķ���
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // ִ�з���
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("��ͼ���� " + methodName + " ��������");
        }
    }
  
    // ��ѯҳ����ת
    public void findStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = request.getParameter("mode");
        String selectName = request.getParameter("selectName");
        String selectPhone = request.getParameter("selectPhone");
//        System.out.println("StaffServlet(68): ��ͼ��ѯ" + selectName + " " + selectPhone); // �������
//        if (selectName!=null) { selectName = new String(selectName.getBytes("iso-88859-1"), "utf-8"); }
//        if (selectPhone!=null) { selectPhone = new String(selectPhone.getBytes("iso-88859-1"), "utf-8"); }
        //System.out.println("StaffServlet(71): ��ͼ��ѯ" + selectName + " " + selectPhone); // �������
        StaffService stService = new StaffService();
        //System.out.println("StaffServlet(73): ��ѯģʽ" + (!"".equals(mode) && mode != null)); // �������
        List<StaffInfo> stList = stService.selectStaff(((!"".equals(mode) && mode != null) ? "like" : "nolike"), selectName, selectPhone);
        request.setAttribute("list", (stList==null?null:stList));
        request.setAttribute("selectName", selectName);
        request.setAttribute("selectPhone", selectPhone);
        request.getRequestDispatcher("/WEB-INF/page/staff-info.jsp").forward(request, response);
    }
    
    // ���ҳ����ת
    public void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(request, response);
    }
    // ���
    public void insertStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //System.out.println("StaffServlet(91): " + "insertStaff ����"); // �������)
        // ��ȡ��ǰ�˵���Ϣ
        String username = request.getParameter("username");
        UserService userService = new UserService();
        if (userService.selectUserByName(username)) { 
            //System.out.println("StaffServlet(96): " + "return \"re\";"); // �������
            response.getWriter().write("re");
            return;
        }
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        // ��ΪStaffInfo����
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
    // ɾ��
    public void delStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        StaffService stService = new StaffService();
        int i = stService.deleteStaffById(Integer.parseInt(id));
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    
    // �޸�ҳ����ת
    public void modStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        // System.out.println("StaffServlet(105): " + id + " ������"); // �������
        // ͨ��ID��ѯ�����ݣ������޸�ҳ��
        StaffService stService = new StaffService();
        StaffInfo staffInfo = stService.selectStaffById(Integer.parseInt(id));
        // System.out.println("StaffServlet(109): " + staffInfo.getUsername()+" "+ staffInfo.getName()+ " ��ȡ"); // �������
        request.setAttribute("staffInfo", staffInfo);
        request.getRequestDispatcher("/WEB-INF/page/staff-mod.jsp").forward(request, response);
    }
    
    // �޸Ĺ���
    public void updateStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ��ȡ��ǰ�˵���Ϣ
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String oldusername = request.getParameter("oldusername");
//        System.out.println("StaffServlet(119): " + username + " " + oldusername); // �������
//        System.out.println("StaffServlet(119): " + new UserService().selectUserByName(username)); // �������
//        System.out.println("StaffServlet(119): " + !username.equals(oldusername)); // �������
        if (new UserService().selectUserByName(username) && !username.equals(oldusername)) { 
            //System.out.println("StaffServlet(120): " + "return \"no\";"); // �������
            response.getWriter().write("re");
            return;
        }
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String sex = request.getParameter("sex");
        String role = request.getParameter("role");
        // ��ΪStaffInfo����
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