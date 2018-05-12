package com.me.lab8Student.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.me.lab8Student.dao.AdvertDAO;
import com.me.lab8Student.dao.BookingDao;
import com.me.lab8Student.dao.CategoryDAO;
import com.me.lab8Student.dao.UserDAO;
import com.me.lab8Student.exception.AdvertException;
import com.me.lab8Student.pojo.Advert;
import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.Category;
import com.me.lab8Student.pojo.User;

@Controller
@RequestMapping("/advert/*")
public class AdvertController {
	@Autowired
	@Qualifier("advertDao")
	AdvertDAO advertDao;

	@Autowired
	@Qualifier("categoryDao")
	CategoryDAO categoryDAO;

	@Autowired
	@Qualifier("bookingDao")
	BookingDao bookingDao;

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	@RequestMapping(value = "/advert/add", method = RequestMethod.POST)
	public ModelAndView addCategory(@ModelAttribute("advert") Advert advert, BindingResult result) throws Exception {

		try {

			User u = userDao.get(advert.getPostedBy());
			advert.setUser(u);
			advert.setDate(advert.getDate());
			advert.setTime(advert.getTime());
			advert.setPrice(advert.getPrice());
			advert.setImgSrc(advert.getImgSrc());
			advert = advertDao.create(advert);

			for (Category c : advert.getCategories()) {
				c = categoryDAO.get(c.getTitle());
				c.getAdverts().add(advert);
				categoryDAO.update(c);
			}

			return new ModelAndView("advert-success", "advert", advert);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}

	@RequestMapping(value = "/advert/list", method = RequestMethod.GET)
	public ModelAndView addCategory(HttpServletRequest request) throws Exception {

		try {

			List<Advert> adverts = advertDao.list();
			return new ModelAndView("advert-list", "adverts", adverts);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}
	

	@RequestMapping(value = "/advert/search", method = RequestMethod.POST)
	public ModelAndView searchMovie(HttpServletRequest request) throws Exception {

		try {
			String userTextField = request.getParameter("userTextName");
			request.getSession().setAttribute("userTextField", userTextField);
			

			String action = request.getParameter("keywordvalue");
			
			System.out.println("vdknvdvvdvsKERY DVI" + action);

			List<Advert> advert = advertDao.list();
			
			advert = advertDao.getMovie(action);
			List<String> newlISTnew = new ArrayList();
			List<String> newSeatsList = new ArrayList();
			String[] arrOfStr = null;
			if(advert.size() != 0) {

				for (int i = 0; i <= advert.size(); i++) {

					String str = advert.get(0).getTime();
					arrOfStr = str.split(",", -2);

				}
			}else {
				return new ModelAndView("NomovieAvailable");
			}
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mList", advert);
			map.put("msgtype", "search");
			map.put("querySearched", action);

			for (String a : arrOfStr) {
				System.out.println(a + "Time");
				newlISTnew.add(a);
				map.put("newlISTnew", newlISTnew);
			}

			List<Booking> b = bookingDao.get(advert.get(0).getTitle());
			if (b != null) {
			String[] arrOfSits = null;
			
				for (int i = 0; i <= b.size(); i++) {
					String str = b.get(0).getSelecetdSits();
					arrOfSits = str.split(",", -2);
				}
			
			String num = "";
			for (String a : arrOfSits) {
				num = (a);
				newSeatsList.add(num);
				map.put("newSeatsList", newSeatsList);
				String disabled = "true";
			}
			}
			
			if (b == null) {
				return new ModelAndView("searchResult", "map", map);
			}

			return new ModelAndView("searchResult", "map", map);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}

	
	@RequestMapping(value = "/advert/searchForReview", method = RequestMethod.POST)
	public ModelAndView searchMovieForReview(HttpServletRequest request) throws Exception {

		try {
			String userTextField = request.getParameter("userTextName");
			request.getSession().setAttribute("userTextField", userTextField);

			String action = request.getParameter("keywordvalue");

			List<Advert> advert = advertDao.list();
			advert = advertDao.getMovie(action);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mList", advert);
			map.put("msgtype", "search");
			map.put("querySearched", action);


			return new ModelAndView("searchForMovieReview", "map", map);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}
	@RequestMapping(value = "/advert/add", method = RequestMethod.GET)
	public ModelAndView initializeForm(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("categories", categoryDAO.list());
		mv.addObject("advert", new Advert());
		mv.setViewName("advert-form");
		return mv;
	}

//	@RequestMapping(value = "/advert/update", method = RequestMethod.GET)
//	public ModelAndView updateMovie(HttpServletRequest request) throws Exception {
//		String id = request.getParameter("id");
//		System.out.println("sdhvidsdvokvv" + id);;
//		return null;
//	}
	
	@RequestMapping(value = "/advert/update", method = RequestMethod.GET)
	public ModelAndView updateMovie(HttpServletRequest request) throws Exception {


		try {
			
			String action = request.getParameter("id");
			System.out.println("dvjdksvndvvlvdsvnorwlfwf" + action);

			List<Advert> advert = advertDao.list();
			
			advert = advertDao.getMovie(action);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mList", advert);
			map.put("msgtype", "search");
			map.put("querySearched", action);

			
			
			return new ModelAndView("searchMovieForUpdate", "map", map);

		} catch (AdvertException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("error", "errorMessage", "error while login");
		}

	}
}
