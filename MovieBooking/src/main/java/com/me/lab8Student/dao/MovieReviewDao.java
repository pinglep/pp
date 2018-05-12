package com.me.lab8Student.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;

import com.me.lab8Student.exception.AdvertException;
import com.me.lab8Student.exception.UserException;
import com.me.lab8Student.pojo.Advert;
import com.me.lab8Student.pojo.MovieReviews;
import com.me.lab8Student.pojo.User;

public class MovieReviewDao extends DAO{
	

	public MovieReviews addMovieReviews(MovieReviews m) throws UserException  {
		// TODO Auto-generated method stub
		try {
			begin();
			
			MovieReviews movieObj = new MovieReviews();
//			
			movieObj.setMovie(m.getMovie());
			movieObj.setReviewId(m.getReviewId());
			movieObj.setReviews(m.getReviews());
			movieObj.setPostedBy(m.getPostedBy());
			movieObj.setRatings(m.getRatings());
			getSession().save(movieObj);
			commit();
			return movieObj;

		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while creating user: " + e.getMessage());
		}
	}
	
	public List<MovieReviews> list() throws AdvertException {

		try {
			begin();
			Query q = getSession().createQuery("from MovieReviews");
			List<MovieReviews> mr = q.list();
			commit();
			return mr;
		} catch (HibernateException e) {
			rollback();
			throw new AdvertException("Could not delete advert", e);
		}

	}
	
	
	public void deleteReview(int id) throws AdvertException {

		try {
			begin();
			Query q = getSession().createQuery("delete MovieReviews where reviewId = :id");
			q.setParameter("id", id);
			q.executeUpdate();
			commit();
			
		} catch (HibernateException e) {
			rollback();
			throw new AdvertException("Could not delete advert", e);
		}

	}
	

}
