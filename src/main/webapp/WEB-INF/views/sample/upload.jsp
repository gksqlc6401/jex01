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

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

    document.querySelector("#uploadBtn").addEventListener("click",(e)=>{

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for(let i = 0; i <fileInput.files.length; i++) {

            formData.append("uploadFiles", fileInput.files[i])//파일 인풋의 파일 i번쨰
        }

        console.log(fileInput)

        //axios로 업로드
        const headerObj =  {hearders: {"Content-Type": "multipart/form-data"}}

        axios.post("/upload", formData, headerObj)
        //UploadController가서 PostMapping작성

    },false)



</script>
</body>
</html>
