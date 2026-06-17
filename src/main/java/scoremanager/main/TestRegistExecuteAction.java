package scoremanager.main;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import tool.Action;

public class TestRegistExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		int no = 0;
		int entYear = 0;
		String pointS = "";
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		ClassNumDao cNumDao = new ClassNumDao();
		SubjectDao subDao = new SubjectDao();
		TestDao tDao = new TestDao();
		StudentDao sDao = new StudentDao();
		Connection connection = tDao.getConnection();
		
		String entYearStr = req.getParameter("f1");
		String classNum = req.getParameter("f2");
		String subject = req.getParameter("f3");
		String nums = req.getParameter("f4");

		
		if (entYearStr != null) {
			entYear = Integer.parseInt(entYearStr);
		}
		
		if (nums != null && !nums.isEmpty()) {
		    no = Integer.parseInt(nums);
		}
        
        List<Integer> entYearSet = new ArrayList<>();
		for (int i = year - 10; i < year + 1; i++) {
			entYearSet.add(i);
		}
		

 		List<Subject> subjects = subDao.filter(teacher.getSchool());
		List<String> lists = cNumDao.filter(teacher.getSchool());
		Subject sub = null;
		if (subject != null && !subject.equals("0")) {
		    sub = subDao.get(subject, teacher.getSchool());
		}
		System.out.println("sub = " + sub);

		List<Test> list = new ArrayList<>();
		if (sub != null) {
			list = tDao.filter(entYear, classNum, sub, no, teacher.getSchool());
		}
		
		req.setAttribute("f1", entYear);
		req.setAttribute("f2", classNum);
		req.setAttribute("f3", subject);
		req.setAttribute("f4", no);
		req.setAttribute("subject1", sub);
		req.setAttribute("subjects", subjects);
		req.setAttribute("class_num_set", lists);
		req.setAttribute("ent_year_set", entYearSet);
		req.setAttribute("list", list);
		
		List<Test> saveList = new ArrayList<>();
		System.out.println("f1=" + req.getParameter("f1"));
		System.out.println("f2=" + req.getParameter("f2"));
		System.out.println("f3=" + req.getParameter("f3"));
		System.out.println("f4=" + req.getParameter("f4"));
		
		for (Test test: list) {
			pointS = req.getParameter("point_" + test.getStudent().getNo());
			
			if (pointS != null && !pointS.isEmpty()) {
				test.setPoint(Integer.parseInt(pointS));
				
			}
			
			saveList.add(test);
		}
		
		tDao.save(saveList);
		req.getRequestDispatcher("/main/test_regist_done.jsp").forward(req, res);
		
	}
}
