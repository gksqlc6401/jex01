<%--
  Created by IntelliJ IDEA.
  User: gksql
  Date: 2021-09-07
  Time: 오후 2:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <input type="file" name="uploadFiles" multiple><button id="uploadBtn">UPLOAD</button>

<%--    업로드된 결과를 출력하기위해--%>
    <div class="uploadResult">

    </div>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click",(e)=>{

        const formData = new FormData()//ajax로 폼 전송을 가능하게 해주는 친구
        const fileInput = document.querySelector("input[name='uploadFiles']")


        for(let i = 0; i <fileInput.files.length; i++) {//사용자가 파일을 몇개 추가했는지

            formData.append("uploadFiles", fileInput.files[i])//파일 인풋의 파일 i번쨰,
        }

        console.log(fileInput)

        //axios로 업로드
        const headerObj =  {hearders: {"Content-Type": "multipart/form-data"}}

        axios.post("/upload", formData, headerObj).then((response)=>{//업로드 하면서 응답처리를 배열값으로 담을거다.
          const arr = response.data
            console.log(arr)

            let str = ""
            for(let i =0; i<arr.length; i++){//돌려서
                const{uuid, fileName, uploadPath, image,thumbnail,fileLink} = {...arr[i]}// 하나로묶고

                                                                     // DTO에 있는 thumbnail메소드를 불러왔다.
                if(image){//이미지라면
                    str += `<div data-uuid='\${uuid}'><img src='/viewFile?file=\${thumbnail}'><span>\${fileName}</span>
                    <button onclick="javascript:removeFile/*자바크스립트 remove함수로 가봐*/('\${fileLink}',this/*자신을 삭제하려고*/)">X</button></div>`//버튼을 누르면 링크(경로)가 떠야함
                    //이미지를 쌓아도 안보이고 보안상 이렇게 하면 안됨,
                    // 이미지 서버가 따로 있으면 좋음,클라우를 사용하면 거기에 업로드를 하면좋다
                }else {//아니라면
                    str += `<div data-uuid='\&{uuid}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`//DTO에서 가져온 원본의 링크
                }


            }
            uploadResultDiv.innerHTML += str//쌓이게
        },false)
        //UploadController가서 PostMapping작성

    },false)

    function removeFile(fileLink,ele) {//삭제하는 메소드, 결로랑 뭘지울건지 파라미터
        console.log(fileLink)
        axios.post("/removeFile", {fileName:fileLink}).then(response =>{//remove파일로 보내주고
                                      //이름:경로
           const targetDiv = ele.parentElement//ele는 this이다 this는 버튼인데 그 상위 버전을 지워야해서 부모인 parentElement을 사용해서 지운다.
            targetDiv.remove()
        })
    }

</script>
</body>
</html>
