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
	    		<h2>学生情報登録</h2>
	    		<label>登録が完了しました</label>
	    		<a href="StudentCreate.action">戻る</a>
	    		<a href="StudentList.action">学生一覧</a>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>