<%--
  Created by IntelliJ IDEA.
  User: gksql
  Date: 2021-09-10
  Time: 오전 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %><%--17--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>DO ALL</h1>

<sec:authorize access="isAnonymous()">
    <a href="/customLogin">Login Plz...</a>
</sec:authorize><%--로그인 되있지 않다면 로그인창 a태그18--%>
    <sec:authorize access="isAuthenticated()">
        <a href="/logout">Logout Plz...</a>
    </sec:authorize><%--로그인이 되어있다면 로그아웃창 a태그-> securityConfig로 가라19--%>
</body>
</html>
