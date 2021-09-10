<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Modify Page</h1>
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
                            <h3 class="card-title">Board Modify</h3>
                        </div>
                        <!-- /.card-header -->
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <c:if test="${pageRequestDTO.type != null}">
                                <input type="hidden" name="type" value="${pageRequestDTO.type}">
                                <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
                            </c:if>
                            <%--                            url에 검색정보가 저장되는것--%>

                            <div class="card-body">
                                <div class="form-group">
                                    <label for="exampleInputEmail10">BNO</label>
                                    <input type="text" name="bno" class="form-control" id="exampleInputEmail10"
                                           value="<c:out value="${boardDTO.bno}"></c:out>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Title</label>
                                    <input type="text" name="title" class="form-control" id="exampleInputEmail1"
                                           value="<c:out value="${boardDTO.title}"></c:out>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail2">Writer</label>
                                    <input type="text" name="writer" class="form-control" id="exampleInputEmail2"
                                           value="<c:out value="${boardDTO.writer}"></c:out>" readonly>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <!-- textarea -->
                                        <div class="form-group">
                                            <label>Textarea</label>
                                            <textarea name="content" class="form-control" rows="3"><c:out
                                                    value="${boardDTO.content}"></c:out>
                                        </textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="temp"></div>
                            <!-- /.card-body -->

                            <div class="card-footer">
                                <button type="submit" class="btn btn-primary btnList">목록</button>
                                <button type="submit" class="btn btn-warning btnMod">수정</button>
                                <button type="submit" class="btn btn-danger btnDel">삭제</button>
                            </div>
                        </form>
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
                    </div>

                    <div class="uploadResult">
                        <c:forEach items="${boardDTO.files}" var="attach">
                            <div data-uuid="${attach.uuid}" data-filename="${attach.fileName}" data-uploadpath="${attach.uploadPath}"
                                 data-image="${attach.image}">
                                <c:if test="${attach.image}">
                                    <img src="/viewFile?file=${attach.getThumbnail()}">
                                </c:if>
                                   <span>${attach.fileName}</span>
                                    <%--파일의 링크를 찾아서 삭제하기떄문에 링크 가져옴 수정이라는 버튼을 누르기 전까지 절대 삭제가 되면 안됨--%>
                                    <%--removeFile은 div만 삭제하는거지 db를 삭제하는 것이 아님--%>
                                    <%--                                        <button onclick="javascript:removeFile('${attach.getFileLink()}')">X</button>--%>
                                <button onclick="javascript:removeDiv(this)">X</button>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </section>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
    <%--    하단에 검색창에 보여지는것--%>
</form>

<script>
    const form = document.querySelector("#form1")
    const action = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        actionForm.submit();

        // window.location="/board/list"


    }, false);

    document.querySelector(".btnDel").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action", "/board/remove")
        form.setAttribute("method", "post")
        form.submit()

    }, false);

    document.querySelector(".btnMod").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const fileDivArr = uploadResultDiv.querySelectorAll("div")//for문돌려서 div에 쌓인 정보를 fileDivArr에 넣었다.

        if(fileDivArr && fileDivArr.length >0) {//!fileDivArr 첨부파일이 없다면 바로 등록해라
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
        }


        form.setAttribute("action", "/board/modify")
        form.setAttribute("method", "post")
        form.submit()

    }, false);

    //주로 post작업을 끝내고 값을 전달해줄때 사용하는데
</script>
<%--<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>--%>
<%--<script src="resources/js/reply.js"></script>--%>
<%--&lt;%&ndash;이코드를 실행하면 reply.js에서 doA,doB가 실행됨&ndash;%&gt;--%>
<%--<script>--%>
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
                            <button onclick="javascript:removeDiv(this/*삭제하려고*/)">X</button></div>`//버튼을 누르면 링크(경로)가 떠야함
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

    function removeDiv(ele) {
        ele.parentElement.remove()
    }

</script>

<%@include file="../includes/footer.jsp" %>

<%--    doB()--%>

<%--</script>--%>

</body>
</html>
