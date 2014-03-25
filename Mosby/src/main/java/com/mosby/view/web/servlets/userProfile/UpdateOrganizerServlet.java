package main.java.com.mosby.view.web.servlets.userProfile;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.mosby.controller.services.UpdateOrganizerService;


@WebServlet("/updateOrganizer")
public class UpdateOrganizerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	UpdateOrganizerService updateOrganizerService = new UpdateOrganizerService();
    	updateOrganizerService.update(request, this);
    	response.sendRedirect("myOrganizers");
	}
}