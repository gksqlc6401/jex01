<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Register Page</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Dashboard v1</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Board Register</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form action="/board/register" method="post" id="form1">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Title</label>
                                    <input type="text" name="title" class="form-control" id="exampleInputEmail1" placeholder="Enter Title">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail2">Writer</label>
                                    <input type="text" name="writer" class="form-control" id="exampleInputEmail2" placeholder="Enter Writer" readonly value="<sec:authentication property="principal.mid"/>">
                                                                                                                                      <%--글쓸때 작성자 이름을 수정못하고, 로그인한 아이디값을 자동으로 넣어주려고 32--%>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <!-- textarea -->
                                        <div class="form-group">
                                            <label>Textarea</label>
                                            <textarea name="content" class="form-control" rows="3" placeholder="Enter ..."></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->

                            <div class="temp">

                            </div>

                            <div class="card-footer">
                                <button type="submit" id="submitBtn" class="btn btn-primary">Submit</button>
                            </div>

                        </form>
                        <style>
                            .uploadResult {
                                display: flex;
                                justify-content: center;
                                flex-direction: row;
                            }
                        </style>

                        <label for="exampleInputFile">File input</label>
                        <div class="input-group">
                            <div class="custom-file">
                                <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple>
                                <label class="custom-file-label" for="exampleInputFile" >Choose file</label>
                            </div>
                            <div class="input-group-append">
                                <span class="input-group-text" id="uploadBtn">Upload</span>
                            </div>
                        </div>

                        <div class="uploadResult">
<%--                            첨부파일 목록--%>

                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </section>
</div>
<!-- /.content-wrapper -->

<%@include file="../includes/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

    const uploadResultDiv = document.querySelector(".uploadResult")//첨부파일 목록 클래스 불러온거

    document.querySelector("#uploadBtn").addEventListener("click",(e)=>{

        const formData = new FormData()//ajax로 폼 전송을 가능하게 해주는 친구
        const fileInput = document.querySelector("input[name='uploadFiles']")


        for(let i = 0; i <fileInput.files.length; i++) {//사용자가 파일을 몇개 추가했는지

            formData.append("uploadFiles", fileInput.files[i])//파일 인풋의 파일 i번쨰,
        }

        console.log(fileInput)

        //axios로 업로드
        const headerObj =  {hearders: {"Content-Type": "multipart/form-data"}}

        axios.post("/upload", formData, headerObj).then((response)=>{
            const arr = response.data
            console.log(arr)

            let str = ""
            for(let i =0; i<arr.length; i++){//돌려서
                const{uuid, fileName, uploadPath, image,thumbnail,fileLink} = {...arr[i]}// 하나로묶고

                if(image){//이미지라면
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}'data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <img src='/viewFile?file=\${thumbnail}'><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this/*삭제하려고*/)">X</button></div>`//버튼을 누르면 링크(경로)가 떠야함
                    //이미지를 쌓아도 안보이고 보안상 이렇게 하면 안됨,
                    // 이미지 서버가 따로 있으면 좋음,클라우를 사용하면 거기에 업로드를 하면좋다
                }else {//아니라면
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
                }


            }
            uploadResultDiv.innerHTML += str//쌓이게
        },false)
        //UploadController가서 PostMapping작성

    },false)

    function removeFile(fileLink,ele) {//삭제하는 메소드
        console.log(fileLink)
        axios.post("/removeFile", {fileName:fileLink}).then(response =>{
            const targetDiv = ele.parentElement
            targetDiv.remove()
        })
    }
    document.querySelector("#submitBtn").addEventListener("click", (e)=>{
        e.stopPropagation()
        e.preventDefault()
        //현재 화면에 있는 파일 정보를 hidden태그들로 변화
        const form1 = document.querySelector("#form1")
        const fileDivArr = uploadResultDiv.querySelectorAll("div")//for문돌려서 div에 쌓인 정보를 fileDivArr에 넣었다.

        if(!fileDivArr) {//첨부파일이 없다면 바로 등록해라
            form1.submit()
            return
        }
        let str = ""
        for(let i = 0; i<fileDivArr.length; i++) {
            const target = fileDivArr[i]
            const uuid = target.getAttribute("data-uuid")
            const fileName =target.getAttribute("data-filename")
            const uploadPath =target.getAttribute("data-uploadpath")
            const image =target.getAttribute("data-image")

            //\${}는 변수로(값)으로 받는거
            str += `<input type="hidden" name="files[\${i}].uuid" value="\${uuid}">`
            str += `<input type="hidden" name="files[\${i}].fileName" value="\${fileName}">`
            str += `<input type="hidden" name="files[\${i}].uploadPath" value="\${uploadPath}">`
            str += `<input type="hidden" name="files[\${i}].image" value="\${image}">`
        }
        document.querySelector(".temp").innerHTML += str
        // document.querySelector("#form1").innerHTML += str
        // //form을 submit
        // form1.innerHTML += str
        form1.submit()//첨부파일이 있을때
    },false)

</script>

</body>
</html>
