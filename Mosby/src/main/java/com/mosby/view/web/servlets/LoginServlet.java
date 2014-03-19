package main.java.com.mosby.view.web.servlets;

import main.java.com.mosby.controller.services.ReadUsersService;
import main.java.com.mosby.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		String appId = "601170126631442";
        String redirectUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/Mosby/socialSignUp";
     //String redirectUrl = "http://localhost:8080/Mosby/socialSignUp";
		String returnValue = "https://www.facebook.com/dialog/oauth?client_id="
				+ appId + "&redirect_uri=" + redirectUrl
				+ "&scope=email,user_birthday&state=" + sessionId;

		request.setAttribute("facebookURL", returnValue);
		request.getRequestDispatcher("/pages/login.jsp").forward(request,
				response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		ReadUsersService readUsersService = new ReadUsersService();

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		User user = readUsersService.readUser(email, password);

		if (user == null || !user.isActive()) {

			List<String> errors = new ArrayList<>();
			errors.add("Please enter correct field");
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/pages/login.jsp").forward(request,
					response);
		} else {

			HttpSession session = request.getSession(false);
			session.setAttribute("user", user);
			session.setAttribute("userType", "common");

			if (session.getAttribute("waitUrl") != null) {
				String url = session.getAttribute("waitUrl").toString();
				response.sendRedirect(url);
			} else {
				response.sendRedirect("index");
			}
		}
	}
}
