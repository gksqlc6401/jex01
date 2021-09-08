package org.zerock.jex01.board.domain;

import lombok.*;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardAttach {

    private String uuid;
    private Long bno;
    private String fileName;
    private String path;
    private boolean image;

    public void setBno(Long bno) {this.bno=bno;}//db랑 연결될 Enttiy가 필요해서 fk값인 bno를 뽑아주는 메소드

}
