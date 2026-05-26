package tool;
<<<<<<< HEAD
=======
 
>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<< HEAD
 
@WebServlet(urlPatterns={"*.action"})
 
=======

@WebServlet(urlPatterns={"*.action"})

>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
public class FrontController extends HttpServlet {
 

<<<<<<< HEAD
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
=======
 
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
        try {
            // 例: /StudentList.action → StudentList
<<<<<<< HEAD
            String path = req.getServletPath().substring(1);
            String base = path.replace(".action", "").replace("/", ".");
            // パッケージ名 + クラス名
            String className;
            if (base.equals("Login") || base.equals("LoginExecute")) {
            	className = "scoremanager." + base + "Action";
            } else {
            	className = "scoremanager." + base + "Action";
            }

            System.out.println("★ servlet path -> " + req.getServletPath());
            System.out.println("★ class name -> " + className);
            Class<?> type = Class.forName(className);
            Action action = (Action) type.getDeclaredConstructor().newInstance();
            action.execute(req, res);
=======
            String path = request.getServletPath().substring(1);
            String base = path.replace(".action", "").replace("/", ".");
 
            // パッケージ名 + クラス名
            String className;
            if (base.equals("Login") || base.equals("LoginExecute")) {
            	className = "scoremanager." + base + "Action";
            } else {
            	className = "scoremanager." + base + "Action";
            }
 
 
            System.out.println("★ servlet path -> " + request.getServletPath());
            System.out.println("★ class name -> " + className);
 
            Class<?> type = Class.forName(className);
            Action action = (Action) type.getDeclaredConstructor().newInstance();
 
            action.execute(request, response);
 
>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
        } catch (Exception e) {
            e.printStackTrace();
<<<<<<< HEAD
            req.getRequestDispatcher("/error.jsp").forward(req, res);
=======
            request.getRequestDispatcher("/error.jsp").forward(request, response);
>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
        }
    }
<<<<<<< HEAD
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
=======
 
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

>>>>>>> branch 'master' of https://github.com/rin1118rin/score_manager.git
