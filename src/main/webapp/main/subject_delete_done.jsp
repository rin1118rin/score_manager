<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
		<main class="page-content">
		    <div class="main complete-page">
			    <div class="complete-box">
			        <h2>学生情報削除</h2>
			        <p class="complete-message">
			            削除が完了しました
			        </p>
			        <div class="complete-links">
			            <a href="SubjectList.action"
			               class="list-button">
			                科目一覧
			            </a>
			        </div>
			    </div>
			</div>
		</main>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>