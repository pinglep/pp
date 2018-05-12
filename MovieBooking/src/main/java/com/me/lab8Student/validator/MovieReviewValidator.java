package com.me.lab8Student.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.me.lab8Student.pojo.Booking;
import com.me.lab8Student.pojo.MovieReviews;

public class MovieReviewValidator  implements Validator{

	@Override
	public boolean supports(Class aClass) {
		// TODO Auto-generated method stub
		return aClass.equals(MovieReviews.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reviews", "error.invalid.reviews", "Please write some reviews");		

	}

}
