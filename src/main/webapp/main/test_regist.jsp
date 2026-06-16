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

        <div class="page-content">

            <h2 class="page-title">
                成績管理
            </h2>

            <!-- 検索フォーム -->
            <form class="manage-search-form"
                  action="TestRegist.action"
                  method="get">

                <div class="form-group">

                    <label>入学年度</label>

                    <select name="f1">

                        <option value="0">--------</option>

                        <c:forEach var="year"
                                   items="${ent_year_set}">

                            <option value="${year}"
                                <c:if test="${year==f1}">
                                    selected
                                </c:if>>

                                ${year}

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <div class="form-group">

                    <label>クラス</label>

                    <select name="f2">

                        <c:forEach var="num"
                                   items="${class_num_set}">

                            <option value="${num}"
                                <c:if test="${num==f2}">
                                    selected
                                </c:if>>

                                ${num}

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <div class="form-group">

                    <label>科目</label>

                    <select name="f3">

                        <option value="0">--------</option>

                        <c:forEach var="subject"
                                   items="${subjects}">

                            <option value="${subject.cd}"
                                <c:if test="${subject.cd==f3}">
                                    selected
                                </c:if>>

                                ${subject.name}

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <div class="form-group">

                    <label>回数</label>

                    <select name="f4">

                        <option value="1">1回</option>

                        <option value="2">2回</option>

                    </select>

                </div>

                <div class="search-button-area">

                    <button type="submit">
                        検索
                    </button>

                </div>

            </form>

            <!-- 一覧 -->
            list = ${list}
			<br>
			件数 = ${list.size()}
            <c:if test="${not empty list}">

                <form class="score-register-form"
                      action="TestRegistExecute.action"
                      method="post">

                    <div class="result-title">
                        科目 : ${param.f3}
                        第${param.f4}回
                    </div>

                    <table class="score-table">

                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>点数</th>
                        </tr>

                        <c:forEach var="test"
                                   items="${list}">

                            <tr>

                                <td>${test.student.entYear}</td>

                                <td>${test.student.classNum}</td>

                                <td>${test.student.no}</td>

                                <td>${test.student.name}</td>

                                <td>

                                    <input type="number"
                                           class="point-input"
                                           name="point_${test.no}"
                                           value="${test.point}"
                                           min="0"
                                           max="100">

                                </td>

                            </tr>

                        </c:forEach>

                    </table>

                    <button type="submit"
                            class="register-button">

                        登録して終了

                    </button>

                </form>

           </c:if>

        </div>

    </div>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>