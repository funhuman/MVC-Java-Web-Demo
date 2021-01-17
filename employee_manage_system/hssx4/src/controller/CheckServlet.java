package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.CheckInfo;
import bean.UserInfo;
import service.CheckService;

@WebServlet("*.ck")
public class CheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CheckService usService= new CheckService();
    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse response) throws ServletException, IOException
    {
        doPost(req,response);
    }
    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse response) throws ServletException, IOException
    {   
        // 权限控制
        UserInfo user = (UserInfo)req.getSession().getAttribute("userInfo");
        if (user == null || user.getId() == null) { // 未登录的跳转
            req.getRequestDispatcher("/WEB-INF/page/staff-add.jsp").forward(req, response);
            return;
        }
        if (!user.getRole().equals("经理")) {
            return;
        }
        response.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("UTF-8");
        // 获取请求的URI地址信息
        // http://localhost:8080/hssx/getuserinfo.user
        String url = req.getRequestURI();
        // 截取其中的方法名typeList
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        switch(methodName)
        {
        case "findStatus":
            findStatus(req,response);
            break;
        case "updateUserStatus":
            updateUserStatus(req,response);
            break;
        case "updateUserStatusById":
            updateUserStatusById(req,response);
            break;
        case "outUserStatus":
            outUserStatus(req,response);
            break;
        case "offUserStatus":
            offUserStatus(req,response);
            break;
        default:
            break;
        }
    }
    public void findStatus(HttpServletRequest req,HttpServletResponse response) throws ServletException, IOException
    {
        List<CheckInfo> usList=usService.findStatus();
        req.setAttribute("list", usList);
        req.getRequestDispatcher("/WEB-INF/page/check-list.jsp").forward(req, response);
    } 
    public void updateUserStatus(HttpServletRequest req,HttpServletResponse response) throws ServletException, IOException
    {
        String staffid = req.getParameter("staffid");
        CheckInfo CheckInfo = usService.findUserStatusById(Integer.parseInt(staffid));
        req.setAttribute("CheckInfo",CheckInfo);
        req.getRequestDispatcher("/WEB-INF/page/check-mod.jsp").forward(req, response);
    }
    public void updateUserStatusById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取到前端的信息
        String staffid = request.getParameter("staffid");
        String checkstatus = request.getParameter("checkstatus");
        // 存为StudentInfo类型
        CheckInfo us =new CheckInfo();
        us.setCheckstatus(checkstatus);
        us.setStaffid(Integer.parseInt(staffid));
        int i = usService.updateUserStatusById(us);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    public void outUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        String checkstatus = request.getParameter("checkstatus");
        int i=usService.outUserStatus(checkstatus);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
    public void offUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        String checkstatus1 = request.getParameter("checkstatus1");
        String checkstatus2 = request.getParameter("checkstatus2");
        int i=usService.offUserStatus(checkstatus1,checkstatus2);
        String rtn = (i > 0 ? "ok" : "no");
        response.getWriter().write(rtn);
    }
}
