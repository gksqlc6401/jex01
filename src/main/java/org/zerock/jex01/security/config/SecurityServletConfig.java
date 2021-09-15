package org.zerock.jex01.security.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

@Configuration
@ComponentScan(basePackages = "org.zerock.jex01.security.controller")
@EnableGlobalMethodSecurity(prePostEnabled = true)//SecurityConfig클래스로 가자 21
public class SecurityServletConfig {
}
