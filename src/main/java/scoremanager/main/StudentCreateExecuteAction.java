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
		
		if (entYearStr != null && !entYearStr.equals("")) {
			entYear = Integer.parseInt(entYearStr);
		}
		if (entYearStr == null || entYearStr.equals("")) {
			req.setAttribute("no", no);
			req.setAttribute("name", name);
			req.setAttribute("class_num", classNum);
			req.setAttribute("ent_year", entYearStr);
			
			LocalDate todaysDate = LocalDate.now();
			
			int year = todaysDate.getYear();
			
			ClassNumDao cNumDao = new ClassNumDao();
			
			List<Integer> entYearSet = new ArrayList<>();
			for (int i = year - 10; i < year + 1; i++) {
				entYearSet.add(i);
			}
		
			if (sDao.get(no) != null ) {
			
				List<String> list = cNumDao.filter(teacher.getSchool());
				
				req.setAttribute("class_num_set", list);
				
				req.setAttribute("ent_year_set", entYearSet);
			}
			
		}
		Student student = new Student();
		
		student.setNo(no);
		
		student.setName(name);
		
		student.setEntYear(entYear);
		
		student.setClassNum(classNum);
		
		student.setAttend(true);
		
		student.setSchool(teacher.getSchool());
		
		sDao.save(student);
		
		req.getRequestDispatcher("main/student_create_done.jsp").forward(req, res);
	}
}
