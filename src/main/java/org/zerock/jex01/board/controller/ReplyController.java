package org.zerock.jex01.board.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;
import org.zerock.jex01.board.domain.Reply;
import org.zerock.jex01.board.dto.ReplyDTO;
import org.zerock.jex01.board.service.ReplyService;

import java.util.List;

@Log4j2
@RestController//리턴한 값이 전부다 JSON으로 처리돤다 기본형 타입은 텍스트로 반환되고 객체타입은 JSon,//@ResponseBody
@RequestMapping("/replies")//요청에 대해 어떤 Controller, 어떤 메소드가 처리할지를 맵핑하기 위한 어노테이션
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyService replyService;

    @GetMapping("")//저쪽?에서 보내는 데이터가 JSON데이터
    public String[] doA() {

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        return new String[]{"AAA","BBB","CCC"};
    }

    @PostMapping("")//포스트맨 raw JSON으로 활용
    public int add(@RequestBody ReplyDTO replyDTO) {//JSON으로 보내주는 데이터를 DTO로 바꿔준다

        log.info("============================");
        log.info(replyDTO);

        return replyService.add(replyDTO);


    }

    @DeleteMapping("/{rno}")
    public String remove(@PathVariable(name = "rno") Long rno) {//@은 네임으로 파라미터를 매칭 해주는 아이,uri에 필요한게 rno다,
        //uri는 식별,url은 uri은 포함된거
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        log.info("----------------reply remove---------");

        replyService.remove(rno);

        log.info("rno : " + rno);
        return "success";
    }

    @PutMapping("/{rno}")
    public String modfiy(@PathVariable(name = "rno") Long rno,
                         @RequestBody ReplyDTO replyDTO) {
        log.info("---------------------reply============"+ rno);
        log.info(replyDTO);
        replyService.modfiy(replyDTO);
        return "success";
    }
    @GetMapping("/list/{bno}")//replies/list/130
    public List<ReplyDTO> getBoardReplies(@PathVariable(name = "bno")Long bno){
        //서비스 계층 호출
        return replyService.getRepliesWithBno(bno);//생성자 생성 해야함 service
    }
}
