package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class LoginExecuteAction extends Action {

    public String execute(HttpServletRequest req,HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();

        String id = req.getParameter("id");
        String password = req.getParameter("password");

        TeacherDao dao = new TeacherDao();

        Teacher teacher = dao.login(id, password);

        if (teacher != null) {

            session.setAttribute("teacher", teacher);
            
            req.getRequestDispatcher("menu.jsp").forward(req, res);

            return null;
        }
        	
        req.getRequestDispatcher("error.jsp").forward(req, res);
        
        return null;
    }
}