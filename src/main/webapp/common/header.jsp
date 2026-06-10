<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="header">

    <div class="header-title">
        <h1>得点管理システム</h1>
    </div>

    <nav class="header-user">
        <c:if test="${not empty user}">
            <span>${user.name}</span>
            <span>様</span>

            <a href="Logout.action">
                <i class="fa-solid fa-right-from-bracket"></i>
                ログアウト
            </a>
        </c:if>
    </nav>

</header>