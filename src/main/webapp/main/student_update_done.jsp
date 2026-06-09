<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<%@ include file="/common/sidebar.jsp" %>
	
	<div class="main student-update-complete-page">
	
	    <div class="complete-card">
	
	        <h2>学生情報変更</h2>
	
	        <p class="complete-message">
	            変更が完了しました
	        </p>
	
	        <div class="complete-button-area">
	
	            <a href="StudentUpdate.action"
	               class="sub-button">
	
	                戻る
	
	            </a>
	
	            <a href="StudentList.action"
	               class="main-button">
	
	                学生一覧
	
	            </a>
	
	        </div>
	
	    </div>
	
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>