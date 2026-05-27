<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%@ include file="/common/header.jsp"%>

	<div class="container">
		<%@ include file="/common/sidebar.jsp"%>

		<div class="main">
			<h2>学生管理</h2>
			<a href="">新規登録</a>
			<form action="" method="get" class="search-box">
				<div class="">
					<label>入学年度</label> <select name="f1">
						<option value="0">--------</option>
						<c:forEach var="year" items="${ent_year_set }">
							<option value="${year }" <c:if test="${year==f1 }">selected</c:if>>${year }</option>
						</c:forEach>
					</select>
				</div>
				<div class="">
					<label>クラス</label> <select name="f2">
						<option value="0">--------</option>
						<c:forEach var="num" items="${class_num_set }">
							<option value="${num }" <c:if test="${num==f2 }">selected</c:if>>${num }</option>
						</c:forEach>
					</select>
				</div>
				<div class="">
					<label class="form-check-label" id="student-f3-check">在学中
						<input class="form-check-input" type="checkbox" id="student-f3-check" name="f3" value="1"<c:if test="${f3 == true }">checked</c:if>>
					</label>
				</div>
				<div class="">
					<button type="submit">絞込み</button>
				</div>
			</form>
			<c:choose>
				<c:when test="${empty students}">
					<p>学生情報が存在しませんでした</p>
				</c:when>
				<c:otherwise>
					<p>検索結果：${students.size()}件</p>
					<table>
						<tr>
							<th>入学年度</th>
							<th>学生番号</th>
							<th>氏名</th>
							<th>クラス</th>
							<th>在学中</th>
						</tr>
						<c:forEach var="student" items="${students }">
							<tr>
								<td>${student.entYear}</td>
								<td>${student.no}</td>
								<td>${student.name}</td>
								<td>${student.classNum}</td>
									<td>
										<c:choose>
											<c:when test="${student.attend }">
												〇
											</c:when>
											<c:otherwise>
												×
											</c:otherwise>
										</c:choose>
									</td>
								<td><a href="">変更</a></td>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<%@ include file="/common/footer.jsp"%>
</body>
</html>