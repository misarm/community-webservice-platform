package com.kdev.app.exception.notacceptable;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_ACCEPTABLE, reason="This email is duplicated")
public class EmailDuplicatedException extends RuntimeException {
	private static final long serialVersionUID = 1L;
}