

package com.jason.framework.util.valuelist;

import java.util.Locale;

import org.springframework.context.MessageSource;

/**
 * @Creat date:Jul 26, 2011 8:50:51 AM
 * @Author:Jason Zhang
 */
public class DisplayValue {
	String key;
	String valueKey;
	String defaultValue;
	MessageSource messageSource;

	/**
	 */
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	/**
	 */
	public String getKey() {
		return key;
	}

	/**
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 */
	public String getValueKey() {
		return valueKey;
	}

	/**
	 */
	public void setValueKey(String value) {
		this.valueKey = value;
	}

	/**
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/**
	 */
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getValueText() {
		if (messageSource != null)
			return messageSource.getMessage(valueKey, new Object[] {},
					defaultValue, Locale.getDefault());
		else
			return defaultValue;
	}
}
