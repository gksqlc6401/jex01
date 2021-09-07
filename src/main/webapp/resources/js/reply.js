

//비동기 방식
async function doA() {//await사용하려면 async써야함

    console.log("daA....................")

    const response =  await axios.get("/replies")//then이나 비동기를 사용하려면 꼭await 사용
    const data =response.data
    console.log("doA..data", data)
    return data //doA를 실행하면 배열이 나온다.
}
//callback
const doB = (fn) => {//함수라서 fn으로 줌
    //fn은 read.js의 funtion after가 들어감
    console.log("doB.....................")
    try {
        axios.get('/replies').then(response => console.log(response))//결과가 나오는데 비동기(구글링??)임 그래서 then사용
            console.log(response)
           const arr = response.data
            fn(arr)//callback
    }catch (error){
        console.log(err)
    }

}

async function doC(obj) {//댓글을 post로 등록하는 방법
    const response = await axios.post("/replies",obj)
    return response.data
}

const doD = async (rno) => {//댓글을 삭제하는친구
    const response = await axios.delete(`/replies/${rno}`)
    return response.data
}

const doE = async (reply) => {//put이 수정해서 집어넣는 친구, 수정은 등록과 삭제의 기능이 섞여있다.

    await axios.put(`/replies/${reply.rno}`,reply)

    return response.data
}

const getReplyList = async  (bno) => {

    const response = await axios.get(`/replies/list/${bno}`)

    return response.data
}

async function addReply(obj) {//댓글을 post로 등록하는 방법
    const response = await axios.post("/replies",obj)
    return response.data
}

const removeReply = async  (rno) => {//댓글을 삭제하는친구
    const response = await axios.delete(`/replies/${rno}`)
    return response.data
}

const modifyReply = async (reply) => {//put이 수정해서 집어넣는 친구, 수정은 등록과 삭제의 기능이 섞여있다.

    const response = await axios.put(`/replies/${reply.rno}`,reply)

    return response.data
}
