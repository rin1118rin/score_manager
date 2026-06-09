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
		<div class="main score-manage-page">
		
		    <h2 class="page-title">成績管理</h2>
		
		    <!-- 検索フォーム -->
		    <form class="manage-search-form" action="" method="get">
		
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
		                <c:forEach var="num" items="${list}">
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
		
		        <div class="form-group">
		            <label>回数</label>
		
		            <select name="f4">
		                <option value="">--------</option>
		            </select>
		        </div>
		
		        <div class="search-button-area">
		            <button type="submit">検索</button>
		        </div>
		
		    </form>
		
		    <!-- 結果 -->
		    <c:if test="${not empty param.f1}">
		
		        <c:choose>
		
		            <c:when test="${empty list}">
		
		                <div class="empty-box">
		                    検索内容が存在しませんでした
		                </div>
		
		            </c:when>
		
		            <c:otherwise>
		
		                <form class="score-register-form"
		                      action=""
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
		
		                        <c:forEach var="test" items="${list}">
		
		                            <tr>
		                                <td>${test.entYear}</td>
		                                <td>${test.classNum}</td>
		                                <td>${test.no}</td>
		                                <td>${test.name}</td>
		
		                                <td>
		                                    <input type="number"
		                                           class="point-input"
		                                           name="point_${test.no}"
		                                           value="${empty test.point ? '' : test.point}"
		                                           min="0"
		                                           max="100">
		                                </td>
		                            </tr>
		
		                        </c:forEach>
		
		                    </table>
		
		                    <input type="hidden"
		                           name="regist"
		                           value="true">
		
		                    <input type="hidden"
		                           name="f4"
		                           value="${param.f4}">
		
		                    <input type="hidden"
		                           name="f3"
		                           value="${param.f3}">
		
		                    <button type="submit"
		                            class="register-button">
		
		                        登録して終了
		
		                    </button>
		
		                </form>
		
		            </c:otherwise>
		
		        </c:choose>
		
		    </c:if>
		
		</div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>