package com.me.lab8Student.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="movie_reviews")
public class MovieReviews {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="reviewId", unique = true, nullable = false)
    private int reviewId;
	
	
	@Column(name="movie")
    private String movie;
	
	@Column(name="reviews")
    private String reviews;
	
	
	@Column(name="postedBy")
    private String postedBy;
	
	@Column(name="ratings")
    private int ratings;
	
	private String disabledFirst;
	private String disabledSecond;
	private String disabledThird;
	private String disabledForth;
	private String disabledFifth;
	
	public MovieReviews() {
		
	}

	public String getReviews() {
		return reviews;
	}


	public void setReviews(String reviews) {
		this.reviews = reviews;
	}


	public String getMovie() {
		return movie;
	}


	public void setMovie(String movie) {
		this.movie = movie;
	}


	public String getPostedBy() {
		return postedBy;
	}


	public void setPostedBy(String postedBy) {
		this.postedBy = postedBy;
	}


	public int getRatings() {
		return ratings;
	}


	public void setRatings(int ratings) {
		this.ratings = ratings;
	}


	public String getDisabledFirst() {
		return disabledFirst;
	}


	public void setDisabledFirst(String disabledFirst) {
		this.disabledFirst = disabledFirst;
	}


	public String getDisabledSecond() {
		return disabledSecond;
	}


	public void setDisabledSecond(String disabledSecond) {
		this.disabledSecond = disabledSecond;
	}


	public String getDisabledThird() {
		return disabledThird;
	}


	public void setDisabledThird(String disabledThird) {
		this.disabledThird = disabledThird;
	}


	public String getDisabledForth() {
		return disabledForth;
	}


	public void setDisabledForth(String disabledForth) {
		this.disabledForth = disabledForth;
	}


	public String getDisabledFifth() {
		return disabledFifth;
	}


	public void setDisabledFifth(String disabledFifth) {
		this.disabledFifth = disabledFifth;
	}

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}


	
	
}
