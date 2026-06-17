package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
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
		School school = teacher.getSchool();
		Subject subject = new Subject();
		
		cd = req.getParameter("cd");
		name = req.getParameter("name");
		
		List<Subject> list = new ArrayList<>();
		
		subject.setCd(cd);
		
		subject.setName(name);
		
		subject.setSchool(school);
		
		list.add(subject);
		
		subDao.save(subject);
		req.getRequestDispatcher("/main/subject_create_done.jsp").forward(req, res);
	}
}
