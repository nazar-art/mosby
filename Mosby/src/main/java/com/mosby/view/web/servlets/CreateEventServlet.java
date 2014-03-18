package main.java.com.mosby.view.web.servlets;

import main.java.com.mosby.controller.services.CreateEventService;
import main.java.com.mosby.controller.services.ReadGenericObjectService;
import main.java.com.mosby.model.Event;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/createEvent")
@MultipartConfig
public class CreateEventServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static Logger log = Logger.getLogger(CreateEventServlet.class);

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/createEvent.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int eventId = new CreateEventService().create(request, this);
            Event event = new ReadGenericObjectService<Event>((Class<Event>) new Event().getClass()).readById(eventId);
            request.setAttribute("event", event);
            response.sendRedirect("/Mosby/eventPage?eventId=" + event.getId());
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e);
        }
    }
}