package com.example;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class ExampleApplication {
	@Value("${app.test-property}")
	String testProperty = "";

	public static void main(String[] args) {
		SpringApplication.run(ExampleApplication.class, args);
	}

	@EventListener
	public void contextStarted(ContextRefreshedEvent event)
	{
		System.out.println("Value of the test property is: '" + testProperty + "'");
	}
}
