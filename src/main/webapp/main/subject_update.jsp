<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    		<h2>科目情報変更</h2>
	    		<label>科目コード</label>
	    		<input type="text" name="cd" value="${cd}" readonly>
	    		<label>科目名</label>
	    		<input type="text" name="name" value="${name}" maxlength="20" required>
	    		<button type="submit">変更</button>
	    		<a href="">戻る</a>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>