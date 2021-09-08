package org.zerock.jex01.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.graalvm.compiler.lir.amd64.AMD64Binary;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadResponseDTO {

    private String uuid;
    private String fileName;
    private boolean image;
    private String uploadPath;

    public String getThumbnail() {//이미지 경로가 꼬여서 잘나올수있게 매소드만들었음 매번 설정하기 귀찮아서.
        return uploadPath+"/s_"+uuid+"_"+fileName;
    }//이미지를 저장하면 썸네일도 저장된다,get메서드로 만들면 자동으로 Json 처리된다. -> upload.jsp 간다

    public String getFileLink() {//이미지 경로가 꼬여서 잘나올수있게 매소드만들었음 매번 설정하기 귀찮아서.
        return uploadPath+"/"+uuid+"_"+fileName;
    }

//    jsp-----DTO
//    Enttiy-----DB
}
