package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Util.Print;
import Util.SendEmail;


import command.CommandExecutor;

import domain.ReportItem;
import domain.User;


/**
 * Servlet implementation class SendBackRequestServlet
 */
@WebServlet(description = "servlet to send report of today's requests", urlPatterns = { "/PrintReportServlet" })
public class PrintReportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrintReportServlet() {
        super();
    }
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("aqui");
		
		RequestDispatcher rd;
		
		try{
			HttpSession session = request.getSession(true);
			User user = (User) session.getAttribute("user");
			   
			if(user != null){
				int roleId = user.getRoleId();
				
				if(roleId == 3 || roleId == 8){
					@SuppressWarnings("unchecked")
					ArrayList<ReportItem> reportItems = (ArrayList<ReportItem>)CommandExecutor.getInstance().executeDatabaseCommand(new command.CreateReportOfRequests());
					if (reportItems.size() > 0){
						
						request.setAttribute("report", reportItems);
						request.setAttribute("info", "El correo fue env�ado sastifactoriamente");
						rd = getServletContext().getRequestDispatcher("/printReport.jsp");			
						rd.forward(request, response);
					}
					else{	
						request.setAttribute("info", "Actualmente no hay ventas para mostrar. Intente m�s tarde");
						rd = getServletContext().getRequestDispatcher("/ListRequestsServlet");			
						rd.forward(request, response);
					}
				} else {
					request.setAttribute("error", "Usted no posee permisos para realizar esta operaci�n");
					rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");
					rd.forward(request, response);
				}			
			} else {
				rd = getServletContext().getRequestDispatcher("/index.jsp");			
				rd.forward(request, response);
			}
		} catch (Exception e) {	
			e.printStackTrace();
		
		}
	}
	
	
}
