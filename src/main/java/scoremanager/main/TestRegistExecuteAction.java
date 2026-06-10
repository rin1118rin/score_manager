package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Teacher;
import bean.Test;
import tool.Action;

public class TestRegistExecuteAction extends Action {
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		String entYearStr = req.getParameter("f1");
		String classNum = req.getParameter("f2");
		String subjectCd = req.getParameter("f3");
		String noStr = req.getParameter("f4");
		
		int entYear = 0;
		int testNo = 0;
		
		if (entYearStr != null && !entYearStr.isEmpty()) {
		    entYear = Integer.parseInt(entYearStr);
		}

		if (noStr != null && !noStr.isEmpty()) {
		    testNo = Integer.parseInt(noStr);
		}
		
		Test test = new Test();
		
		
		
	}
}
