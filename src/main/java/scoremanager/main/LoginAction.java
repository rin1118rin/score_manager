package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tool.Action;

public class LoginAction extends Action {
	public String execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		req.getRequestDispatcher("login.jsp").forward(req, res);
		
		return null;
    }
}