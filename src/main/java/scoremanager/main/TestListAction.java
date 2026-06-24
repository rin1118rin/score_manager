package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import dao.ClassNumDao;
import dao.SubjectDao;
import tool.Action;

public class TestListAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String no = "";
		String entYearStr = "";
		String classNum = "";
		String subject = "";
		int entYear = 0;
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		List<Student> students = null;
		ClassNumDao cNumDao = new ClassNumDao();
		SubjectDao subDao = new SubjectDao();
		Map<String, String> errors = new HashMap<>();
		
		entYearStr = req.getParameter("f1");
		classNum = req.getParameter("f2");
		subject = req.getParameter("f3");
		no = req.getParameter("f4");
		
		
		if (entYearStr != null) {
			entYear = Integer.parseInt(entYearStr);
		}
		
		List<Integer> entYearSet = new ArrayList<>();
		for (int i = year - 10; i < year + 1; i++) {
			entYearSet.add(i);
		}
	
		
		List<String> list = cNumDao.filter(teacher.getSchool());
		
		List<Subject> subjects = subDao.filter(teacher.getSchool());
		
		System.out.println("subjects size = " + subjects.size());
		
		
		req.setAttribute("f1", entYear);
		req.setAttribute("f2", classNum);
		req.setAttribute("f3", subject);
		req.setAttribute("f4", no);
		req.setAttribute("students", students);
		req.setAttribute("subjects", subjects);
		req.setAttribute("class_num_set", list);
		req.setAttribute("ent_year_set", entYearSet);
		
		req.getRequestDispatcher("/main/test_list.jsp").forward(req, res);
	}
}
