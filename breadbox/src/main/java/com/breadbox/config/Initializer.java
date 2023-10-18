package com.breadbox.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class Initializer extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class<?>[] {};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class<?>[] {
			MvcConfig.class,
			SecuritySharedConfig.class,
			CustomerSecurityConfig.class
		};
	}

	@Override
	protected String[] getServletMappings() {
		// Dispatch Servlet Mapping
		return new String[] {"/"};
	}

}
