package org.zerock.jex01.security.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.zerock.jex01.security.domain.Member;

import java.util.Collection;
import java.util.stream.Collectors;

@ToString
@Setter
@Getter
public class MemberDTO extends User {//부모 클래스의 생성자가있어서 처음에 에러가 난다//3

    private String mid;
    private String mpw;
    private String mname;
    private boolean enabled;//4

    public MemberDTO(Member member){//에러가 난다(생성자에 문제가 있다)6
        super(member.getMid(),
                member.getMpw(),
                member.getRoleList().stream().map(memberRole ->
                        new SimpleGrantedAuthority(memberRole.getRole())).collect(Collectors.toList()) );
                                                        //권한의 타입을 바꿔주는데 memberRole가 List니까 바꿔준다//7
        //member에서 MemverDTO로 타입바꿔주는것
        this.mid = member.getMid();
        this.mpw = member.getMpw();
        this.mname = member.getMname();
        this.enabled = member.isEnabled();//8
    }

    public MemberDTO(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);//5
    }
}
