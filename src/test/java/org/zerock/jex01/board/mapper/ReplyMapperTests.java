package org.zerock.jex01.board.mapper;


import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.jex01.board.config.BoardRootConfig;
import org.zerock.jex01.board.domain.Reply;
import org.zerock.jex01.common.config.RootConfig;

import java.util.stream.IntStream;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {BoardRootConfig.class, RootConfig.class})
public class ReplyMapperTests {

    @Autowired(required = false)//false로 해놨기 때문에 로딩할 때 체크하지 않는다.(기본값은 true)->객체에 주입받지 못하더라도 빈을 생성
    ReplyMapper replyMapper;

    @Test
    public void insertDummies() {
        long[] arr = {130L,129L,128L,127L,126L};//bno

        IntStream.rangeClosed(1,100).forEach(num-> {

            long bno = arr[((int)(Math.random()*arr.length)*1000) % 5];//roof도는것

            Reply reply = Reply.builder()
                    .bno(bno)
                    .reply("댓글..."+num)
                    .replyer("user"+(num % 10))
                    .build();

            replyMapper.insert(reply);
        });
    }

    @Test
    public void testList() {
        Long bno =130L;

        replyMapper.getListWithBoard(bno).forEach(reply -> log.info(reply));//바로 한줄로 끝내버리기~ 이해는 못함
    }
}
