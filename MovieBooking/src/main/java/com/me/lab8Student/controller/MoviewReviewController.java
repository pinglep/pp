package com.me.lab8Student.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.me.lab8Student.dao.BookingDao;
import com.me.lab8Student.dao.MovieReviewDao;
import com.me.lab8Student.exception.AdvertException;
import com.me.lab8Student.pojo.Advert;
import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.MovieReviews;
import com.me.lab8Student.validator.BookingValidator;
import com.me.lab8Student.validator.MovieReviewValidator;

@Controller
@RequestMapping("/review/*")
public class MoviewReviewController {

	@Autowired
	@Qualifier("movieDao")
	MovieReviewDao movieDao;

	@Autowired
	@Qualifier("movieReviewValidator")
	MovieReviewValidator movieReviewValidator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {

		binder.setValidator(movieReviewValidator);
	}

	@RequestMapping(value = "/review/addComments", method = RequestMethod.POST)
	protected ModelAndView addmovieReviews(HttpServletRequest request, MovieReviews movieReviews, BindingResult result)
			throws Exception {
		String movieName = request.getParameter("movie");
		String userTextField = request.getParameter("bookedBy");

		String ratings = request.getParameter("rating");
		int ratingNum = Integer.valueOf(ratings);
		System.out.println("ratings" + ratingNum);
		Advert a = new Advert();
		a.setTitle(movieName);
		movieReviews.setMovie(movieName);
		movieReviews.setPostedBy(userTextField);
		movieReviews.setRatings(ratingNum);

		MovieReviews m = movieDao.addMovieReviews(movieReviews);

		request.getSession().setAttribute("movieReviews", m);
		return new ModelAndView("reviewSuccessPage", "booking", m);

	}

	@RequestMapping(value = "/review/viewAllReviews", method = RequestMethod.GET)
	public ModelAndView viewAllReviews(HttpServletRequest request) throws Exception {
		HttpSession session = (HttpSession) request.getSession();
		try {

			List<MovieReviews> mr = movieDao.list();

			return new ModelAndView("viewAllReviews", "mr", mr);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}

	@RequestMapping(value = "/review/removeReview", method = RequestMethod.GET)
	protected ModelAndView removeReview(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		int idInt = Integer.parseInt(id);
		movieDao.deleteReview(idInt);
		List<MovieReviews> mr = movieDao.list();

		return new ModelAndView("viewAllReviews", "mr", mr);

	}

}
