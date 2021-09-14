package org.zerock.jex01.security.config;

import lombok.extern.log4j.Log4j2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.zerock.jex01.security.hendler.CustomLoginSuccessHandler;
import org.zerock.jex01.security.service.CustomUserDetailsService;

import javax.sql.DataSource;

@Configuration   //애는 설정파일이야 라고하는거
@EnableWebSecurity
@Log4j2
@MapperScan(basePackages = "org.zerock.jex01.security.mapper")
@ComponentScan(basePackages = "org.zerock.jex01.security.service")//3
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomUserDetailsService customUserDetailsService;//4

    @Autowired
    private DataSource dataSource;

    @Bean
    public PasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder();//패스워드 인코딩을 해줬다(복잡하게 만들어줬다)
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.authorizeRequests()
                .antMatchers("/sample/doAll").permitAll()
                .antMatchers("/sample/doMember").access("hasRole('ROLE_MEMBER')")
                .antMatchers("/sample/doAdmin").access("hasRole('ROLE_ADMIN')");

        http.formLogin().loginPage("/customLogin")//로그인 페이지는 커스텀 방식으로 띄우는데 로그인은 스프링 시큐리티가 알아서 해준다
                .loginProcessingUrl("/login");//post방식으로 실제로 url을 처리하는거
//                .successHandler(customLoginSuccessHandler());//인증이 성공하면 이렇게 ㄴㅏ오게 하는거
//        http.logout().invalidateHttpSession(true);//야 로그아웃하면 세션무효, 기본값으로 디폴트있어서 안해줘도 된다


        http.csrf().disable();//disable을 하면 따로 로그아웃을 만들어줄 필요가 없다.

        http.rememberMe().tokenRepository(persistentTokenRepository())
                .key("zerock").tokenValiditySeconds(60*60*24*30);//한달짜리

    }

    @Bean
    public CustomLoginSuccessHandler customLoginSuccessHandler() {

        return new CustomLoginSuccessHandler();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.userDetailsService(customUserDetailsService);//6

//        auth.userDetailsService(customUserDetailsService());//지정하는거 얘를 통해서 로그인 프로세스가 진행한다는것//5

//        auth.inMemoryAuthentication().withUser("member1").password("$2a$10$YJZ7KZf28trrhJWZixOL8O6uCYGLsjPYXYagem/4DQvIqiaerJKBy")
//                .roles("MEMBER");
//        auth.inMemoryAuthentication().withUser("admin1").password("$2a$10$YJZ7KZf28trrhJWZixOL8O6uCYGLsjPYXYagem/4DQvIqiaerJKBy")
//                .roles("MEMBER","ADMIN");//한사용자가 둘다 들어갈수있다 (관리자)
    }

//    @Bean
//    public CustomUserDetailsService customUserDetailsService() {
//        return new CustomUserDetailsService();//2
//    }
    @Bean
    public PersistentTokenRepository persistentTokenRepository(){
        JdbcTokenRepositoryImpl repository = new JdbcTokenRepositoryImpl();
        repository.setDataSource(dataSource);
        return repository;
    }
}
