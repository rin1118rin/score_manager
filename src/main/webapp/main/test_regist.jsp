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
			<c:if test="${not empty param.f1}">
				<c:choose>
					<c:when test="${empty list}">
						<p>検索内容が存在しませんでした</p>
					</c:when>
					<c:otherwise>
						<form action="" method="post">
							<div>科目: ${param.f3} ${param.f4}</div>
							<table>
								<tr>
									<th>入学年度</th>
									<th>クラス</th>
									<th>学生番号</th>
									<th>氏名</th>
									<th>点数</th>
								</tr>
								<c:forEach var="test" items="${list}">
									<tr>
										<td>${test.entYear}</td>
										<td>${test.classNum}</td>
										<td>${test.no}</td>
										<td>${test.name}</td>
										<td>
											<input type="number" name="point_${test.no}"
												value="${empty test.point ? '' : test.point}"
												min="0" max="100">
										</td>
									</tr>
								</c:forEach>
							</table>
							<input type="hidden" name="regist" value="true">
							<input type="hidden" name="f4" value="${param.f4}">
							<input type="hidden" name="f3" value="${param.f3}">
							<button type="submit">登録して終了</button>
						</form>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>