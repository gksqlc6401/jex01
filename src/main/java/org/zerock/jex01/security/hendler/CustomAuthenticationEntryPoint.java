package org.zerock.jex01.security.hendler;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j2
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {//0916/1 클래스 만들어서

    @Override
    public void commence(HttpServletRequest req, HttpServletResponse res, AuthenticationException authException) throws IOException, ServletException {

        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error(authException);
        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error("------------------CustomAuthenticationEntryPoint-----------------");

        if(req.getContentType() != null && req.getContentType().contains("json")){//0916/2 변경했다 -> sercurityConfig로 가자
            res.setContentType("application/json;charset=UTF-8");
            res.setStatus(403);
            res.getWriter().write("{\'msg\':\'REST API ERROR\'}");
        }else {

            res.sendRedirect("/customLogin?erzzzzzzs");//너는 지금 권한이없어, 로그인해야해 라고 나중에 커스터마이징 하면됨.
        }



    }
}