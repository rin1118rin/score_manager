package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.TestListStudent;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestListStudentDao;
import tool.Action;

public class TestListStudentExecuteAction extends Action {
	@Override
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		String no = "";
		int entYear = 0;
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		ClassNumDao cNumDao = new ClassNumDao();
		
		StudentDao sDao = new StudentDao();
		
		String entYearStr = req.getParameter("f1");
		String classNum = req.getParameter("f2");
		String subjectCd = req.getParameter("f3");
		no = req.getParameter("f4");
		
		System.out.println("入力された学生番号=" + no);
		
		Student student = sDao.get(no);
		
		SubjectDao subDao = new SubjectDao();
		
		School school = teacher.getSchool();
		
		if (entYearStr != null) {
			entYear = Integer.parseInt(entYearStr);
		}
        
        List<Integer> entYearSet = new ArrayList<>();
		for (int i = year - 10; i < year + 1; i++) {
			entYearSet.add(i);
		}

		System.out.println("取得したstudent=" + student);
		
		if (student == null) {
		    req.setAttribute("error", "学生が存在しません");
		    req.setAttribute("subjects", subDao.filter(teacher.getSchool()));
		    req.setAttribute("class_num_set", cNumDao.filter(teacher.getSchool()));
		    req.setAttribute("ent_year_set", entYearSet);
		    req.setAttribute("list", new ArrayList<TestListStudent>());
		    req.getRequestDispatcher("/main/test_list_student.jsp")
		       .forward(req, res);
		    return;
		}
		
		
		TestListStudentDao tDao = new TestListStudentDao();
		
		List<String> Clist = cNumDao.filter(teacher.getSchool());
		List<TestListStudent> list = tDao.filter(student);
		List<Subject> subjects = subDao.filter(teacher.getSchool());
		
		
		System.out.println("student no = " + student.getNo());
		System.out.println("list size=" + list.size());
        
        req.setAttribute("student", student);
        req.setAttribute("list", list);
        req.setAttribute("subjects", subjects);
		req.setAttribute("class_num_set", Clist);
		req.setAttribute("ent_year_set", entYearSet);
        
        
        req.getRequestDispatcher("/main/test_list_student.jsp").forward(req, res);
	}
}
