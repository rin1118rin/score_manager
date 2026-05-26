package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import tool.Action;

public class LoginAction extends Action {
<<<<<<< HEAD
	public String execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		req.getRequestDispatcher("login.jsp").forward(req, res);
		
		return null;
    }
}
=======
	public void execute(HttpServletRequest req,HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
	}
}
>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
