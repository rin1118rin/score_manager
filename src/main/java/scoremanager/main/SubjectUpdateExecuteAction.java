package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String cd = "";
		String name = "";
		SubjectDao subDao = new SubjectDao();

		Subject subject = new Subject();
		
		cd = req.getParameter("cd");
		name = req.getParameter("name");
		
		subject.setCd(cd);
		
		subject.setName(name);
		
		subject.setSchool(teacher.getSchool());
		
		subDao.save(subject);
		
		req.getRequestDispatcher("/main/subject_update_done.jsp").forward(req, res);
	}
}
