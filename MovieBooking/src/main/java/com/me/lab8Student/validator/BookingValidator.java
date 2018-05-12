package com.me.lab8Student.validator;

import javax.persistence.Column;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.User;

public class BookingValidator implements Validator{

	@Override
	public boolean supports(Class aClass) {
		// TODO Auto-generated method stub
		return aClass.equals(Booking.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "location", "error.invalid.location", "Please Select Location");		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "movieTime", "error.invalid.movieTime", "Please Select movieTime");

	}

}
