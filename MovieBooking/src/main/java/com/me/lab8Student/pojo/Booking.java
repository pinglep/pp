package com.me.lab8Student.pojo;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="booking_table")
public class Booking {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="bookingId", unique = true, nullable = false)
    private long bookingId;

	
	@Column(name = "loaction")
	private String location;
	
	@Column(name = "movie")
	private String movie;
	
	@Column(name = "movieTime")
	private String movieTime;
	
	@Column(name = "date")
	private String date;
	
	@Column(name = "noOfSits")
	private String noOfSits;
	
	@Column(name = "creditCardNo")
	private String creditCardNo;
	
	@Column(name = "bookedBy")
	private String bookedBy;
	
	@Transient
	int postedBy;
	
	@OneToOne
	@PrimaryKeyJoinColumn
	private Advert advert;
	
	@Column(name = "selecetdSits")
	private String selecetdSits;
	
	public Booking() {
		
	}

	public long getBookingId() {
		return bookingId;
	}

	public void setBookingId(long bookingId) {
		this.bookingId = bookingId;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getMovie() {
		return movie;
	}

	public void setMovie(String movie) {
		this.movie = movie;
	}

	public String getMovieTime() {
		return movieTime;
	}

	public void setMovieTime(String movieTime) {
		this.movieTime = movieTime;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getNoOfSits() {
		return noOfSits;
	}

	public void setNoOfSits(String noOfSits) {
		this.noOfSits = noOfSits;
	}

	public String getCreditCardNo() {
		return creditCardNo;
	}

	public void setCreditCardNo(String creditCardNo) {
		this.creditCardNo = creditCardNo;
	}

	public int getPostedBy() {
		return postedBy;
	}

	public void setPostedBy(int postedBy) {
		this.postedBy = postedBy;
	}

	public Advert getAdvert() {
		return advert;
	}

	public void setAdvert(Advert advert) {
		this.advert = advert;
	}

	public String getSelecetdSits() {
		return selecetdSits;
	}

	public void setSelecetdSits(String selecetdSits) {
		this.selecetdSits = selecetdSits;
	}

	public String getBookedBy() {
		return bookedBy;
	}

	public void setBookedBy(String bookedBy) {
		this.bookedBy = bookedBy;
	}
	
	
	
}
