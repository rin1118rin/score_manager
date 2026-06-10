<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <%@ include file="/common/head.jsp" %>
</head>

<body>

    <%@ include file="/common/header.jsp" %>

    <div class="container">

        <%@ include file="/common/sidebar.jsp" %>

        <main class="page-content subject-create-page">

            <h2 class="page-title">
                科目情報登録
            </h2>

            <form
                class="subject-form"
                action="SubjectCreateExecute.action"
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
                        maxlength="3"
                        required
                        placeholder="科目コードを入力してください"
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
                        登録
                    </button>

                </div>

                <!-- 戻る -->
                <a
                    href="SubjectList.action"
                    class="back-link"
                >
                    戻る
                </a>

            </form>

        </main>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>