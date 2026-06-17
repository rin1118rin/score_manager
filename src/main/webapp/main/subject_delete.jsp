<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	    <main class="page-content subject-delete-page">

		    <h2 class="page-title">
		        科目情報削除
		    </h2>
		
		    <form class="delete-card"
		          action="SubjectDeleteExecute.action"
		          method="post">
		
		        <p class="delete-message">
		            「(${name})(${cd})」を
		            削除してもよろしいですか？
		        </p>
		
		        <div class="delete-button-area">
		
		            <button type="submit"
		                    class="delete-button">
		
		                削除
		
		            </button>
		
		            <a href="SubjectList.action"
		               class="back-link">
		
		                戻る
		
		            </a>
		
		        </div>
		
		        <input type="hidden"
		               name="cd"
		               value="${cd}">
		
		        <input type="hidden"
		               name="name"
		               value="${name}">
		
		    </form>
		
		</main>
	    
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>