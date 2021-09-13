package org.zerock.jex01.board.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.zerock.jex01.common.config.RootConfig;

@Configuration
@MapperScan(basePackages = "org.zerock.jex01.board.mapper")
@ComponentScan(basePackages = "org.zerock.jex01.board.service")
@Import(BoardAOPConfig.class)//얘를 물고 와라 원래는 별도의 설정파일 필요
public class BoardRootConfig {
}
