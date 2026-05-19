<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%@ include file="/common/header.jsp" %>

	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
	
	    <div class="main">
	    		<h2>科目情報削除</h2>
	    		<label>
	    			<p>「${subject_name}（${subject_cd}）」を削除してもよろしいですか</p>
	    		</label>
	    		<button type="submit" value="削除">削除</button>
			<a href="">戻る</a>
			<input type="hidden" name="subject_cd" value="${subject_cd}"
			<input type="hidden" name="subject_name" value="${subject_name}"
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>