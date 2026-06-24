package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

public class TestRegistAction extends Action {
	@Override
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		int no = 0;
		int entYear = 0;
		boolean isAttend = true;
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		StudentDao sDao = new StudentDao();
		Subject subs = new Subject();
		ClassNumDao cNumDao = new ClassNumDao();
		SubjectDao subDao = new SubjectDao();
		TestDao tDao = new TestDao();
		List<Test> tests = null;
		Map<String,String> errors = new HashMap<>();
		
		String entYearStr = req.getParameter("f1");
		String classNum = req.getParameter("f2");
		String subject = req.getParameter("f3");
		String nums = req.getParameter("f4");
		
		
		if (entYearStr != null && !entYearStr.isEmpty()) {
		    entYear = Integer.parseInt(entYearStr);
		}

		if (nums != null && !nums.isEmpty()) {
		    no = Integer.parseInt(nums);
		}
		
		List<Integer> entYearSet = new ArrayList<>();
		for (int i = year - 10; i < year + 1; i++) {
			entYearSet.add(i);
		}
		

		List<String> list = cNumDao.filter(teacher.getSchool());
		List<Subject> subjects = subDao.filter(teacher.getSchool());
		List<String> counts = new ArrayList<>();
		counts.add("1");
		counts.add("2");
		String mode = req.getParameter("mode");
		if ("search".equals(mode)) {
			if (entYear != 0 && !classNum.equals("0") && !subject.equals("0") && !nums.equals("0")) {
				for (Subject sub : subjects) {
					if (sub.getCd().equals(subject)) {
						subs = sub;
						break;
					}
				}
				
				tests = tDao.filter(entYear, classNum, subs, no, teacher.getSchool());
				session.setAttribute("tests",tests);
				session.setAttribute("subject", subs.getName());
				session.setAttribute("no", no);
			} else {
				errors.put("f1","入学年度とクラスと科目と回数を選択してください");
				req.setAttribute("errors",errors);
			}
		}
		req.setAttribute("f1", entYear);
		req.setAttribute("f2", classNum);
		req.setAttribute("f3", subject);
		req.setAttribute("f4", nums);
		req.setAttribute("tests", tests);
		req.setAttribute("subjects", subjects);
		req.setAttribute("class_num_set", list);
		req.setAttribute("ent_year_set", entYearSet);
		req.setAttribute("num", counts);
		
		req.getRequestDispatcher("/main/test_regist.jsp").forward(req, res);
	}	
}
