package org.zerock.jex01.board.security;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.jex01.board.config.BoardRootConfig;
import org.zerock.jex01.common.config.RootConfig;
import org.zerock.jex01.security.config.SecurityConfig;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {RootConfig.class, SecurityConfig.class})// 두 개다 로딩해줘야 에러가 안난다
public class PasswordTests {

    @Autowired
    PasswordEncoder passwordEncoder;

    @Test
    public void testEncode() {
        String str = "member1";
        String enStr = passwordEncoder.encode(str);//내 패스워드를 암호화 하는것
        log.warn(enStr);
    }

    @Test
    public void testDecode() {
        String str = "$2a$10$xQpvNP57N3D1xf72lWC.seubYBTdt.KnSK12z0Y6D.MI0v68/Rgge";

        boolean matches = passwordEncoder.matches("member1", str);//내password랑 암호화된문자열이랑 똑같은 거니? 라고 물어보느 테스트 코드

        log.warn(matches);
    }

    @Test
    public void insertMember() {
        //insert into tbl_member (mid, mpw, mname) values ('mid','mpw','mname');

        String query = "insert into tbl_member (mid, mpw, mname) values ('v1','v2','v3');";

        for (int i=0; i<10; i++) {

            String mid = "user"+i; //user0
            String mpw = passwordEncoder.encode("pw"+i); //pw -> Bcrypted
            String mname = "유저" +i; //유저0

            String result = query;

            result = result.replace("v1",mid);
            result = result.replace("v2",mpw);
            result = result.replace("v3",mname);

            System.out.println(result);
        }
     }

    @Test
    public void insertAdmin() {
        //insert into tbl_member (mid, mpw, mname) values ('mid','mpw','mname');

        String query = "insert into tbl_member (mid, mpw, mname) values ('v1','v2','v3');";

        for (int i=100; i<110; i++) {

            String mid = "user"+i; //user0
            String mpw = passwordEncoder.encode("pw"+i); //pw -> Bcrypted
            String mname = "관리자" +i; //관리자0

            String result = query;

            result = result.replace("v1",mid);
            result = result.replace("v2",mpw);
            result = result.replace("v3",mname);

            System.out.println(result);
        }
    }
}
