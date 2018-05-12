package com.me.lab8Student.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.me.lab8Student.dao.AdvertDAO;
import com.me.lab8Student.dao.BookingDao;
import com.me.lab8Student.dao.UserDAO;
import com.me.lab8Student.exception.AdvertException;
import com.me.lab8Student.exception.BookingException;
import com.me.lab8Student.exception.UserException;
import com.me.lab8Student.pojo.Advert;
import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.User;
import com.me.lab8Student.validator.BookingValidator;
import com.me.lab8Student.validator.UserValidator;

@Controller
@RequestMapping("/user/*")
public class UserController {
	String LoginAction  = "";
	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;
	
	@Autowired
	@Qualifier("advertDao")
	AdvertDAO advertDao;
	
	
	
	@Autowired
	@Qualifier("userValidator")
	UserValidator validator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
		//binder.setValidator(bookingValidator);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	protected String goToUserHome(HttpServletRequest request) throws Exception {
		
		return "user-home";
	}

	@RequestMapping(value = "/user/logout", method = RequestMethod.GET)
	protected String logout(HttpServletRequest request) throws Exception {
		
		return "index";
	}
	
	
	
	@RequestMapping(value = "/user/login", method = RequestMethod.POST)
	public ModelAndView loginUser(HttpServletRequest request, HttpServletRequest response) throws IOException, AdvertException {
		
		HttpSession session = (HttpSession) request.getSession();
		//LoginAction = request.getParameter("action");
		
		try {
		
				System.out.print("loginUser");

				User u = userDao.get(request.getParameter("username"), request.getParameter("password"));

				if (u == null) {
					System.out.println("UserName/Password does not exist");
					session.setAttribute("errorMessage", "UserName/Password does not exist");
					return new ModelAndView("error");
				}
				List<Advert> adverts = advertDao.list();
				session.setAttribute("user", u);

				if (u.getUsername().equals("admin") && u.getPassword().equals("admin")) {

					return new ModelAndView("user-home", "adverts", adverts);
				} else {
					
					

					request.getSession().setAttribute("user", u);
					request.getSession().setAttribute("adverts", adverts);
					return new ModelAndView("customerPage", "adverts", adverts);
				}
		        
		    

			
		} catch (UserException e) {
			System.out.println("Exception: " + e.getMessage());
			session.setAttribute("errorMessage", "error while login");
			return new ModelAndView("error");
		}
		

	}
	
	@RequestMapping(value = "/user/bookMovie", method = RequestMethod.GET)
	public ModelAndView custBookingSelected(HttpServletRequest request, HttpServletRequest response) throws IOException, AdvertException {
		String action  = null;
		HttpSession session = (HttpSession) request.getSession();
		
		try {

			System.out.print("loginUser");

				List<Advert> adverts = advertDao.list();
				
				
				request.getSession().setAttribute("adverts", adverts);
				return new ModelAndView("NewFile", "adverts", adverts);
			
			
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			session.setAttribute("errorMessage", "error while login");
			return new ModelAndView("error");
		}
		
		

	}
	
	
	
	@RequestMapping(value = "/user/reviewMovie", method = RequestMethod.GET)
	public ModelAndView reviewMovie(HttpServletRequest request, HttpServletRequest response) throws IOException, AdvertException {
		String action  = null;
		HttpSession session = (HttpSession) request.getSession();
		
		try {


				List<Advert> adverts = advertDao.list();
				
				
				request.getSession().setAttribute("adverts", adverts);
				return new ModelAndView("reviewMovie", "adverts", adverts);
			
			
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			session.setAttribute("errorMessage", "error while login");
			return new ModelAndView("error");
		}
		
		

	}
	
	@RequestMapping(value = "/user/register", method = RequestMethod.GET)
	protected ModelAndView registerUser() throws Exception {
		System.out.print("registerUser");

		return new ModelAndView("register-user", "user", new User());

	}

	@RequestMapping(value = "/user/register", method = RequestMethod.POST)
	protected ModelAndView registerNewUser(HttpServletRequest request, @ModelAttribute("user") User user,
			BindingResult result) throws Exception {

		validator.validate(user, result);

		if (result.hasErrors()) {
			return new ModelAndView("register-user", "user", user);
		}

		try {

			User u = userDao.register(user);
			
  
			List<Advert> adverts = advertDao.list();
			

			request.getSession().setAttribute("user", u);
			request.getSession().setAttribute("adverts", adverts);
			return new ModelAndView("NewFile", "adverts", adverts);
			//return new ModelAndView("cust");

		} catch (UserException e) {
			System.out.println("Exception: " + e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}
	}

	
}
