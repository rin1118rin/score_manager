<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
	
	    <div class="main">
	    		<h2>学生情報変更</h2>
	    		<form action="" method="post">
	    			<div>
	    				<label>入学年度</label>
	    				<input type="text" name="ent_year" value="${ent_year}" readonly>
	    			</div>
	    			<div>
	    				<label>学生番号</label>
	    				<input type="text" name="no" value="${no}" readonly>
	    			</div>
	    			<div>
	    				<label>氏名</label>
	    				<input type="text" name="name" value="${name}" maxlength="30" required>
	    			</div>
	    			<div>
	    				<label>クラス</label>
	    				<select name="class_num"></select>
	    			</div>
	    			<div>
	    				<label>在学中</label>
	    				<input type="checkbox" name="is_attend">
	    			</div>
	    			<input type="submit"name="login">
	    			<a href="">戻る</a>
	    		</form>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>