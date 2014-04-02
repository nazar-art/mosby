package main.java.com.mosby.controller.services;

import main.java.com.mosby.controller.dao.ReflectionDao;
import main.java.com.mosby.model.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

public class TicketsService {
	
	@SuppressWarnings("unchecked")
	public void register(HttpServletRequest request){
		ReflectionDao<Ticket> ticketDao = new ReflectionDao<>(Ticket.class);
		ReflectionDao<User> userDao = new ReflectionDao<>(User.class);
		int eventId = Integer.parseInt(request.getParameter("eventId"));
		Date timeOfPurchase = new Date();
		PromoCode promoCode = null;
		String enteredPromoCode = request.getParameter("promo_code"); 
		List <PromoCode> promoCodesList = new ReadGenericObjectService<>(PromoCode.class).readListByField("event_ref", eventId);
        for (PromoCode code : promoCodesList) {
			if (code.getCode().equals(enteredPromoCode)){
				promoCode = code;
			}
		}
        User user = (User) request.getSession(false).getAttribute("user");
        Event event = new ReadGenericObjectService<>(Event.class).readById(eventId);
        
        List <TicketInfo> ticketsInfoList = new ReadGenericObjectService<>(TicketInfo.class).readListByField("event_ref", eventId);
        for (TicketInfo ticketInfo : ticketsInfoList) {
        	int ticketInfoId = ticketInfo.getId();
        	if (request.getParameter("ticket_quantity_" + ticketInfoId) != null){
        		int ticketQuantity = Integer.parseInt(request.getParameter("ticket_quantity_" + ticketInfoId));
        		for (int i = 0; i < ticketQuantity; i++){
        			Ticket ticket = new Ticket(ticketInfo, timeOfPurchase, promoCode, false, user, event);
                    int discount;
                    if (promoCode == null){
                        discount = 0;
                    }
                    else{
                        discount = promoCode.getDiscount();
                    }
                    double priceOfTicket = ticketInfo.getPrice()-(ticketInfo.getPrice() * discount * 0.01);
                    if (user.getCredits()>=priceOfTicket){
                        ticketDao.insertObjects(ticket);
                        user.setCredits(user.getCredits()-priceOfTicket);
                        userDao.updateObjects(user);
                        request.getSession().setAttribute("user", user);
                    }
        		}
        	}
		}
	}
	
	public void check(HttpServletRequest request){
		ReflectionDao<Ticket> ticketDao = new ReflectionDao<>(Ticket.class);
		String[] tickets = request.getParameterValues("checked_tickets");
		for (String string : tickets) {
			Ticket ticket = new ReadGenericObjectService<>(Ticket.class).readById(Integer.parseInt(string));
			ticket.setChecked(true);
			ticketDao.updateObjects(ticket);
		}
	}
	
	public void delete(HttpServletRequest request){
		ReflectionDao<Ticket> ticketDao = new ReflectionDao<>(Ticket.class);
		ReflectionDao<User> userDao = new ReflectionDao<>(User.class);
		String[] tickets = request.getParameterValues("checked_tickets");
		for (String string : tickets) {
			Ticket ticket = new ReadGenericObjectService<>(Ticket.class).readById(Integer.parseInt(string));
			double priceOfTicket = ticket.getTicketInfo().getPrice()-(ticket.getTicketInfo().getPrice() * ticket.getPromoCode().getDiscount() * 0.01);
			ticket.getUser().setCredits(ticket.getUser().getCredits() + priceOfTicket);
			userDao.updateObjects(ticket.getUser());
			if (ticket.getUser().getId() == ((User) request.getSession(false).getAttribute("user")).getId()){
				request.getSession(false).setAttribute("user", ticket.getUser());
			}
			ticketDao.deleteObjects(ticket);
		}
	}
	
	public void delete (HttpServletRequest request, int id){
		Ticket ticket = new ReadGenericObjectService<>(Ticket.class).readById(id);
		double priceOfTicket = ticket.getTicketInfo().getPrice()-(ticket.getTicketInfo().getPrice() * ticket.getPromoCode().getDiscount() * 0.01);
		ticket.getUser().setCredits(ticket.getUser().getCredits() + priceOfTicket);
		new ReflectionDao<>(User.class).updateObjects(ticket.getUser());
		if (ticket.getUser().getId() == ((User) request.getSession(false).getAttribute("user")).getId()){
			request.getSession(false).setAttribute("user", ticket.getUser());
		}
		new ReflectionDao<>(Ticket.class).deleteObjects(ticket);
	}
	
	public void save(HttpServletRequest request){
		
	}
	
}
