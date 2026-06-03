package scoremanager.main;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectListAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("Teacher");
		
		School school = teacher.getSchool();
		
		SubjectDao dao = new SubjectDao();
		
		List<Subject> list = dao.filter(school);
		
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("subject_list.jsp").forward(req, res);
	}
}
