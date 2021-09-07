<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Read Page</h1>
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
                            <h3 class="card-title">Board Read</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputEmail10">BNO</label>
                                <input type="text" name="bno" class="form-control" id="exampleInputEmail10" value="<c:out value="${boardDTO.bno}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Title</label>
                                <input type="text" name="title" class="form-control" id="exampleInputEmail1" value="<c:out value="${boardDTO.title}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail2">Writer</label>
                                <input type="text" name="writer" class="form-control" id="exampleInputEmail2" value="<c:out value="${boardDTO.writer}"></c:out>" readonly>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <!-- textarea -->
                                    <div class="form-group">
                                        <label>Textarea</label>
                                        <textarea name="content" class="form-control" rows="3" disabled><c:out value="${boardDTO.content}"></c:out>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer float-right">
                            <button type="button" class="btn btn-default btnList">LIST</button>
                            <button type="button" class="btn btn-info btnMod">MODIFY</button>
                        </div>

                    </div>
                    <!-- /.card -->
                    <div class="card direct-chat direct-chat-primary">
                        <div class="card-header">
                            <h3 class="card-title">Replies</h3>

                            <div class="card-tools">
                                <span class="badge badge-primary addReplyBtn">Add Reply</span>
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-comments"></i>
                                </button>
                                <button type="button" class="btn btn-tool" data-card-widget="remove">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <!-- Conversations are loaded here -->
                            <div class="direct-chat-messages">
                            </div>
                            <!--/.direct-chat-messages-->
                        </div>
                    </div>
                    <!--/.direct-chat -->

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
</form>
<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Reply</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="replyer">
                <input type="text" name="reply">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary operBtn">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modify/Remove</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="rno">
                <input type="text" name="replyerMod">
                <input type="text" name="replyMod">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info btnModReply">Modify</button>
                <button type="button" class="btn btn-danger btnRem">Remove</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>

<script>
    const actionFrom = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click",()=> {actionFrom.submit()}, false)

    document.querySelector(".btnMod").addEventListener("click",()=> {

        const bno = '${boardDTO.bno}'//수정하는데 bno값으로 받아옴

        actionFrom.setAttribute("action","/board/modify")
        actionForm.innerHTML +=`<input type='hidden' name='bno' value='\${bno}'>`
        actionFrom.submit()
    }, false)

</script>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/reply.js">//read.jsp랑 reply.js랑 연결하는코드,read에서 글을 읽어야 댓글을 달수 있기때문에 read랑 연결</script>

