package org.zerock.jex01.board.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@Configuration
@EnableAspectJAutoProxy//자동으로 해주는 친구,aspect는 냄새없는 포장하고 싶은 추상적인 느끰
@ComponentScan("org.zerock.jex01.board.aop")
public class BoardAOPConfig {

}
