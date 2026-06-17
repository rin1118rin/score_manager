<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
	<title>得点管理システム</title>
    <%@ include file="/common/head.jsp" %>
</head>

<body>

    <%@ include file="/common/header.jsp" %>

    <div class="container">

        <%@ include file="/common/sidebar.jsp" %>

        <main class="main subject-list-page page-content">

            <div class="page-header">

                <h2 class="page-title">
                    科目管理
                </h2>

                <a href="SubjectCreate.action"
                   class="create-button">

                    新規登録

                </a>

            </div>

            <div class="subject-table-card">

                <table class="subject-table">

                    <tr>
                        <th>科目コード</th>
                        <th>科目名</th>
                        <th></th>
                        <th></th>
                    </tr>

                    <c:forEach var="subject"
                               items="${list}">

                        <tr>

                            <td>${subject.cd}</td>

                            <td>${subject.name}</td>

                            <td>

                                <a href="SubjectUpdate.action?cd=${subject.cd}"
                                   class="table-link edit-link">

                                    変更

                                </a>

                            </td>

                            <td>

                                <a href="SubjectDelete.action?cd=${subject.cd}"
                                   class="table-link delete-link">

                                    削除

                                </a>

                            </td>

                        </tr>

                    </c:forEach>

                </table>

            </div>

        </main>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>