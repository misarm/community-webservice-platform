package com.kdev.app.board.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.BAD_REQUEST, reason="Valid is failed")
public class ValidErrorException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	private String valid;

	public ValidErrorException(String valid) {
		this.valid = valid;
	}

	public String getValid() {
		return valid;
	}
}
