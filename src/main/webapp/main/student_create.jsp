<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>

	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
	
	    <div class="main">
	    		<h2>学生情報登録</h2>
	    		<form action="StudentCreateExecute.action" method="post">
		    		<c:if test="${not empty error}">
				    <p style="color: orange;">${error}</p>
				</c:if>

	    			<div>
	    				<label>入学年度</label>
	    				<select name="ent_year">
	    				    <option value="">--------</option>
					    <c:forEach var="year" items="${ent_year_set}">
					        <option value="${year}">${year}</option>
					    </c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<label>学生番号</label>
	    				<input type="text" name="no" value="${no}" maxlength="30"　required placeholder="学生番号を入力してください">
	    			</div>
	    			<div>
	    				<label>氏名</label>
	    				<input type="text" name="name" value="${name}" maxlength="30" required placeholder="氏名を入力してください">
	    			</div>
	    			<div>
	    				<label>クラス</label>
	    				<select name="class_num">
					    <c:forEach var="classNum" items="${class_num_set}">
					        <option value="${classNum}">${classNum}</option>
					    </c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<button type="submit" name="end">登録して終了</button>
	    			</div>
	    			<a href="StudentList.action">戻る</a>
	    		</form>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>