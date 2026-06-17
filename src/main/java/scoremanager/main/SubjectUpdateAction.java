package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String cd = req.getParameter("cd");
		
		School school = teacher.getSchool();
		
		SubjectDao dao = new SubjectDao();
		
		Subject subject = dao.get(cd, school);
		
		
		
		req.setAttribute("cd", subject.getCd());
		req.setAttribute("name", subject.getName());
		req.getRequestDispatcher("subject_update.jsp").forward(req, res);
	}
}
