package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher) session.getAttribute("user");

		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String entYearStr = "";
		String no = "";
		StudentDao sDao = new StudentDao();
		
		no = req.getParameter("no");
		LocalDate today = LocalDate.now();
		int year = today.getYear();

		List<Integer> entYearSet = new ArrayList<>();

		for (int i = year - 10; i <= year; i++) {
			entYearSet.add(i);
		}

		ClassNumDao cNumDao = new ClassNumDao();
		List<String> classNumSet = cNumDao.filter(teacher.getSchool());
		Student student = sDao.get(no);
		
		System.out.println("sub = " + entYearStr);
		
		req.setAttribute("no", student.getNo());
		req.setAttribute("entYear", student.getEntYear());
		req.setAttribute("class_num_set", classNumSet);

		req.getRequestDispatcher("/main/student_update.jsp")
			.forward(req, res);
	}
}
