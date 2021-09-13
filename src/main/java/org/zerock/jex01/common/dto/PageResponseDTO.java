package org.zerock.jex01.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageResponseDTO<E> {//count값을 넣어주려고 클래스를 만듬

    private List<E> dtoList;//제네릭 활용 하려고 기본값줬다
    private int count;
}
