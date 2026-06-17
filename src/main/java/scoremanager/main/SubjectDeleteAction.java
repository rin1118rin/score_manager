package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String cd = req.getParameter("cd");
		
		String name = req.getParameter("name");
		
		School school = teacher.getSchool();
		
		SubjectDao dao = new SubjectDao();
		
		Subject subject = dao.get(cd, school);
		
		
		req.setAttribute("cd", subject.getCd());
		req.setAttribute("name", subject.getName());
		req.getRequestDispatcher("/main/subject_delete.jsp").forward(req, res);
	}
}
