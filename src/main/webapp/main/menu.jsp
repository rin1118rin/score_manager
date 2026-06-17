<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
	<title>得点管理システム</title>
    <%@ include file="/common/head.jsp" %>
</head>

<body class="main-page">

    <%@ include file="/common/header.jsp" %>

    <div class="container">

        <%@ include file="/common/sidebar.jsp" %>

        <main class="main-content">

            <h2>メニュー</h2>

            <div class="menu-grid">

                <a href="StudentList.action"
                   class="menu-card">

                    <i class="fa-solid fa-user"></i>

                    <h3>学生管理</h3>

                </a>

                <a href="TestRegist.action"
                   class="menu-card">

                    <i class="fa-solid fa-pen"></i>

                    <h3>成績登録</h3>

                </a>

                <a href="TestList.action"
                   class="menu-card">

                    <i class="fa-solid fa-chart-column"></i>

                    <h3>成績参照</h3>

                </a>

                <a href="SubjectList.action"
                   class="menu-card">

                    <i class="fa-solid fa-book"></i>

                    <h3>科目管理</h3>

                </a>

            </div>

        </main>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>