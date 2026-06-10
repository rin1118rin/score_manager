<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%@ include file="/common/header.jsp" %>

<%@ include file="/common/sidebar.jsp" %>

<h2>メニュー</h2>

<a href="StudentList.action">学生管理</a>

<div>
成績管理
<a href="TestRegist.action">成績登録</a>
<a href="TestList.action">成績参照</a>
</div>

<a href="SubjectListAction">科目管理</a>

<%@ include file="/common/footer.jsp" %>
</body>
</html>