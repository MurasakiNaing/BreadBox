package com.breadbox.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class Initializer extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[] {
			RootConfig.class,
			SecurityConfig.class
			};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class<?>[] {
			MvcConfig.class
		};
	}

	@Override
	protected String[] getServletMappings() {
		// Dispatch Servlet Mapping
		return new String[] {"/"};
	}

}
