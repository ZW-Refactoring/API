package com.zero.common.exception;

public class NotUserException extends Exception{
	public NotUserException() {
		super("ȸ���� �ƴմϴ�. NotUserException");
	}
	public NotUserException(String msg) {
		super(msg);
	}
	
}
