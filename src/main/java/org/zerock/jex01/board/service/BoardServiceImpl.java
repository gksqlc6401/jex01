package org.zerock.jex01.board.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.zerock.jex01.board.domain.Board;
import org.zerock.jex01.board.dto.BoardDTO;
import org.zerock.jex01.board.mapper.BoardMapper;
import org.zerock.jex01.common.dto.PageRequestDTO;
import org.zerock.jex01.common.dto.PageResponseDTO;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;

    @Override
    public Long register(BoardDTO boardDTO) {

        Board board = boardDTO.getDomain();//

        boardMapper.insert(board);

        Long bno = board.getBno();

        board.getAttachList().forEach(attach -> {
            attach.setBno(bno);//bno값을 따로 셋팅해서 빼놨다.
            boardMapper.insertAttach(attach);
        });

        return board.getBno();
    }

    @Override
    public PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO) {//여기도 마찬가지로 타입을 바꿔줌

        List<BoardDTO> dtoList = boardMapper.getList(pageRequestDTO).stream().map(board -> board.getDTO()).collect(Collectors.toList());
        int count = boardMapper.getCount(pageRequestDTO);

        PageResponseDTO<BoardDTO> pageResponseDTO = PageResponseDTO.<BoardDTO>builder()
                        .dtoList(dtoList)
                        .count(count)
                        .build();

        return pageResponseDTO;//한번에 리턴하려고 리스폰스했음.

    }

    @Override
    public BoardDTO read(Long bno) {
        Board board =  boardMapper.select(bno);

        if(board != null){
            return board.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long bno) {
        return boardMapper.delete(bno) > 0;
    }


@Override
public boolean modify(BoardDTO boardDTO) {

    boardMapper.deleteAttach(boardDTO.getBno());

    Board board = boardDTO.getDomain();

    //첨부파일의 목록만큼 insert해줘야함
    Long bno = board.getBno();

    board.getAttachList().forEach(attach -> {
        attach.setBno(bno);
        boardMapper.insertAttach(attach);
    });

    return boardMapper.update(board) > 0;
}
}
