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
	    		<h2>成績管理</h2>
	    		<form action="" method="get">
			    <div class="">
			        <label>入学年度</label>
			        <select name="f1">
			            <option value="">--------</option>
			        </select>
			    </div>
			
			    <div class="">
			        <label>クラス</label>
			        <select name="f2">
			            <option value="">--------</option>
			        </select>
			    </div>
			    <div class="">
			        <label>科目</label>
			        <select name="f3">
			            <option value="">--------</option>
			        </select>
			    </div>
			    <div class="">
			        <label>回数</label>
			        <select name="f4">
			            <option value="">--------</option>
			        </select>
			    </div>
			    <div class="">
			        <button type="submit">検索</button>
			    </div>
			</form>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>