<script>

    // function after(result){//배열을 담아서 사용하는 예제
    //     console.log("after...............")
    //     console.log("result: "+result)
    // }
    // //2.
    //  doA().then(result => console.log(result))//결과가 오면 result찍어줌, then은 비동기 방식일때 사용
    // //1.console.log(doA())//먼저 찍어주고 약속하고 그다음에 배열 찍어줌
    //
    //  doB(after)//()가 없으면 객체,()가 있으면 실행하는애,
    //  //당신이 뭘하든 callback을 하든 약속했기때문에 마지막에 찍어줌?
    //  //댓글을 보여주려고 하는 역활
    //
    //
    //
    //  const reply = {bno:130, replyer:'asdsad', reply:12333321323213}//임의로 작성 한 댓글(댓글번호 , 작성자, 내용)
    //  doC(reply).then(result => console.log(result))
    //
    //
    //  doD(130).then(result => console.log(result))
    //
    // const reply = {rno:130, reply:"update test............"}//이미 수정완료 된 댓글
    // doE(reply).then(result => console.log(result))

    function getList() {
        const target = document.querySelector(".direct-chat-messages")
        const bno = '${boardDTO.bno}'//130


        function convertTemp(replyObj) {

            // console.log(replyObj)

            const {rno,bno,reply,replyer,replyDate,modDate}  = {...replyObj}//스프레드 연산자 (전개 연산자)

            const temp =`<div class="direct-chat-msg">
                <div class="direct-chat-infos clearfix">
                    <span class="direct-chat-name float-left">\${rno}--\${replyer}</span>
                    <span class="direct-chat-timestamp float-right">\${replyDate}</span>
                </div>
                <div class="direct-chat-text" data-rno='\${rno}' data-replyer='\${replyer}'>\${reply}</div>
            </div>`

            return temp

        }

        getReplyList(bno).then(data => {
            console.log(data)//array
            let str = "";

            data.forEach(reply => {
                str += convertTemp(reply)
            })
            target.innerHTML = str
        })
    }

    //최초실행
    (function (){
        getList()
    })()

    const modalDiv = $("#modal-sm")

    let oper = null

    // console.log("1---------------------------" , document.querySelector(".addReplyBtn"))

    document.querySelector(".addReplyBtn").addEventListener("click",function (){

        // alert("addReplyBtn click")

        oper = 'add'
        modalDiv.modal('show')
    },false)


    document.querySelector(".operBtn").addEventListener("click",function (){

        const bno = `${boardDTO.bno}`
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value

        if(oper==='add') {
            const replyObj = {bno, replyer, reply}//{bno:bno, replyer:replyer, reply:reply}
            console.log(replyObj)
            addReply(replyObj).then(result=>{
                getList()
                modalDiv.modal('hide')
                document.querySelector("input[name='replyer']").value=""
                document.querySelector("input[name='reply']").value=""
            })
        }

    },false)
    //수정/삭제 dom
    const modModal = $("#modal-lg")
    const modReplyer = document.querySelector("input[name='replyerMod']")
    const modReply = document.querySelector("input[name='replyMod']")
    const modRno = document.querySelector("input[name='rno']")

    document.querySelector(".direct-chat-messages").addEventListener("click",(e) => {
        const target = e.target
        const bno = '${boardDTO.bno}'

        if(target.matches(".direct-chat-text")){
            const rno = target.getAttribute("data-rno")
            const replyer = target.getAttribute("data-replyer")
            const reply = target.innerHTML
            console.log(rno,replyer,reply,bno)
            modRno.value = rno
            modReply.value = reply
            modReplyer.value = replyer

            document.querySelector(".btnRem").setAttribute("data-rno", rno)

            modModal.modal('show')

        }

    },false)

    document.querySelector(".btnRem").addEventListener("click",(e)=>{
        const rno = e.target.getAttribute("data-rno")
        //alert(rno)
        removeReply(rno).then(result => {
            getList()
            modModal.modal("hide")
        })
    },false)

    document.querySelector(".btnModReply").addEventListener("click",(e)=>{

        const replyObj = {rno: modRno.value, reply: modReply.value}

        console.log(replyObj)

        modifyReply(replyObj).then(result=>{
            getList()
           modModal.modal("hide")
        })

    },false)

</script>

<%--<script>--%>

<%--    function after(result){--%>
<%--        console.log("after………………")--%>
<%--        console.log("result",result) // .js에서 fn(arr)으로 받아온 결과를 확인한다.--%>
<%--    }--%>

<%--    // console.log(doA()) //doA()호출했으니까 read.jsp에 있는 이게 먼저 출력하고 -> promise만 먼저 반환해줌 (thread.sleep을 찍어놔서 나중에 반환된 값이 나중에 찍힘)--%>
<%--    // doA().then(result => console.log(result)) // 제대로 결과값이 나오려면 결국 Then을 사용해야 한다.--%>

<%--    // doB(after) //위의 after함수를 객체로 받아서 (괄호없이) 파라미터로 전달--%>

<%--    // const reply = {bno:201, replyer:'user00', reply:'12314839471897'}--%>
<%--    // doC(reply).then(result => console.log(result))--%>

<%--    // doD(112).then(result => console.log(result))--%>

<%--    const reply = {rno:112, reply:"Update reply text………"} // 댓글 112번에 입력할 내용--%>
<%--    doE(reply).then(result => console.log(result))//위에 입력한 reply 호출--%>


<%--</script>--%>



</body>
</html>


