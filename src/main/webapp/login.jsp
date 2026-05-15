<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
	<%@ include file="/common/header.jsp" %>

	<div class="login-content">
	    <h2>ログイン</h2>
	
	    <form action="login" method="POST">
	        <div class="form-group">
	            <label for="id">ＩＤ</label>
	            <input type="text" 
	                   name="id" 
	                   id="id" 
	                   value="${id}" 
	                   placeholder="半角でご入力ください" 
	                   maxlength="10" 
	                   required 
	                   pattern="^[a-zA-Z0-9]+$" 
	                   title="半角英数字で入力してください">
	        </div>
	
	        <div class="form-group">
	            <label for="password">パスワード</label>
	            <input type="password" 
	                   name="password" 
	                   id="password" 
	                   placeholder="30文字以内の半角英数字でご入力ください" 
	                   maxlength="30" 
	                   required 
	                   pattern="^[a-zA-Z0-9]+$" 
	                   title="半角英数字で入力してください">
	        </div>
	
	        <div class="form-group checkbox-group">
	            <input type="checkbox" 
	                   name="chk_d_ps" 
	                   id="chk_d_ps" 
	                   onclick="togglePasswordVisibility()">
	            <label for="chk_d_ps">パスワードを表示</label>
	        </div>
	
	        <div class="form-group action-group">
	            <input type="submit" 
	                   name="login" 
	                   value="ログイン">
	        </div>
	
	    </form>
	</div>
	
	<script>
	    function togglePasswordVisibility() {
	        var passwordField = document.getElementById("password");
	        var checkbox = document.getElementById("chk_d_ps");
	        
	        if (checkbox.checked) {
	            passwordField.type = "text";
	        } else {
	            passwordField.type = "password";
	        }
	    }
	</script>
	<%@ include file="/common/footer.jsp" %>
</body>
</html>