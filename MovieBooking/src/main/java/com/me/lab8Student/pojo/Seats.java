package com.me.lab8Student.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="seats_table")
public class Seats {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="seatsId", unique = true, nullable = false)
    private long seatsId;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id", nullable = false)
    private Advert advert;
	
	public Seats() {
		 
	}

	public long getSeatsId() {
		return seatsId;
	}

	public void setSeatsId(long seatsId) {
		this.seatsId = seatsId;
	}

	public Advert getAdvert() {
		return advert;
	}

	public void setAdvert(Advert advert) {
		this.advert = advert;
	}
	
	
}
