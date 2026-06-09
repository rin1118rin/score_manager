<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
<%@ include file="/common/header.jsp" %>

<%@ include file="/common/sidebar.jsp" %>
<main class="main-content">
	<div class="menu-grid">
		<a href="StudentList.action" class="menu-card">
			<i class="fa-solid fa-user"></i>
            <h3>学生管理</h3>
		</a>
		
		<a href="" class="menu-card">
            <i class="fa-solid fa-book"></i>
            <h3>成績登録</h3>
        </a>

        <a href="TestList.action" class="menu-card">
            <i class="fa-solid fa-chart-column"></i>
            <h3>成績参照</h3>
        </a>
		
		<a href="SubjectListAction" class="menu-card">
			<i class="fa-solid fa-graduation-cap"></i>
            <h3>科目管理</h3>
		</a>
	</div>
</main>
</body>
</html>