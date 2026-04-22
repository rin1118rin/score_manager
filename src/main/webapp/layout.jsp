<%@ include file="/common/header.jsp" %>

<div class="container">
    <%@ include file="/common/sidebar.jsp" %>

    <div class="main">
        <!-- 各画面の中身 -->
        <jsp:include page="${content}" />
    </div>
</div>

<%@ include file="/common/footer.jsp" %>