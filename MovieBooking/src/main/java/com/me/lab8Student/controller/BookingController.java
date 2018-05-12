package com.me.lab8Student.controller;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;
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

import com.me.lab8Student.dao.BookingDao;
import com.me.lab8Student.exception.UserException;
import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.MovieReviews;
import com.me.lab8Student.pojo.User;
import com.me.lab8Student.validator.BookingValidator;

@Controller
@RequestMapping("/book/*")
public class BookingController {

	@Autowired
	@Qualifier("bookingDao")
	BookingDao bookingDao;

	@Autowired
	@Qualifier("bookingValidator")
	BookingValidator bookingValidator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {

		binder.setValidator(bookingValidator);
	}

	@RequestMapping(value = "/book/booking", method = RequestMethod.POST)
	protected ModelAndView bookingMovie(HttpServletRequest request, Booking booking, BindingResult result)
			throws Exception {
		
		Booking b = bookingDao.bookingMovie(booking);

		request.getSession().setAttribute("booking", b);

		// request.getSession().setAttribute("booking", b);
		return new ModelAndView("booking_successPage", "booking", b);

	}
	
	
}
