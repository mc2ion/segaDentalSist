package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;


/**
 * Servlet implementation class EditClientIdentCardServlet
 */
@WebServlet(description = "servlet to edit identity card's client", urlPatterns = { "/EditClientIdentCardServlet" })
public class EditClientIdentCardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditClientIdentCardServlet() {
        super();
    }
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;

		try{
			
			int clientId = Integer.valueOf(request.getParameter("clientId"));
			String identityCardId = request.getParameter("txtCedId");
			String identityCardNum = request.getParameter("txtCedIdNum");
			String identityCard = identityCardId+identityCardNum;
		
			String type = request.getParameter("type");
			int id = Integer.valueOf(request.getParameter("id"));
		
			Integer rowsUpdated = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditClientIdentityCard(clientId, identityCard));
			
			if(rowsUpdated == 1){
				request.setAttribute("clientId", clientId);
				request.setAttribute("type", type);
				request.setAttribute("id", id);
				rd = getServletContext().getRequestDispatcher("/EditRequestServlet");			
				rd.forward(request, response);
			} else {
				request.setAttribute("info", "");
				request.setAttribute("error", "Ocurri� un error durante la edici�n del producto. Por favor intente de nuevo y si el error persiste contacte a su administrador.");
				rd = getServletContext().getRequestDispatcher("/EditRequestServlet");			
				rd.forward(request, response);
			}
			
		} catch (Exception e) {
			request.setAttribute("info", "");
			request.setAttribute("error", "Ocurri� un error durante la edici�n del producto. Por favor intente de nuevo y si el error persiste contacte a su administrador.");
			rd = getServletContext().getRequestDispatcher("/EditRequestServlet");			
			rd.forward(request, response);
		}
		
	}
}
