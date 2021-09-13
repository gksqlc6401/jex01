package org.zerock.jex01.board.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.jex01.board.dto.BoardDTO;
import org.zerock.jex01.board.service.BoardService;
import org.zerock.jex01.board.service.TimeService;
import org.zerock.jex01.common.dto.PageMaker;
import org.zerock.jex01.common.dto.PageRequestDTO;
import org.zerock.jex01.common.dto.PageResponseDTO;

@Controller
@RequestMapping("/board/*")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

    private final TimeService timeService;

    private final BoardService boardService;

    @GetMapping("/time")
    public void getTime(int num, Model model){
        log.info("===========controller getTime============");

        log.info(num % 0);

        model.addAttribute("time", timeService.getNow());
    }

    @GetMapping("/register")
    public void registerGet() {

    }

    @PostMapping("/register")
    public String registerPost(BoardDTO boardDTO, RedirectAttributes redirectAttributes){

        log.info("boardDTOM       " + boardDTO);

        Long bno = boardService.register(boardDTO);
//        Long bno = 111L;

        log.info("============c       registerPost===============");
        log.info(bno);
        redirectAttributes.addFlashAttribute("result", bno);

        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){
        log.info("c   getList......................" + pageRequestDTO);

        PageResponseDTO<BoardDTO> responseDTO = boardService.getDTOList(pageRequestDTO);//제네릭타입이 정해진다
        //responseDTO에 카운트, boardDTO,보드리퀘스트DTO가 담겨있다

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page,size,total));

    }

    @GetMapping(value = {"/read","/modify", "/read2"})
    public void read(Long bno, PageRequestDTO pageRequestDTO , Model model){
        log.info("c   read " + bno);
        model.addAttribute("boardDTO", boardService.read(bno));
        //pageResquestDTO는 자동으로 modle에 저장되어서 jsp에서 쓸수있다.
    }

    @PostMapping("/remove")
    public String remove(Long bno, RedirectAttributes redirectAttributes){
        log.info("c        remove: " + bno);

        if(boardService.remove(bno)){
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/modify")
    public String modify(BoardDTO boardDTO, PageRequestDTO pageRequestDTO ,RedirectAttributes redirectAttributes){
        log.info("=============================");
        log.info("=============================");
        log.info("=============================");
        log.info(boardDTO);
        if(boardDTO.getFiles().size() > 0) {
            boardDTO.getFiles().forEach(dto-> log.info(dto));
        }
        log.info("=============================");
        log.info("=============================");
        log.info("=============================");
        if(boardService.modify(boardDTO)){
            redirectAttributes.addFlashAttribute("result","modified");
        }
        redirectAttributes.addAttribute("bno", boardDTO.getBno());
        redirectAttributes.addAttribute("page", pageRequestDTO.getPage());
        redirectAttributes.addAttribute("size", pageRequestDTO.getSize());

        if(pageRequestDTO.getType() != null) {
            redirectAttributes.addAttribute("type",pageRequestDTO.getType());
            redirectAttributes.addAttribute("keyword",pageRequestDTO.getKeyword());
        }//post방식의 검색처리
        return "redirect:/board/read";
    }

}
