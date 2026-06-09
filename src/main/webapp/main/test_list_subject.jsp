<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
		<div class="main score-subject-page">
		
		    <h2 class="page-title">成績一覧（科目）</h2>
		
		    <div class="search-area">
		
		        <!-- 科目検索 -->
		        <form class="search-card"
		              action="TestListSubjectExecute.action"
		              method="get">
		
		            <p class="card-title">科目情報</p>
		
		            <div class="form-group">
		                <label>入学年度</label>
		
		                <select name="f1">
		                    <option value="0">--------</option>
		
		                    <c:forEach var="year" items="${ent_year_set}">
		                        <option value="${year}"
		                            <c:if test="${year==f1}">selected</c:if>>
		                            ${year}
		                        </option>
		                    </c:forEach>
		                </select>
		            </div>
		
		            <div class="form-group">
		                <label>クラス</label>
		
		                <select name="f2">
		                    <c:forEach var="num" items="${class_num_set}">
		                        <option value="${num}"
		                            <c:if test="${num==f2}">selected</c:if>>
		                            ${num}
		                        </option>
		                    </c:forEach>
		                </select>
		            </div>
		
		            <div class="form-group">
		                <label>科目</label>
		
		                <select name="f3">
		                    <option value="0">--------</option>
		
		                    <c:forEach var="subject" items="${subjects}">
		                        <option value="${subject.cd}"
		                            <c:if test="${subject.cd==f3}">selected</c:if>>
		                            ${subject.name}
		                        </option>
		                    </c:forEach>
		                </select>
		            </div>
		
		            <button type="submit">検索</button>
		
		            <input type="hidden" name="f" value="sj">
		        </form>
		
		        <!-- 学生検索 -->
		        <form class="search-card"
		              action="TestListStudentExecute.action"
		              method="get">
		
		            <p class="card-title">学生情報</p>
		
		            <div class="form-group">
		                <label>学生番号</label>
		
		                <input type="text"
		                       name="f4"
		                       value="${f4}"
		                       maxlength="10"
		                       required
		                       placeholder="学生番号を入力してください">
		            </div>
		
		            <button type="submit">検索</button>
		
		            <input type="hidden" name="f" value="st">
		        </form>
		
		    </div>
		
		    <div class="result-card">
		
		        <c:choose>
		
		            <c:when test="${empty list}">
		                <p class="empty-message">
		                    学生情報が存在しませんでした
		                </p>
		            </c:when>
		
		            <c:otherwise>
		
		                <div class="subject-name">
		                    科目 : ${param.f3}
		                </div>
		
		                <table class="score-table">
		
		                    <tr>
		                        <th>入学年度</th>
		                        <th>クラス</th>
		                        <th>学生番号</th>
		                        <th>氏名</th>
		                        <th>1回</th>
		                        <th>2回</th>
		                    </tr>
		
		                    <c:forEach var="s" items="${list}">
		                        <tr>
		                            <td>${s.entYear}</td>
		                            <td>${s.classNum}</td>
		                            <td>${s.studentNo}</td>
		                            <td>${s.studentName}</td>
		                            <td>${s.point(1)}</td>
		                            <td>${s.point(2)}</td>
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