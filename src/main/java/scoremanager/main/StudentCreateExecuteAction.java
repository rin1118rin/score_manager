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

public class StudentCreateExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String entYearStr = "";
		
		String no = "";
		
		String name = "";
		
		String classNum = "";
		
		int entYear = 0;
		
		StudentDao sDao = new StudentDao();
		
		entYearStr = req.getParameter("ent_year");
		
		no = req.getParameter("no");

		name = req.getParameter("name");
		
		classNum = req.getParameter("class_num");
		
		LocalDate today = LocalDate.now();
		int year = today.getYear();

		List<Integer> entYearSet = new ArrayList<>();

		for (int i = year - 10; i <= year; i++) {
			entYearSet.add(i);
		}

		ClassNumDao cNumDao = new ClassNumDao();
		List<String> classNumSet = cNumDao.filter(teacher.getSchool());

		// 入力値保持
		req.setAttribute("no", no);
		req.setAttribute("name", name);
		req.setAttribute("class_num", classNum);
		req.setAttribute("ent_year", entYearStr);

		req.setAttribute("ent_year_set", entYearSet);
		req.setAttribute("class_num_set", classNumSet);

		// 入学年度未選択
		if (entYearStr == null || entYearStr.isEmpty()) {

			req.setAttribute("error", "入学年度を選択してください");

			req.getRequestDispatcher("student_create.jsp")
					.forward(req, res);
			return;
		}

		// 学生番号重複
		if (sDao.get(no) != null) {

			req.setAttribute("error", "学生番号が重複しています");

			req.getRequestDispatcher("/main/student_create.jsp")
					.forward(req, res);
			return;
		}

		entYear = Integer.parseInt(entYearStr);
		Student student = new Student();
		
		student.setNo(no);
		
		student.setName(name);
		
		student.setEntYear(entYear);
		
		student.setClassNum(classNum);
		
		student.setAttend(true);
		
		student.setSchool(teacher.getSchool());
		
		sDao.save(student);
		
		req.getRequestDispatcher("/main/student_create_done.jsp").forward(req, res);
	}
}
