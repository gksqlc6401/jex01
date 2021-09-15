package org.zerock.jex01.security.hendler;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j2
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

        log.warn("CustomLoginSuccessHandler...................");
        log.warn("CustomLoginSuccessHandler...................");
        log.warn(request.getHeader("Content-Type"));//에러 메세지를 보려고 한다 AccessDenied 발생했을 때 Json에서 발생한건지 확인하기 위해 추가
        log.warn("CustomLoginSuccessHandler...................");
        log.warn("CustomLoginSuccessHandler...................");//여기까지 하고 SecurityConfig 클래스로 가자 35
    }
}
