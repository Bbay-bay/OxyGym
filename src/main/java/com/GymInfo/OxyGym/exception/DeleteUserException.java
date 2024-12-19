package com.GymInfo.OxyGym.exception;

public class DeleteUserException extends RuntimeException{
	private static final long serialVersionUID=1L;
	public DeleteUserException(String message) {
        super(message);
    }
}