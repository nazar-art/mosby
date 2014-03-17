package main.java.com.mosby.view.web.servlets.eventManagment;

import main.java.com.mosby.controller.services.ReadGenericObjectService;
import main.java.com.mosby.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editTicketsPromoCodes")
public class EditTicketsPromoCodesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("eventId") != null) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            Event event = new ReadGenericObjectService<Event>((Class<Event>) new Event().getClass()).readById(eventId);
            request.setAttribute("event", event);
            request.getRequestDispatcher("/pages/eventManagement/editTicketsPromoCodes.jsp").forward(request, response);
        } else {
            response.sendRedirect("index");
        }
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
    }

}
