package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class LoginExecuteAction extends Action {

    public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();

        String id = req.getParameter("id");
        String password = req.getParameter("password");
        
        try {
        		TeacherDao dao = new TeacherDao();
            Teacher teacher = dao.login(id, password);
            
            System.out.println("teacher = " + teacher);
            
            if (teacher != null) {

                session.setAttribute("user", teacher);

                req.getRequestDispatcher("/main/menu.jsp").forward(req, res);

                return;
            }
            
            req.setAttribute("error", "ログインに失敗しました。IDまたはパスワードが正しくありません。");
            req.getRequestDispatcher("/main/login.jsp").forward(req,res);
            return;
            
        } catch (Exception e) {
        		e.printStackTrace();
        		req.getRequestDispatcher("/error.jsp")
        			.forward(req, res);	
        }
    }
}
