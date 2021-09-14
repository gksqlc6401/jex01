package org.zerock.jex01.security.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.zerock.jex01.security.domain.Member;
import org.zerock.jex01.security.mapper.MemberMapper;

import java.util.stream.Collectors;

@RequiredArgsConstructor
@Log4j2
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {//사용자가 없다면 예외처리
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn(username);//사용자가 있는지 없는지 확인 사용자가 없을수도 패스워드가 틀릴수도 있어서 저기 위에 보면 익셉션 던졌음
        log.warn(memberMapper);//주입이 됬는지 확인하려고
        log.warn("CustomUserDetailsService-----------------------------------------");
        log.warn("CustomUserDetailsService-----------------------------------------");

        Member member = memberMapper.findByMid(username);//7 멤버 가져왔음

        log.warn(member);//12 이제야 진짜 로그인이 되는거다, 서버 실행하고 ex)id는 admin5 pw는pw5 하면 로그인 된다.
                                                                  //ex)id는 user5  pw는pw5 하면 로그인 된다.

        if(member==null){// 멥버가 없다면
            throw new UsernameNotFoundException("NOT EXIST");//8예외처리
        }

        String[] authorities = member.getRoleList().stream().map(memberRole -> memberRole.getRole()).toArray(String[]::new);
        //10 맴버를 가지고 오는데 두개이상이니까 배열로 가지고온다

        User result = (User) User.builder()//다운 캐스팅
                .username(username)//username은 이걸로 할거고
                .password(member.getMpw())//9 비밀번호도 이걸로,인코딩된 패스워드로적어야 한다
                .accountExpired(false)//만료된 계정인지?
                .accountLocked(false)//권한 막아주는 잠금장치??
                .authorities(authorities)//11 이계정의 권한은 뭐야?
                .build();

        return  result;//리턴이 null이면 무조건 로그인 불가
    }
}
