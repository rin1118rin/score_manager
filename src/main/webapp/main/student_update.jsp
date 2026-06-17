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

        <div class="main student-update-page">

            <h2 class="page-title">
                学生情報変更
            </h2>

            <form class="student-update-form"
                  action="StudentUpdateExecute.action"
                  method="post">

                <!-- 入学年度 -->
                <div class="form-group">

                    <label>入学年度</label>

                    <input type="text"
                           name="ent_year"
                           value="${student.entYear}"
                           readonly>

                </div>

                <!-- 学生番号 -->
                <div class="form-group">

                    <label>学生番号</label>

                    <input type="text"
                           name="no"
                           value="${student.no}"
                           readonly>

                </div>

                <!-- 氏名 -->
                <div class="form-group">

                    <label>氏名</label>

                    <input type="text"
                           name="name"
                           value="${student.name}"
                           maxlength="30"
                           required>

                </div>

                <!-- クラス -->
                <div class="form-group">

                    <label>クラス</label>

                    <select name="class_num">

                        <c:forEach var="num" items="${class_num_set}">

                            <option value="${num}"
                                <c:if test="${num == student.classNum}">
                                    selected
                                </c:if>>

                                ${num}

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <!-- 在学中 -->
                <div class="check-group">

                    <label class="check-label">

                        <input type="checkbox"
                               name="is_attend"
                               <c:if test="${student.attend}">
                                   checked
                               </c:if>>

                        <span>在学中</span>

                    </label>

                </div>

                <!-- ボタン -->
                <div class="button-area">

                    <button type="submit"
                            class="submit-button">

                        変更する

                    </button>

                    <a href="StudentList.action"
                       class="back-button">

                        戻る

                    </a>

                </div>

            </form>

        </div>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>