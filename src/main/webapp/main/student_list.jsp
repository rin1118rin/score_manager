<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
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
		<h2>学生管理</h2>
		<a href="">新規登録</a>
		<form action="" method="get" class="search-box">
		    <div class="">
		        <label>入学年度</label>
		        <select name="">
		            <option value="">--------</option>
		        </select>
		    </div>
		
		    <div class="">
		        <label>クラス</label>
		        <select name="">
		            <option value="">--------</option>
		        </select>
		    </div>
		    <div class="">
		        <label>
		            <input type="checkbox" name="" value="1">在学中
		        </label>
		    </div>
		
		    <div class="">
		        <button type="submit">絞込み</button>
		    </div>
		</form>
		<c:choose>
			<c:when test="${empty list}">
		        <p>学生情報が存在しませんでした</p>
		    </c:when>
			<c:otherwise>
		        <p>検索結果：${list.size()}件</p>
			    <table>
			       <tr>
		            		<th>入学年度</th>
		                <th>学生番号</th>
		                <th>氏名</th>
		                <th>クラス</th>
		                <th>在学中</th>
		            </tr>
					<c:forEach var="s" items="${list}">
						<tr>
					   		<td>${s.entYear}</td>
		                		<td>${s.no}</td>
		                 	<td>${s.name}</td>
		                 	<td>${s.classNum}</td>
		                 	<td>${s.isAttend ? '○' : ''}</td>
		                 	<td><a href="">変更</a></td>
		              	</tr>
		            </c:forEach>
		        </table>	
			</c:otherwise>
		</c:choose>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
</body>
</html>