package com.me.lab8Student.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;

import com.me.lab8Student.exception.UserException;
import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.Email;
import com.me.lab8Student.pojo.MovieReviews;
import com.me.lab8Student.pojo.User;

public class BookingDao extends DAO{

	
	public List<Booking> get(String movie) throws UserException {
		try {
			begin();
			Query q = getSession().createQuery("from Booking where movie = :movie");
			q.setString("movie", movie);	
			List<Booking> booking = q.list();
			commit();
			return booking;
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Could not get user " + movie, e);
		}
	}

	public Booking bookingMovie(Booking booking) throws UserException  {
		// TODO Auto-generated method stub
		try {
			begin();
			System.out.println("inside DAO");
			
			Booking bookingObj = new Booking();
			bookingObj.setMovieTime(booking.getMovieTime());
			bookingObj.setLocation(booking.getLocation());
			bookingObj.setDate(booking.getDate());
			bookingObj.setNoOfSits(booking.getNoOfSits());
			bookingObj.setMovie(booking.getMovie());
			bookingObj.setSelecetdSits(booking.getSelecetdSits());
			bookingObj.setBookedBy(booking.getBookedBy());
			getSession().save(bookingObj);
			commit();
			return bookingObj;

		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while creating user: " + e.getMessage());
		}
	}
	
}
