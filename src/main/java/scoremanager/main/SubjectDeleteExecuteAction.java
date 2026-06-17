package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		School school = teacher.getSchool();
		
		SubjectDao dao = new SubjectDao();
		
		Subject subject = new Subject();
		
		String cd = req.getParameter("cd");
		
		System.out.println("cd=" + req.getParameter("cd"));
		
		subject.setSchool(school);
		
		subject.setCd(cd);
		
		dao.delete(subject);
		
		req.getRequestDispatcher("/main/subject_delete_done.jsp").forward(req, res);
	}
}
