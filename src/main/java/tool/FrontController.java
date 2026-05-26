package tool;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
@WebServlet(urlPatterns={"*.action"})
 
public class FrontController extends HttpServlet {
 

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // 例: /StudentList.action → StudentList
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
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}