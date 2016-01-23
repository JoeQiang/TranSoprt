package com.vanroid.transopt.interceptor;

import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;
import com.jfinal.validate.Validator;

public class UploadExcelValidate extends Validator {

	@Override
	protected void validate(Controller c) {
		UploadFile file = c.getFile();
	}

	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub

	}

}
