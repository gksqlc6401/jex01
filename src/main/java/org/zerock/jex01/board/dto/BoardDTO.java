package org.zerock.jex01.board.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.zerock.jex01.board.domain.Board;
import org.zerock.jex01.board.domain.BoardAttach;
import org.zerock.jex01.common.dto.UploadResponseDTO;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {

    private Long bno;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime regDate;
    private LocalDateTime modDate;

    @Builder.Default
    private List<UploadResponseDTO> files = new ArrayList<>();//DTO에도 첨부파일을 넣을 공간이 필요해서 리스트로 만들었다

    public Board getDomain(){

        Board board = Board.builder()
                .bno(bno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        files.forEach(uploadResponseDTO -> {

            BoardAttach attach = BoardAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            board.addAttach(attach);//객체안에 객체가 있다
        });

        return board;
    }
}
