<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <%@ include file="/common/head.jsp" %>
</head>

<body>

<%@ include file="/common/header.jsp" %>

<div class="container">

    <%@ include file="/common/sidebar.jsp" %>

    <main class="student-create">

        <h2 class="page-title">学生情報登録</h2>

        <form class="student-form"
              action="StudentCreateExecute.action"
              method="post">

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

            <!-- 入学年度 -->
            <div class="form-group">
                <label>入学年度</label>

                <select name="ent_year">
                    <option value="">--------</option>

                    <c:forEach var="year" items="${ent_year_set}">
                        <option value="${year}">
                            ${year}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 学生番号 -->
            <div class="form-group">
                <label>学生番号</label>

                <input
                    type="text"
                    name="no"
                    value="${no}"
                    maxlength="30"
                    required
                    placeholder="学生番号を入力してください"
                >
            </div>

            <!-- 氏名 -->
            <div class="form-group">
                <label>氏名</label>

                <input
                    type="text"
                    name="name"
                    value="${name}"
                    maxlength="30"
                    required
                    placeholder="氏名を入力してください"
                >
            </div>

            <!-- クラス -->
            <div class="form-group">
                <label>クラス</label>

                <select name="class_num">

                    <c:forEach var="classNum"
                               items="${class_num_set}">

                        <option value="${classNum}">
                            ${classNum}
                        </option>

                    </c:forEach>

                </select>
            </div>

            <!-- ボタン -->
            <div class="button-area">
                <button type="submit">
                    登録して終了
                </button>
            </div>

            <a class="back-link"
               href="StudentList.action">

                戻る

            </a>

        </form>

    </main>

</div>

<%@ include file="/common/footer.jsp" %>

</body>
</html>