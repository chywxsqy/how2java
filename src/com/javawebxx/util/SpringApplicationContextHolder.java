package com.javawebxx.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.jason.framework.util.StringUtil;


public class SpringApplicationContextHolder implements ApplicationContextAware {
	private static ApplicationContext context;

	@Override
	public void setApplicationContext(ApplicationContext context)
			throws BeansException {
		SpringApplicationContextHolder.context = context;
	}

	
	public static Object getSpringBean(String beanName) {
		if(StringUtil.isNotBlank(beanName)){
			return context.getBean(beanName);
		}else{
			return null;
		}
	}

	public static String[] getBeanDefinitionNames() {
		return context.getBeanDefinitionNames();
	}

}
