<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">List Page</h1>
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
            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section class="col-lg-12">
                    <!-- TO DO List -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Bordered Table</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th style="width: 20px">BNO</th>
                                    <th>TITLE</th>
                                    <th>WRITER</th>
                                    <th>REGDATE</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${dtoList}" var="dto">
                                    <tr>
                                        <td><c:out value="${dto.bno}"></c:out></td>
                                        <td><a href="javascript:moveRead(${dto.bno})"><c:out value="${dto.title}"></c:out></a></td>
                                        <td><c:out value="${dto.writer}"></c:out></td>
                                        <td><c:out value="${dto.regDate}"></c:out></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <form action="/board/list" method="get">
                                <input type="hidden" name="page" value="1">
<%--                                검색한결과가 1페이지가 나오게 value값에 1을 넣어줬다--%>
                                <input type="hidden" name="size" value="${pageMaker.size}">
                            <div class="col-sm-3">
                                <!-- select -->
                                <div class="form-group">
                                    <label>Search</label>
                                    <select name="type" class="custom-select">
                                        <option value="">-----</option>
                                        <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                        <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목+내용</option>
                                        <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>내용</option>
                                        <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>전체</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-9">
                                <div class="input-group input-group-sm">
                                    <input type="text" class="form-control" name="keyword" value="${pageRequestDTO.keyword}">
                                    <span class="input-group-append"><button type="submit" class="btn btn-info btn-flat">Go!</button></span>
<%--                                                                               submit은 form태그에 포함되어 있어야한다--%>
                                </div>
                            </div>
                            </form>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer clearfix">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <c:if test="${pageMaker.prev}">
                                    <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start-1})"> << </a></li>
                                </c:if>
                                <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                                    <li class="page-item ${pageMaker.page==num?'active':''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                                </c:forEach>
<%--                                1부터10까지 반복해서 찍어주려고 forEach사용, c:out을 굳이 사용할 필요가 없어서 사용안함
                                    a태그는 href링크가 매우 길어지고 에러발생 가능성 높아짐
                                    자바스크립트는 재사용, 처리하기 쉽다, 링크가 간결하다--%>
                                <c:if test="${pageMaker.next}">
                                    <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end+1})"> >> </a></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <!-- /.card -->
                </section>
                <!-- /.Left col -->
            </div>
            <!-- /.card -->
        </div>
    </section>
</div>

<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Small Modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>One fine body&hellip;</p>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">
    <c:if test="${pageRequestDTO.type != null}">
<%--        검색조건에만 url나오게--%>
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>
<%--input태그는 입력창이기때문에 사용자에게 페이지랑 사이즈를 히든으로 처리하려고--%>

<%@include file="../includes/footer.jsp"%>
<script>

    const actionForm=document.querySelector("#actionForm")//#으로 써줘야 가져올수있다

    const result='${result}'
    //result 값이 없으면 공백, 값이 있으면 숫자 나옴, 안 바뀌니까 const로 선언
    //공백 문자면 모달 창이 아예 안 뜸: bno값을 BoardController에서 받아 옴
    if(result&&result !==''){
        $('#modal-sm').modal('show')
        window.history.replaceState(null,'','/board/list');
        //뒤로 가기 했을 때 모달창이 안 보이게 함
    }

    function movePage(pageNum){
        //event.preventDefault()
        //event.stopPropagation()
        //alert(pageNum)
        actionForm.querySelector("input[name='page']").setAttribute("value",pageNum)//url정보를 먹고 있는 역활
        //클릭한 페이지번호 값으로 바꾼다
        //console.log(pageEle)
        actionForm.submit()//
        //페이지번호 누르면 해당 페이지로 이동
    }

    function moveRead(bno){
        actionForm.setAttribute("action","/board/read")
        //read로 이동하도록
        actionForm.innerHTML+=`<input type='hidden' name='bno' value='\${bno}'>`
        //액션에 추가
        actionForm.submit()
    }

</script>


</body>
</html>