package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Teacher;
import bean.Test;
import dao.TestDao;
import tool.Action;

public class TestRegistExecuteAction extends Action {
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		if (teacher == null) {
			res.sendRedirect("Login.action");
			return;
		}
		
		TestDao tDao = new TestDao();
        List<Test> tests = (List<Test>) session.getAttribute("tests");
 
        if (tests == null || tests.isEmpty()) {
            res.sendRedirect("TestRegist.action");
            return;
        }
 
        Map<String, String> errors = new HashMap<>();
 
        for (Test test : tests) {
            String studentNo = test.getStudent().getNo();
            String pointStr = req.getParameter("point_" + studentNo);
            if (pointStr == null || pointStr.isEmpty()) {
            	errors.put(studentNo, "数値を入力してください");
            }
            if (pointStr != null && !pointStr.equals("")) {
                try {
                    int point = Integer.parseInt(pointStr);
 
                    if (point >= 0 && point <= 100) {
                        test.setPoint(point);
                    } else {
                        errors.put(studentNo, "0～100の範囲で入力してください");
                    }
 
                } catch (NumberFormatException e) {
                    errors.put(studentNo, "数値を入力してください");
                }
            }
        }
 
        // ★ エラーがある場合
        if (!errors.isEmpty()) {
    		req.setAttribute("tests", tests);
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/main/test_regist.jsp")
                   .forward(req, res);
            return;
        }
 
        // ★ 正常時
        tDao.save(tests);
        session.removeAttribute("tests");
 
        req.getRequestDispatcher("/main/test_regist_done.jsp")
               .forward(req, res);
	}
}
