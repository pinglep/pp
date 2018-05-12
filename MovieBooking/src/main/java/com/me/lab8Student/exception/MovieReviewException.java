package com.me.lab8Student.exception;

public class MovieReviewException extends Exception {
	
	public MovieReviewException(String message)
	{
		super("MovieReviewException-"+message);
	}
	
	public MovieReviewException(String message, Throwable cause)
	{
		super("MovieReviewException-"+message,cause);
	}	


}
