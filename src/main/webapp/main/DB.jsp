<%@ page import="dao.TableDao,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
TableDao dao = new TableDao();

List<String> tables = null;
List<Map<String, Object>> data = null;
Map<String, Object> sqlResult = null;

// 選択されているテーブルの列名と型を保持するためのリストです
List<Map<String, Object>> columnMetaList = new ArrayList<Map<String, Object>>();

String table = request.getParameter("table");
String userSql = request.getParameter("userSql");
String mode = request.getParameter("mode");

String successMessage = null;
String errorMessage = null;

// セッションからクエリ履歴のリストを取得します
HttpSession sess = request.getSession();
List<String> queryHistory = (List<String>) sess.getAttribute("queryHistory");
if (queryHistory == null) {
    queryHistory = new ArrayList<String>();
    queryHistory.add("SELECT * FROM student WHERE is_attend = TRUE;");
    queryHistory.add("INSERT INTO class_num (class_num, school_cd) VALUES ('116', 'oom');");
    sess.setAttribute("queryHistory", queryHistory);
}

try {
    // クエリの追加、グリッドのインライン編集・削除、新規レコード追加が実行された場合の判定処理です
    if (mode != null) {
        if ("add_history".equals(mode) && userSql != null && !userSql.trim().isEmpty()) {
            if (!queryHistory.contains(userSql.trim())) {
                queryHistory.add(0, userSql.trim());
                successMessage = "入力されたクエリを履歴に追加しました。";
            }
        } else if ("clear_history".equals(mode)) {
            queryHistory.clear();
            successMessage = "クエリ履歴をすべて削除しました。";
        } else if (table != null) {
            Map<String, String[]> paramMap = request.getParameterMap();

            if ("insert_record".equals(mode)) {
                // 画面の下部フォームから送られてきた値を使って動的にINSERT文を生成します
                StringBuilder insertSql = new StringBuilder("INSERT INTO " + table + " (");
                StringBuilder valuesSql = new StringBuilder(") VALUES (");
                List<String> insertValues = new ArrayList<String>();

                for (String key : paramMap.keySet()) {
                    if (key.startsWith("insert_")) {
                        String columnName = key.substring(7);
                        insertSql.append(columnName).append(", ");
                        
                        String val = paramMap.get(key)[0];
                        // チェックボックス等の真偽値が空の場合はFALSEとして扱います
                        if (val == null || val.trim().isEmpty()) {
                            val = "";
                        }
                        insertValues.add(val);
                        valuesSql.append("?, ");
                    }
                }
                
                if (!insertValues.isEmpty()) {
                    insertSql.setLength(insertSql.length() - 2);
                    valuesSql.setLength(valuesSql.length() - 2);
                    insertSql.append(valuesSql.toString()).append(");");

                    // 汎用的に処理を行うためリフレクションにより接続を取得します
                    java.lang.reflect.Method getConnectionMethod = dao.getClass().getSuperclass().getDeclaredMethod("getConnection");
                    getConnectionMethod.setAccessible(true);
                    try (Connection conn = (Connection) getConnectionMethod.invoke(dao);
                         PreparedStatement ps = conn.prepareStatement(insertSql.toString())) {
                        int idx = 1;
                        for (String val : insertValues) {
                            ps.setString(idx++, val.trim());
                        }
                        int count = ps.executeUpdate();
                        successMessage = "新規レコードを追加しました。追加件数: " + count;
                    }
                }
            } else {
                // グリッドからのインライン編集または物理削除が実行された場合の処理です
                List<String> whereKeyList = new ArrayList<String>();
                for (String key : paramMap.keySet()) {
                    if (key.startsWith("where_")) {
                        whereKeyList.add(key);
                    }
                }
                String[] whereKeys = whereKeyList.toArray(new String[0]);

                if ("update_record".equals(mode)) {
                    int count = dao.updateRecord(table, paramMap, whereKeys);
                    successMessage = "レコードを更新しました。影響件数: " + count;
                } else if ("delete_record".equals(mode)) {
                    int count = dao.deleteRecord(table, paramMap, whereKeys);
                    successMessage = "レコードを削除しました。影響件数: " + count;
                }
            }
        }
    }

    // 最新のテーブル一覧構造を取得します
    tables = dao.getTables();

    // 各テーブルの列構造をメタデータから解析します
    if (tables != null) {
        java.lang.reflect.Method getConnectionMethod = dao.getClass().getSuperclass().getDeclaredMethod("getConnection");
        getConnectionMethod.setAccessible(true);
        try (Connection conn = (Connection) getConnectionMethod.invoke(dao)) {
            DatabaseMetaData meta = conn.getMetaData();
            for (String tName : tables) {
                try (ResultSet rsCols = meta.getColumns(null, null, tName, null)) {
                    while (rsCols.next()) {
                        String colName = rsCols.getString("COLUMN_NAME");
                        int dataType = rsCols.getInt("DATA_TYPE");

                        // 現在選択されているテーブルである場合は詳細メタ情報をフォーム生成用に記録します
                        if (tName.equals(table)) {
                            Map<String, Object> colMap = new LinkedHashMap<String, Object>();
                            colMap.put("COLUMN_NAME", colName);
                            colMap.put("DATA_TYPE", dataType);
                            columnMetaList.add(colMap);
                        }
                    }
                }
            }
        }
    }

    // SQLテキストエリアからクエリが直接実行（送信）された場合のコマンド処理です
    if (userSql != null && !userSql.trim().isEmpty() && !"add_history".equals(mode)) {
        try {
            sqlResult = dao.executeSql(userSql);
            if ("update".equals(sqlResult.get("type"))) {
                successMessage = "SQLの実行が完了しました。影響を受けた行数: " + sqlResult.get("count");
            }
            tables = dao.getTables();
        } catch (Exception ex) {
            errorMessage = ex.getMessage();
        }
    }

    // 選択されたテーブルの全レコード情報を制約なしでロードします
    if (table != null) {
        data = dao.getData(table);
    }

} catch (Exception e) {
    errorMessage = e.getMessage();
}
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - データベース管理サイト</title>
    <style>
        body { font-family: 'Helvetica Neue', Arial, sans-serif; margin: 30px; background-color: #f4f6f9; color: #333; }
        h2 { font-weight: 500; margin-bottom: 25px; color: #2c3e50; }
        h3 { font-weight: 500; margin-top: 0; color: #34495e; border-bottom: 2px solid #ecf0f1; padding-bottom: 8px; }
        
        .layout-container { display: flex; gap: 25px; align-items: flex-start; }
        .sidebar-panel { width: 240px; background: #ffffff; padding: 20px; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .main-panel { flex: 1; background: #ffffff; padding: 20px; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); min-width: 0; }
        
        .spec-section { background: #ffffff; padding: 20px; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); margin-bottom: 25px; border-left: 5px solid #17a2b8; }
        .spec-toggle { background: #17a2b8; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; }
        .spec-toggle:hover { background: #138496; }
        .spec-content { display: none; margin-top: 15px; border-top: 1px solid #e9ecef; padding-top: 15px; }
        .spec-grid { display: flex; gap: 20px; flex-wrap: wrap; }
        .spec-card { flex: 1; min-width: 300px; background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 4px; padding: 15px; }
        .spec-card h4 { margin-top: 0; color: #2c3e50; border-bottom: 1px solid #ced4da; padding-bottom: 5px; font-size: 14px; }
        .spec-card p, .spec-card ul { font-size: 12px; line-height: 1.6; margin: 5px 0; }
        .spec-card ul { padding-left: 20px; }
        
        .sql-input-panel { background: #ffffff; padding: 20px; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); margin-bottom: 25px; }
        textarea { width: 100%; height: 100px; font-family: 'Courier New', Courier, monospace; font-size: 14px; padding: 12px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; resize: vertical; }
        .button-group { margin-top: 12px; display: flex; gap: 10px; }
        
        .history-container { margin-top: 15px; background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 4px; padding: 12px; }
        .history-title { font-size: 13px; font-weight: bold; color: #495057; margin-bottom: 8px; display: flex; justify-content: space-between; align-items: center; }
        .history-list { list-style: none; padding: 0; margin: 0; max-height: 150px; overflow-y: auto; }
        .history-item { font-family: monospace; font-size: 12px; padding: 6px 8px; background: #fff; border: 1px solid #dee2e6; border-radius: 3px; margin-bottom: 6px; cursor: pointer; display: flex; justify-content: space-between; align-items: center; }
        .history-item:hover { background: #e9ecef; }
        .history-text { flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        
        .data-table { border-collapse: collapse; width: 100%; margin-top: 15px; background-color: #fff; }
        .data-table th, .data-table td { border: 1px solid #dee2e6; padding: 8px 10px; text-align: left; font-size: 13px; }
        .data-table th { background-color: #f8f9fa; color: #495057; font-weight: 600; }
        .data-table tr:hover { background-color: #f1f3f5; }
        
        .cell-input { width: 100%; box-sizing: border-box; padding: 4px; border: 1px solid #ccc; border-radius: 3px; font-size: 13px; }
        
        .insert-form-panel { margin-top: 25px; padding: 15px; background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 6px; }
        .insert-grid { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 12px; }
        .insert-field { display: flex; flex-direction: column; min-width: 120px; flex: 1; }
        .insert-field label { font-size: 12px; font-weight: bold; color: #495057; margin-bottom: 4px; }
        
        .btn-submit { background: #007bff; color: #ffffff; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-size: 13px; }
        .btn-submit:hover { background: #0069d9; }
        .btn-secondary { background: #6c757d; color: #ffffff; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-size: 13px; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-link-style { background: none; border: none; color: #dc3545; cursor: pointer; font-size: 11px; padding: 0; text-decoration: underline; }
        
        .btn-action { padding: 4px 8px; border: none; border-radius: 3px; cursor: pointer; font-size: 11px; color: white; }
        .btn-save { background: #28a745; }
        .btn-save:hover { background: #218838; }
        .btn-delete { background: #dc3545; }
        .btn-delete:hover { background: #c82333; }
        
        .table-item-box { border-bottom: 1px solid #f1f3f5; padding: 6px 0; }
        .table-item-box:last-child { border-bottom: none; }
        .table-link { color: #007bff; text-decoration: none; font-weight: bold; display: block; padding: 4px 8px; border-radius: 4px; }
        .table-link:hover { background-color: #f1f3f5; text-decoration: underline; }
        .sidebar-list { list-style: none; padding: 0; margin: 0; }
        
        .message-box { padding: 12px 15px; margin-bottom: 20px; border-radius: 4px; font-size: 14px; }
        .message-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message-danger { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; font-family: monospace; }
        .text-empty { color: #6c757d; font-style: italic; }
        .code-block { background: #272822; color: #f8f8f2; padding: 8px; border-radius: 4px; font-family: monospace; font-size: 11px; margin: 5px 0; overflow-x: auto; white-space: pre; }
    </style>
</head>
<body>

<h2>得点管理システム - データベース管理サイト</h2>
<h3>これにより、H2 Databaseを開かなくても編集ができます</h3>

<% if (successMessage != null) { %>
    <div class="message-box message-success"><%= successMessage %></div>
<% } %>
<% if (errorMessage != null) { %>
    <div class="message-box message-danger">システムエラー: <%= errorMessage %></div>
<% } %>

<div class="spec-section">
    <button type="button" class="spec-toggle" onclick="toggleSpec()">サイトの簡易詳細・システム仕様を表示</button>
    <div id="specContent" class="spec-content">
        <div class="spec-grid">
            <div class="spec-card">
                <h4>1. この画面の役割（概要）</h4>
                <p>得点管理システムの開発・デバッグ環境におけるデータ操作を効率化するための内製コンソール画面です。通常、組み込み型のH2データベースの内容を確認・操作するにはTomcat等のWebサーバーとコンソールサーバーを切り替える必要がありますが、本画面の導入によりEclipse上のTomcatを稼働させた状態のまま、ブラウザ上でリアルタイムなCRUD操作（登録・参照・更新・削除）をワンストップで実行可能にしています。</p>
            </div>
            <div class="spec-card">
                <h4>2. 主要機能と設計仕様</h4>
                <ul>
                    <li><strong>SQL直接実行機能:</strong> 画面上部のテキストエリアから、データ定義言語（DDL）およびデータ操作言語（DML）を入力して直接実行可能です。SELECTクエリ実行時は専用グリッドへ結果を出力し、INSERTやDROP等の変更クエリ実行時は、内部のメタデータを再ロードしてサイドバーのテーブル一覧へ即座に同期します。</li>
                    <li><strong>インライン編集・削除機能:</strong> 選択したテーブルの全データをグリッド出力します。H2 Consoleと同様の操作性を実現するため、各セルをテキストボックス化し、主キーによる行特定用の隠しパラメータ（WHERE句自動生成用引数）を裏で保持しています。保存ボタン押下で動的なUPDATE文、削除ボタン押下で動的なDELETE文を組み立ててデータベースへ直接作用させます。</li>
                </ul>
            </div>
            <div class="spec-card">
                <h4>3. スキーマ構成と検証用クエリ</h4>
                <p><strong>連動テーブル型定義:</strong></p>
                <ul>
                    <li>CLASS_NUM（クラス情報）/ SUBJECT（科目）/ STUDENT（学生）/ TEST（得点データ）</li>
                </ul>
                <p style="margin-top: 10px;"><strong>テストデータ整合性確認用ショートカットクエリ:</strong></p>
                <div class="code-block">-- CHAR型の余白詰まり（空白問題）を検出するクエリ
SELECT NO, LENGTH(NO) FROM STUDENT WHERE LENGTH(NO) &gt; 3;</div>
                <div class="code-block">-- テスト用の得点ダミーデータを一括削除するクエリ
DELETE FROM TEST WHERE POINT = 0;</div>
            </div>
        </div>
    </div>
</div>

<div class="sql-input-panel">
    <h3>SQLコマンド直接実行</h3>
    <form id="sqlForm" action="DB.jsp" method="post">
        <input type="hidden" id="formMode" name="mode" value="">
        <textarea id="userSql" name="userSql" placeholder="SQL文を入力してください"><%= userSql != null ? userSql : "" %></textarea>
        
        <div class="button-group">
            <button type="submit" class="btn-submit" onclick="setMode('')">SQL文を実行する</button>
            <button type="submit" class="btn-secondary" onclick="setMode('add_history')">クエリを履歴に追加</button>
        </div>
    </form>

    <div class="history-container">
        <div class="history-title">
            <span>クエリ履歴一覧 (クリックでテキストエリアにロードされます)</span>
            <form action="DB.jsp" method="post" style="margin:0; display:inline;">
                <input type="hidden" name="mode" value="clear_history">
                <button type="submit" class="btn-link-style" onclick="return confirm('履歴をすべてクリアしますか？');">履歴を全消去</button>
            </form>
        </div>
        <ul class="history-list">
        <% if (queryHistory != null && !queryHistory.isEmpty()) { %>
            <% for (String histSql : queryHistory) { %>
                <li class="history-item" onclick="loadQuery(this)">
                    <span class="history-text"><%= histSql %></span>
                </li>
            <% } %>
        <% } else { %>
            <li class="text-empty" style="font-size: 12px; padding: 5px;">登録されている履歴クエリはありません</li>
        <% } %>
        </ul>
    </div>
</div>

<div class="layout-container">
    <div class="sidebar-panel">
        <h3>テーブル一覧</h3>
        <ul class="sidebar-list">
        <% if (tables != null && !tables.isEmpty()) { %>
            <% for (String t : tables) { %>
                <li class="table-item-box">
                    <a href="?table=<%= t %>" class="table-link"><%= t %></a>
                </li>
            <% } %>
        <% } else { %>
            <li class="text-empty">対象のテーブルが存在しません</li>
        <% } %>
        </ul>
    </div>

    <div class="main-panel">
        <% if (sqlResult != null && "select".equals(sqlResult.get("type"))) { %>
            <h3>入力クエリの実行結果</h3>
            <% List<Map<String, Object>> selectData = (List<Map<String, Object>>) sqlResult.get("data"); %>
            <% if (selectData != null && !selectData.isEmpty()) { %>
                <table class="data-table">
                    <thead>
                        <tr>
                        <% for (String col : selectData.get(0).keySet()) { %>
                            <th><%= col %></th>
                        <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> row : selectData) { %>
                            <tr>
                            <% for (Object val : row.values()) { %>
                                <td><%= val != null ? val : "" %></td>
                            <% } %>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="text-empty">該当データは0件でした。</p>
            <% } %>
        <% } %>

        <% if (table != null) { %>
            <h3>表示中のテーブル: <%= table %> (全件数表示)</h3>
            <% if (data != null && !data.isEmpty()) { %>
                <table class="data-table">
                    <thead>
                        <tr>
                        <% for (String col : data.get(0).keySet()) { %>
                            <th><%= col %></th>
                        <% } %>
                            <th style="width: 110px;">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> row : data) { %>
                            <tr>
                                <form action="DB.jsp" method="post" style="margin:0; padding:0;">
                                    <input type="hidden" name="table" value="<%= table %>">
                                    <input type="hidden" name="mode" value="update_record">
                                    
                                    <% for (Map.Entry<String, Object> entry : row.entrySet()) { %>
                                        <% String currentVal = entry.getValue() != null ? entry.getValue().toString() : ""; %>
                                        <td>
                                            <input type="hidden" name="where_<%= entry.getKey() %>" value="<%= currentVal %>">
                                            <input type="text" name="cell_<%= entry.getKey() %>" value="<%= currentVal %>" class="cell-input">
                                        </td>
                                    <% } %>
                                    <td>
                                        <button type="submit" class="btn-action btn-save">保存</button>
                                </form>
                                <form action="DB.jsp" method="post" style="display:inline; margin:0; padding:0;">
                                    <input type="hidden" name="table" value="<%= table %>">
                                    <input type="hidden" name="mode" value="delete_record">
                                    <% for (Map.Entry<String, Object> entry : row.entrySet()) { %>
                                        <input type="hidden" name="where_<%= entry.getKey() %>" value="<%= entry.getValue() != null ? entry.getValue().toString() : "" %>">
                                    <% } %>
                                    <button type="submit" class="btn-action btn-delete" onclick="return confirm('このレコードを削除しますか？');">削除</button>
                                </form>
                                    </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="text-empty">テーブル内にデータが存在しません。</p>
            <% } %>

            <% if (!columnMetaList.isEmpty()) { %>
                <div class="insert-form-panel">
                    <h4 style="margin-top: 0; margin-bottom: 12px; font-size: 14px; color: #2c3e50;"><%= table %> テーブルへの新規レコード追加</h4>
                    <form action="DB.jsp" method="post" style="margin: 0;">
                        <input type="hidden" name="table" value="<%= table %>">
                        <input type="hidden" name="mode" value="insert_record">
                        
                        <div class="insert-grid">
                            <% for (Map<String, Object> colMeta : columnMetaList) { %>
                                <% 
                                String cName = (String) colMeta.get("COLUMN_NAME");
                                int dType = (Integer) colMeta.get("DATA_TYPE");
                                %>
                                <div class="insert-field">
                                    <label for="ins_<%= cName %>"><%= cName %></label>
                                    <% if (dType == Types.BOOLEAN || dType == Types.BIT) { %>
                                        <select id="ins_<%= cName %>" name="insert_<%= cName %>" class="cell-input" style="padding: 5px;">
                                            <option value="TRUE">TRUE</option>
                                            <option value="FALSE">FALSE</option>
                                        </select>
                                    <% } else { %>
                                        <input type="text" id="ins_<%= cName %>" name="insert_<%= cName %>" class="cell-input" style="padding: 5px;" placeholder="<%= (dType == Types.INTEGER || dType == Types.BIGINT || dType == Types.SMALLINT || dType == Types.TINYINT) ? "0" : "" %>">
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                        <button type="submit" class="btn-submit" style="background-color: #28a745;">この内容で新規レコードを追加する</button>
                    </form>
                </div>
            <% } %>
        <% } %>
    </div>
</div>

<script>
function toggleSpec() {
    var content = document.getElementById("specContent");
    if (content.style.display === "block") {
        content.style.display = "none";
    } else {
        content.style.display = "block";
    }
}

function setMode(modeValue) {
    document.getElementById("formMode").value = modeValue;
}

function loadQuery(element) {
    var sqlText = element.getElementsByClassName("history-text")[0].innerText;
    document.getElementById("userSql").value = sqlText;
}
</script>

</body>
</html>