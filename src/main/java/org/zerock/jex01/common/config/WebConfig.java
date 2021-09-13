package org.zerock.jex01.common.config;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import org.zerock.jex01.board.config.BoardRootConfig;
import org.zerock.jex01.board.config.BoardServletConfig;
import org.zerock.jex01.security.config.SecurityConfig;
import org.zerock.jex01.security.config.SecurityServletConfig;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;

@Log4j2
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {

        log.info("1----------------------------");
        log.info("1----------------------------");

        return new Class[]{RootConfig.class, SecurityConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {

        log.info("2----------------------------");
        log.info("2----------------------------");

        return new Class[]{ServletConfig.class, SecurityServletConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter uft8Filter = new CharacterEncodingFilter();
        uft8Filter.setEncoding("UTF-8");
        uft8Filter.setForceEncoding(true);

        return new Filter[]{uft8Filter};
    }

    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {

        registration.setInitParameter("throwExceptionIfNoHandlerFound","true");

        MultipartConfigElement multipartConfig
                = new MultipartConfigElement("C:\\upload\\temp",1024*1024*10, 1024*1024*20, 1024*1024*1);

                registration.setMultipartConfig(multipartConfig);

    }

}
