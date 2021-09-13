package org.zerock.jex01.board.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.jex01.board.domain.Board;
import org.zerock.jex01.board.domain.BoardAttach;
import org.zerock.jex01.common.dto.PageRequestDTO;

import java.util.List;

public interface BoardMapper {

    void insert(Board board);

    List<Board> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Board select(Long bno);

    int delete(Long bno);

    int update(Board board);

    //MyBits는 파라미터가 하나밖에 못받는다 방법은 map이고 두번째는 dto고 세번째는 param이다
    int updateReplyCnt(@Param("bno") Long bno, @Param("num") int num);

    int insertAttach(BoardAttach attach);

    int deleteAttach(Long bno);

}
