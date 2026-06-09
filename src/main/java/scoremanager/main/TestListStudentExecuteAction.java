package scoremanager.main;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import bean.TestListStudent;
import dao.StudentDao;
import dao.TestListStudentDao;
import tool.Action;

public class TestListStudentExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		String no = "";
		
		StudentDao sDao = new StudentDao();
		TestListStudentDao tDao = new TestListStudentDao();
		
		no = req.getParameter("f4");
		
		Student student = sDao.get(no);
		
		List<TestListStudent> list = null;

        if (student != null) {
            list = tDao.filter(student);
        }
        
        req.setAttribute("student", student);
        req.setAttribute("list", list);
        
        req.getRequestDispatcher("/main/test_list_student.jsp").forward(req, res);
	}
}
