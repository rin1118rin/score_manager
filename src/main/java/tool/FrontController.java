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
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        try {
            // 例: /StudentList.action → StudentList
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
 
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
 
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

