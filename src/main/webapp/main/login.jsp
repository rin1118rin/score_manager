<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<%@ include file="/common/head.jsp" %>
</head>

<body>
	<div class="login-content">
		<div class="login-content-left">
			<h1 class="under-line"><i class="fa-solid fa-display"></i>得点管理システム</h1>
		</div>
		
		<div class="login-content-right">
			<h2>ログイン</h2>
			<form action="LoginExecute.action" method="post">
			    	<c:if test="${not empty error}">
				    <p class="error">${error}</p>
				</c:if>
		    		
		        <div class="form-group">
		            <label for="id">ユーザーID</label>
		            <div class="input-box">
		            		<span class="material-symbols-outlined"><i class="fa-regular fa-user"></i></span>
			            <input type="text" 
			                   name="id" 
			                   id="id" 
			                   value="${param.id}" 
			                   placeholder="半角でご入力ください" 
			                   maxlength="10" 
			                   required 
			                   pattern="^[a-zA-Z0-9]+$" 
			                   title="半角英数字で入力してください">
					</div>
		        </div>
		
		        <div class="form-group">
		            <label for="password">パスワード</label>
		            <div class="input-box">
            				<span class="material-symbols-outlined"><i class="fa-solid fa-lock"></i></span>
			            <input type="password" 
			                   name="password" 
			                   id="password" 
			                   placeholder="パスワード" 
			                   maxlength="30" 
			                   required 
			                   pattern="^[a-zA-Z0-9]+$" 
			                   title="パスワード">
						<i class="fa-regular fa-eye password-toggle" onclick="togglePasswordVisibility()"></i>
					</div>
		        </div>

		        <div class="form-group action-group">
		            <input type="submit" value="ログイン" class="login-button"> 
		        </div>
		
		    </form>
		</div>
	</div>
	
	<script>
	function togglePasswordVisibility() {
	    const passwordField = document.getElementById("password");
	    const icon = document.querySelector(".password-toggle");

	    if (passwordField.type === "password") {
	        passwordField.type = "text";
	        icon.classList.remove("fa-eye");
	        icon.classList.add("fa-eye-slash");
	    } else {
	        passwordField.type = "password";
	        icon.classList.remove("fa-eye-slash");
	        icon.classList.add("fa-eye");
	    }
	}
	</script>
</body>
</html>