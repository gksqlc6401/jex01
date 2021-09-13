package org.zerock.jex01.board.service;


import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.zerock.jex01.board.mapper.TimeMapper;

@Service
@Log4j2
@RequiredArgsConstructor
public class TimeServiceImpl implements TimeService{

    private final TimeMapper timeMapper;

    @Override
    public void addString(String str) {
        timeMapper.insertE1(str);
        timeMapper.insertE2(str);
    }

    @Override
    public String getNow() {


        return timeMapper.getTime2();


    }
}
