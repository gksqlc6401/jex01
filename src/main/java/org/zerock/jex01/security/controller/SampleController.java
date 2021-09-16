package org.zerock.jex01.security.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequestMapping("/sample")
public class SampleController {

    @GetMapping("/doAll")
    public void doAll() {
        log.warn("doAll..........................");
    }

    @PreAuthorize("isAuthenticated()")// 요청이 들어와 함수를 실행하기 전에 권한을 검사하는 어노테이션, 로그아웃 하기전에 로그인이 되있는지 확인하는거 같다.그 CommonExceptionAdvice로 간다 23
    @GetMapping("/doMember")
    public void doMember() {
        log.warn("doMember..........................");
    }
    @PreAuthorize("hasRole('ROLE_ADMIN')")//""은 에러나서 ''싱글로 줬음 여기서 서버실행하면 정상적으로 되야한다 25
    @GetMapping("/doAdmin")
    public void doAdmin() {
        log.warn("doAdmin..........................");
    }

}
