package org.zerock.jex01.security.service;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Log4j2
public class CustomUserDetailsService implements UserDetailsService {
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn(username);//사용자가 있는지 없는지 확인 사용자가 없을수도 패스워드가 틀릴수도 있어서 저기 위에 보면 익셉션 던졌음
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");

        User result = (User) User.builder()//다운 캐스팅
                .username(username)//username은 이걸로 할거고
                .password("$2a$10$YJZ7KZf28trrhJWZixOL8O6uCYGLsjPYXYagem/4DQvIqiaerJKBy")//비밀번호도 이걸로,인코딩된 패스워드로적어야 한다
                .accountExpired(false)//만료된 계정? 이라는 걸 뜻하는거같다
                .accountLocked(false)//권한 막아주는 잠금장치??
                .authorities("ROLE_MEMBER","ROLE_ADMIN")//이계정의 권한은 뭐야?
                .build();

        return  result;//리턴이 null이면 무조건 로그인 불가
    }
}
