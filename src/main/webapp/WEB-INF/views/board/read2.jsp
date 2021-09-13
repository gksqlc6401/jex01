<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
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
                                <label for="exampleInputEmail1">BNO</label>
                                <input type="text" name="bno" class="form-control" id="exampleInputEmail1" value="<c:out value="${boardDTO.bno}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail12">TITLE</label>
                                <input type="text" name="title" class="form-control" id="exampleInputEmail12" value="<c:out value="${boardDTO.title}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail13">WRITER</label>
                                <input type="text" name="writer" class="form-control" id="exampleInputEmail13" value="<c:out value="${boardDTO.writer}"></c:out>" readonly>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <!-- textarea -->
                                    <div class="form-group">
                                        <label>Textarea</label>
                                        <textarea name="content" class="form-control" rows="3" disabled><c:out value="${boardDTO.content}"></c:out></textarea>
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

                    <!-- 댓글 -->
                    <!-- DIRECT CHAT -->
                    <div class="card direct-chat direct-chat-primary">
                        <div class="card-header">
                            <h3 class="card-title">Replies</h3>

                            <div class="card-tools">
                                <span title="3 New Messages" class="badge badge-primary addReplyBtn">Add Reply</span>
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
                                <!-- 댓글 뿌려주기 -->
                                <!-- /.direct-chat-msg -->
                            </div>
                            <!--/.direct-chat-messages-->
                        </div>
                    </div>
                    <!--/.direct-chat -->
                    <!-- 댓글 끝 -->

                </div>
            </div>
        </div>
    </section>
</div>



<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}"> <!--검색조건이 있을때는 붙고 없을때는 떨어져-->
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
                <button type="button" class="btn btn-primary addBtn">Save changes</button>
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
                <button type="button" class="btn btn-info modbtn">Modify</button>
                <button type="button" class="btn btn-danger rembtn">Delete</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@ include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm") //document.querySelector 계속 안쓰려고 미리 만들어 놓는 것

    document.querySelector(".btnList").addEventListener("click", () => {actionForm.submit()}, false)

    document.querySelector(".btnMod").addEventListener("click", () => {

        const bno = '${boardDTO.bno}'

        actionForm.setAttribute("action", "/board/modify")
        actionForm.innerHTML += `<input type='hidden' name='bno' value='\${bno}'>`
        actionForm.submit()
    }, false)

</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/reply.js"></script>

<script>

    function after(result) {
        console.log("after..............")
        console.log("result", result)
    }

    //doA().then(result => console.log(result))

    //doB(after) // ()실행한 객체, ()없으면 순수한 함수

    //const reply = {bno:323, replyer:'user00', reply:'323323323323'} //js 객체 -> 댓글 임의로 등록한 것

    //doC(reply).then(result => console.log(result))

    //doD(112).then(result => console.log(result))

    //객체전달
    //const reply = {rno:112, reply:"Update reply text..."}

    //doE(reply).then(result => console.log(result))

    function getList() {
        const target = document.querySelector(".direct-chat-messages")
        const bno = '${boardDTO.bno}'

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
            console.log(data)
            let str = "";
            data.forEach(reply=>{
                str+=convertTemp(reply)
            })
            target.innerHTML = str
        })
    }

    (function (){
        getList()
    })()

    const modalDiv = $("#modal-sm")


    document.querySelector(".addReplyBtn").addEventListener("click",function (){

        modalDiv.modal('show')
    },false)

    document.querySelector(".addBtn").addEventListener("click",function (){
        const bno = '${boardDTO.bno}'
        const reply = document.querySelector("input[name = 'reply']").value
        const replyer = document.querySelector("input[name='replyer']").value
        const replyObj = {bno, reply, replyer}
        console.log(replyObj)

        addReply(replyObj).then(result=>{
            getList()
            modalDiv.modal('hide')
            document.querySelector("input[name='reply']").value=""
            document.querySelector("input[name='replyer']").value=""
        })
    },false)

    const modal = $('#modal-lg')
    const modalReplyer = document.querySelector("input[name='replyerMod']")
    const modalReply = document.querySelector("input[name='replyMod']")
    const modRno = document.querySelector("input[name='rno']")

    document.querySelector(".direct-chat-messages").addEventListener("click",(e)=>{
        const target = e.target

        if(target.matches(".direct-chat-text")) {
            const rno = target.getAttribute("data-rno")
            const replyer = target.getAttribute("data-replyer")
            const reply = target.innerHTML

            modRno.value = rno
            modalReplyer.value = replyer
            modalReply.value = reply

            document.querySelector(".rembtn").setAttribute("data-rno",rno)//삭제할때 값을 주려고 준비

            modal.modal("show")
        }

    },false)

    document.querySelector(".rembtn").addEventListener("click",(e)=>{
        const rno = e.target.getAttribute("data-rno")
        removeReply(rno).then(result=>{
            getList()
            modal.modal('hide')
        })
    },false)

    document.querySelector(".modbtn").addEventListener("click",(e)=>{
        const replyObj = {rno: modRno.value, reply: modalReply.value}
        modifyReply(replyObj).then(result=>{
            getList()
            modal.modal("hide")
        })
    },false)
</script>

</body>
</html>