package org.zerock.jex01.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageRequestDTO {

    @Builder.Default
    private int page = 1;
    @Builder.Default
    private int size = 10;

    private String type;//제목으로 찾을건지 작성자로 찾을건지 내용으로 찾을지 전체다로 찾을지 타입
    private String keyword;//사용자가 검색한 검색어

    public int getSkip(){
        return (page -1) * size;
    }
    //skip의 값을 구하느 메소드

    public String getType() {
        if(type == null || type.trim().length() == 0) {  //타입이 null 이면 공백문자 잘라낸다
             return  null;
        }
        return  type;
    }

    public String[] getArr() { return type ==null? new String[]{}: type.split(""); }
    //null이면 SQL에서 문제가 생기므로 빈 배열이라도 주는 것

}
