<%--
  Created by IntelliJ IDEA.
  User: gksql
  Date: 2021-09-10
  Time: 오전 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%--10--%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %><%--11--%>
<%--권한 정보는 세션에 저장돼 있기 때문에 가져다가 사용해도 무방하지만, Security 태그를 사용하면 좀 더 가시성 좋게 코드를 구성할 수 있다.--%>
<%--아래와 같이 의존 설정 해줍니다. JSP 파일에서 태그 라이브러리를 추가한다.--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <h1>DO ADMIN</h1>

<%--<h2><sec:authentication property="principal"></sec:authentication></h2> 의미없는 주석처리13--%>
  <%--승인을 주는코드(인증정보) 인거같다 여기에서 서버를 실행하면 DTO의 정보가 보인다 12--%>

<%--  <h2><sec:authentication property="mid"></sec:authentication></h2>--%>
<%--  <h2><sec:authentication property="mpw"></sec:authentication></h2>--%>
<%--  <h2><sec:authentication property="mname"></sec:authentication></h2>--%>  <%--15--%>
  <%--앞에 세줄적고 실행하며 에러 memberDTO에서 @ToString 지우고 다시 실행14--%>
  <%--에러가나면 일단 principal을 앞에 적는다--%>

  <h2><sec:authentication property="principal"></sec:authentication></h2>
  <h2><sec:authentication property="principal.mname"></sec:authentication></h2>
  <h2><sec:authentication property="principal.mid"></sec:authentication></h2>
  <h2><sec:authentication property="principal.mpw"></sec:authentication></h2><%-- 최종 수정하고 서버실행하면 정도가 다 보인다  doAll.jsp로 ㄱㄱ16--%>


</body>
</html>
