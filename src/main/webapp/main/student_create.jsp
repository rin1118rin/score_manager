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
	    		<h2>学生情報登録</h2>
	    		<form action="" method="post">
	    			<div>
	    				<label>入学年度</label>
	    				<select name="ent_year"></select>
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
	    				<select name="class_num"></select>
	    			</div>
	    			<div>
	    				<button type="submit" name="end">登録して終了</button>
	    			</div>
	    			<a href="">戻る</a>
	    		</form>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>