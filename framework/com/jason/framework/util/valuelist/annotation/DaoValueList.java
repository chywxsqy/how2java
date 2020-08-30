

package com.jason.framework.util.valuelist.annotation;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface DaoValueList {
	String name();

	String dao();

	String method();

	String key();

	String value();
}
