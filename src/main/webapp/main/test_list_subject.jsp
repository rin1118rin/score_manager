<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
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
	    		<h2>成績参照</h2>
	    		<form action="" method="get">
	    			<p>科目情報</p>
	    			<div>
	    				<label>入学年度</label>
	    				<select name="f1">
	    					<option value="">--------</option>
	    				</select>
	    			</div>
	    			<div>
	    				<label>クラス</label>
	    				<select name="f2">
	    					<option value="">--------</option>
	    				</select>
	    			</div>
	    			<div>
	    				<label>科目</label>
	    				<select name="f3">
	    					<option value="">--------</option>
	    				</select>
	    			</div>
	    			<button type="submit">検索</button>
	    			<input type="hidden" name="f" value="sj">
	    		</form>
	    		<form action="" method="get">
	    			<p>学生情報</p>
	    			<div>
	    				<label>学生番号</label>
	    				<input type="text" name="f4" value="${f4}" maxlength="10" required
	    				placeholder="学生番号を入力してください">
	    			</div>
	    			<button type="submit">検索</button>
	    			<input type="hidden" name="f" value="st">
	    		</form>
	    		<div>科目:${param.f3}</div>
	    		<table>
	    			<tr>
	    				<th>入学年度</th>
	    				<th>クラス</th>
	    				<th>学生番号</th>
	    				<th>氏名</th>
	    				<th>1回</th>
	    				<th>2回</th>
	    			</tr>
	    			<c:forEach var="s" items="${list}">
	    				<tr>
	    					<td>${s.entYear}</td>
	    					<td>${s.classNum}</td>
	    					<td>${s.no}</td>
	    					<td>${s.name}</td>
<%--	    					<td>${}</td>   1回 --%>
<%--	    					<td>${}</td>   2回 --%>
	    				</tr>
	    			</c:forEach>
	    		</table>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>