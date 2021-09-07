package org.zerock.jex01.common.controller;

import lombok.Data;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;

@Controller
@Log4j2
public class UploadController {

    @GetMapping("/sample/upload")
    public void uploadGET() {

    }

    @PostMapping("/upload")
    public void uploadPost(MultipartFile[] uploadFiles ) {

        log.info("------------------------------");
        if(uploadFiles != null && uploadFiles.length > 0 ){//파일이 비어있지 않다면
            for(MultipartFile multipartFile : uploadFiles) {//포문을 돌리는데
                try {
                    uploadProcess(multipartFile);//메소드 실행해라
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }



    }

    private void uploadProcess(MultipartFile multipartFile) throws Exception{
        String  uploadPath = "C:\\upload";

       String folderName = makeFolder(uploadPath);//폴더 이름은 2021-09-07

        log.info(multipartFile);//이미지 파일인지 여러가지 등등 체크할수있다


        log.info(multipartFile.getOriginalFilename());//파일 이름
        log.info(multipartFile.getSize());//파일 사이즈
        log.info("----------------------------------------");//여기까지 파일 이름 사이즈를 알수있고 이제 카피를 해야함

        String fileName = multipartFile.getOriginalFilename();//파일 이름 지정

        fileName = UUID.randomUUID().toString()+"_"+fileName;//파일 이름이 랜덤하게 만들어진다(중복방지)
        File savedFile = new File(uploadPath/*경로*/+File.separator+folderName, fileName);//폴더 생성하고 경로랑 이름을 설정해준다

        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);//카피 성공

        //썸네일 처리
        String mimeType = multipartFile.getContentType();//파일 타입
        if(mimeType.startsWith("image")){//내타입이 이미지라면
            File thumbnailFile = new File(uploadPath+File.separator+folderName,"s_"+fileName);//썸네일로(s_) 만든다
            Thumbnailator.createThumbnail(savedFile,thumbnailFile,100,100);//타입은 in,out으로 하면 썸내일이 생긴다,노래파일은 X
        }
    }
    private String makeFolder(String uploadPath) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();//날짜 생성
        String str = simpleDateFormat.format(date);//오늘날짜 만들어줌  2021-09-07
        String folderName = str.replace("-", File.separator);// /를 -로 바꿔준다(경로) win=\\
        File uploadFolder = new File(uploadPath, folderName);//파일이 있는지 확인
        if(uploadFolder.exists()==false){//만약에 없다면
            uploadFolder.mkdirs();//폴더(파일) 만들어준다
        }
        return folderName;
    }
}
