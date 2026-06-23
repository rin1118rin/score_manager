<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
	<title>得点管理システム</title>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
		    <main class="score-reference">
			    <h2 class="page-title">成績参照</h2>
			    <div class="reference-wrapper">
			        <!-- 科目検索 -->
			        <form class="reference-form"
			              action="TestListSubjectExecute.action"
			              method="get">
			            <p class="form-title">科目情報</p>
			            <div class="form-group">
			                <label>入学年度</label>
			                <select name="f1">
			                    <option value="0">--------</option>
			                    <c:forEach var="year"
			                               items="${ent_year_set }">
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
			                    <c:forEach var="num"
			                               items="${class_num_set }">
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
			            <button type="submit">
			                検索
			            </button>
			            <input type="hidden"
			                   name="f"
			                   value="sj">
			        </form>
			        <!-- 学生検索 -->
			        <form class="reference-form"
			              action="TestListStudentExecute.action"
			              method="get">
			            <p class="form-title">学生情報</p>
			            <div class="form-group">
			                <label>学生番号</label>
			                <input type="text"
			                       name="f4"
			                       value="${f4}"
			                       maxlength="10"
			                       required
			                       placeholder="学生番号を入力してください">
			            </div>
			            <button type="submit">
			                検索
			            </button>
			            <input type="hidden"
			                   name="f"
			                   value="st">
			        </form>
			    </div>
			    <p class="reference-guide">
			        科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
			    </p>
			</main>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>