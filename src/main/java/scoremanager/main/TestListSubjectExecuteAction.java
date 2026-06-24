package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.ClassNumDao;
import dao.SubjectDao;
import dao.TestListSubjectDao;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {
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
		String subjectCd = "";
		int entYear = 0;
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		ClassNumDao cNumDao = new ClassNumDao();
		Map<String,String> errors = new HashMap<>();
		
		entYearStr = req.getParameter("f1");
		classNum = req.getParameter("f2");
		subjectCd = req.getParameter("f3");
		no = req.getParameter("f4");
		

		
		SubjectDao subDao = new SubjectDao();
		
		School school = teacher.getSchool();
        
        List<String> Clist = cNumDao.filter(teacher.getSchool());
        
        TestListSubjectDao dao = new TestListSubjectDao();
        
        if (entYearStr != null) {
			entYear = Integer.parseInt(entYearStr);
		}
        
        List<Integer> entYearSet = new ArrayList<>();
		for (int i = year - 10; i < year + 1; i++) {
			entYearSet.add(i);
		}
		
		if (entYear != 0 && !classNum.equals("0") && !subjectCd.equals("0")) {
			System.out.println("ok");
			Subject subject = subDao.get(subjectCd, school);
	        
			List<Subject> subjects = subDao.filter(teacher.getSchool());
	        List<TestListSubject> list = dao.filter(entYear, classNum, subject, school);
	        
	        req.setAttribute("list", list);
	        req.setAttribute("subjects", subjects);
	        req.setAttribute("subject", subject.getName());
			req.setAttribute("class_num_set", Clist);
			req.setAttribute("ent_year_set", entYearSet);
	        
	        req.getRequestDispatcher("/main/test_list_subject.jsp").forward(req, res);
		} else {
			errors.put("f1", "入学年度とクラスと科目を選択してください");
			List<Subject> subjects = subDao.filter(teacher.getSchool());
		    req.setAttribute("errors", errors);
		    
		    req.setAttribute("f1", entYear);
		    req.setAttribute("f2", classNum);
		    req.setAttribute("f3", subjectCd);
		    
		    req.setAttribute("subjects", subjects);
		    req.setAttribute("class_num_set", Clist);
			req.setAttribute("ent_year_set", entYearSet);
		    req.getRequestDispatcher("/main/test_list_subject.jsp").forward(req, res);
		}
	}
}