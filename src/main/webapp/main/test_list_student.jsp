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
	    		<h2>成績一覧（学生）</h2>
	    		<form action="TestListSubjectExecute.action" method="get">
	    			<p>科目情報</p>
	    			<div>
	    				<label>入学年度</label>
	    				<select name="f1">
	    					<option value="0">--------</option>
	    					<c:forEach var="year" items="${ent_year_set }">
	    						<option value="${year }" <c:if test="${year==f1 }">selected</c:if>>${year }</option>
							</c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<label>クラス</label>
	    				<select name="f2">
	    					<c:forEach var="num" items="${class_num_set }">
								<option value="${num }" <c:if test="${num==f2 }">selected</c:if>>${num }</option>
							</c:forEach>
	    				</select>
	    			</div>
	    			<div>
	    				<label>科目</label>
	    				<select name="f3">
	    					<option value="0">--------</option>
	    					<c:forEach var="subject" items="${subjects }">
	    						<option value="${subject.cd }" <c:if test="${subject.cd==f3 }">selected</c:if>>${subject.name }</option>
	    					</c:forEach>
	    				</select>
	    			</div>
	    			<button type="submit">検索</button>
	    			<input type="hidden" name="f" value="sj">
	    		</form>
	    		<form action="TestListStudentExecute.action"" method="get">
	    			<p>学生情報</p>
	    			<div>
	    				<label>学生番号</label>
	    				<input type="text" name="f4" value="${f4}" maxlength="10" required
	    				placeholder="学生番号を入力してください">
	    			</div>
	    			<button type="submit">検索</button>
	    			<input type="hidden" name="f" value="st">
	    		</form>
	    		<c:choose>
	    			<c:when test="${empty list}">
	    				<div>氏名:${student.name}(${param.f4})</div>
	    				<div>成績情報が存在しませんでした</div>
	    			</c:when>
	    			<c:otherwise>
	    				<div>氏名:${student.name}(${param.f4})</div>
			    		<table>
			    			<tr>
			    				<th>科目名</th>
			    				<th>科目コード</th>
			    				<th>回数</th>
			    				<th>点数</th>
			    			</tr>
			    			<c:forEach var="s" items="${list}">
			    				<tr>
			    					<td>${s.subjectName}</td>
			    					<td>${s.subjectCd}</td>
			    					<td>${s.num}</td>
			    					<td>${s.point}</td>
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