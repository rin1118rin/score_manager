<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c"
    uri="jakarta.tags.core"%>

<html>

<head>
	<title>得点管理システム</title>
    <%@ include file="/common/head.jsp" %>
</head>

<body>

    <%@ include file="/common/header.jsp" %>

    <div class="container">

        <%@ include file="/common/sidebar.jsp" %>

        <main class="page-content subject-update-page">

            <h2 class="page-title">
                科目情報変更
            </h2>

            <form
                class="subject-update-form"
                action="SubjectUpdateExecute.action"
                method="post"
            >

                <!-- 科目コード -->
                <div class="form-group">

                    <label for="cd">
                        科目コード
                    </label>

                    <input
                        type="text"
                        id="cd"
                        name="cd"
                        value="${cd}"
                        readonly
                    >

                </div>

                <!-- 科目名 -->
                <div class="form-group">

                    <label for="name">
                        科目名
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="${name}"
                        maxlength="20"
                        required
                        placeholder="科目名を入力してください"
                    >

                </div>

                <!-- ボタン -->
                <div class="button-area">

                    <button
                        type="submit"
                        class="submit-button"
                    >
                        変更
                    </button>

                    <a
                        href="SubjectList.action"
                        class="back-button"
                    >
                        戻る
                    </a>

                </div>

            </form>

        </main>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>

</html>