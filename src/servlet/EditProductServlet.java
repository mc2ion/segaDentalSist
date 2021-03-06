package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;

import domain.Product;
import domain.User;

/**
 * Servlet implementation class EditProductServlet
 */
@WebServlet(description = "servlet to edit products", urlPatterns = { "/EditProductServlet" })
public class EditProductServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProductServlet() {
        super();
    }
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try{
			HttpSession session = request.getSession(true);
			User user = (User) session.getAttribute("user");
			RequestDispatcher rd;
			   
			if(user != null){
				int roleId = user.getRoleId();
				
				if(roleId == 1 || roleId == 8){
					Long productId = Long.valueOf(request.getParameter("productId"));
					Product productInfo = (Product)CommandExecutor.getInstance().executeDatabaseCommand(new command.SelectProduct(productId));
					request.setAttribute("productInfo", productInfo);
					request.setAttribute("productId", productId);
					rd = getServletContext().getRequestDispatcher("/editProduct.jsp");			

					rd.forward(request, response);
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
			throw new ServletException(e);
		}		
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd;
		
		try{
			int productId = Integer.valueOf(request.getParameter("txtProductId"));
			String name = request.getParameter("txtNameProduct");
			String description = request.getParameter("txtDescription");
			String price = request.getParameter("txtPrice");
			String scriptStep2 = request.getParameter("txtScriptStep2");
			String scriptStep3 = request.getParameter("txtScriptStep3");
			int isActive = 0;
			if (request.getParameter("txtIsActive") != null)
				isActive = 1;
			
			Product product = new Product();
			product.setId(productId);
			product.setName(name);
			product.setDescription(description);
			product.setStatus(isActive);
			product.setPrice(price);
			product.setScriptStep2(scriptStep2);
			product.setScriptStep3(scriptStep3);
			
			Integer rowsUpdated = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditProduct(product));
			
			if(rowsUpdated == 1){
				request.setAttribute("info", "El producto fue editado exitosamente.");
				request.setAttribute("error", "");
				rd = getServletContext().getRequestDispatcher("/ListProductsServlet");			

				rd.forward(request, response);
			} else {
				request.setAttribute("info", "");
				request.setAttribute("error", "Ocurri� un error durante la edici�n del producto. Por favor intente de nuevo y si el error persiste contacte a su administrador.");
				rd = getServletContext().getRequestDispatcher("/ListProductsServlet");			

				rd.forward(request, response);
			}
			
		} catch (Exception e) {
			request.setAttribute("info", "");
			request.setAttribute("error", "Ocurri� un error durante la edici�n del producto. Por favor intente de nuevo y si el error persiste contacte a su administrador.");
			rd = getServletContext().getRequestDispatcher("/ListProductsServlet");			

			rd.forward(request, response);
		}
	}
}
