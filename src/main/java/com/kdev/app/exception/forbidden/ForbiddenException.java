package com.kdev.app.exception.forbidden;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.FORBIDDEN, reason="Request is Forbidden")
public class ForbiddenException extends RuntimeException {
	private static final long serialVersionUID = 1L;
}
