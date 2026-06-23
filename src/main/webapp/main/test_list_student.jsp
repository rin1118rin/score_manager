<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<div class="main score-student-page">
			    <h2 class="page-title">成績一覧（学生）</h2>
			    <!-- 検索エリア -->
			    <div class="search-area">
			        <!-- 科目検索 -->
			        <form class="search-card" action="TestListSubjectExecute.action" method="get">
			            <p class="card-title">科目情報</p>
			            <div class="form-group">
			                <label>入学年度</label>
			                <select name="f1">
			                    <option value="0">--------</option>
			                    <c:forEach var="year" items="${ent_year_set }">
			                        <option value="${year }"
			                            <c:if test="${year==f1 }">selected</c:if>>
			                            ${year }
			                        </option>
			                    </c:forEach>
			                </select>
			            </div>
			            <div class="form-group">
			                <label>クラス</label>
			                <select name="f2">
			                	<option value="0">--------</option>
			                    <c:forEach var="num" items="${class_num_set }">
			                        <option value="${num }"
			                            <c:if test="${num==f2 }">selected</c:if>>
			                            ${num }
			                        </option>
			                    </c:forEach>
			                </select>
			            </div>
			            <div class="form-group">
			                <label>科目</label>
			                <select name="f3">
			                    <option value="0">--------</option>
			                    <c:forEach var="subject"
			                               items="${subjects }">
			                        <option value="${subject.cd }"
			                            <c:if test="${subject.cd==f3 }">selected</c:if>>
			                            ${subject.name }
			                        </option>
			                    </c:forEach>
			                </select>
			            </div>
			            <button type="submit">検索</button>
			            <input type="hidden" name="f" value="sj">
			        </form>
			        <!-- 学生検索 -->
			        <form class="search-card" action="TestListStudentExecute.action" method="get">
			            <p class="card-title">学生情報</p>
			            <div class="form-group">
			                <label>学生番号</label>
			                <input type="text" name="f4" value="${f4}" maxlength="10" required
			                       placeholder="学生番号を入力してください">
			            </div>
			            <button type="submit">検索</button>
			            <input type="hidden" name="f" value="st">
			        </form>
			    </div>
			    <!-- 結果表示 -->
			    <div class="result-area">
			        <c:choose>
			            <c:when test="${empty list}">
			                <div class="student-name">氏名 : ${student.name} (${param.f4})</div>
			                <p class="empty-message">成績情報が存在しませんでした</p>
			            </c:when>
			            <c:otherwise>
			                <div class="student-name">
			                    氏名 : ${student.name} (${param.f4})
			                </div>
			                <table class="score-table">
			                    <tr>
			                        <th>科目名</th>
			                        <th>科目コード</th>
			                        <th>回数</th>
			                        <th>点数</th>
			                    </tr>
			                    <c:forEach var="s" items="${list}">
			                        <tr>
			                            <td>${s.subjectName}</td>
			                            <td>${s.subjectCd}</td>
			                            <td>${s.no}</td>
			                            <td>${s.point}</td>
			                        </tr>
			                    </c:forEach>
			                </table>
			            </c:otherwise>
			        </c:choose>
			    </div>
			</div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>