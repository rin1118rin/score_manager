package dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class TableDao extends Dao {

    // データベース内に存在するテーブル名の一覧を取得します
    public List<String> getTables() throws Exception {
        List<String> list = new ArrayList<>();

        try (Connection conn = getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getTables(null, null, "%", new String[]{"TABLE"});

            while (rs.next()) {
                list.add(rs.getString("TABLE_NAME"));
            }
        }
        return list;
    }

    // 指定されたテーブルのレコードを全件取得します
    public List<Map<String, Object>> getData(String table) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        // テーブル名はプレースホルダーにできないため直接結合します
        String sql = "SELECT * FROM " + table;

        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            ResultSetMetaData meta = rs.getMetaData();
            int cols = meta.getColumnCount();

            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= cols; i++) {
                    row.put(meta.getColumnName(i), rs.getObject(i));
                }
                list.add(row);
            }
        }
        return list;
    }

    // 入力された任意のSQL文を解析し結果をマップ型で返却します
    public Map<String, Object> executeSql(String sql) throws Exception {
        Map<String, Object> resultMap = new LinkedHashMap<>();
        
        try (Connection conn = getConnection();
             Statement st = conn.createStatement()) {
            
            boolean hasResultSet = st.execute(sql);
            
            if (hasResultSet) {
                try (ResultSet rs = st.getResultSet()) {
                    ResultSetMetaData meta = rs.getMetaData();
                    int cols = meta.getColumnCount();
                    List<Map<String, Object>> list = new ArrayList<>();
                    
                    while (rs.next()) {
                        Map<String, Object> row = new LinkedHashMap<>();
                        for (int i = 1; i <= cols; i++) {
                            row.put(meta.getColumnName(i), rs.getObject(i));
                        }
                        list.add(row);
                    }
                    resultMap.put("type", "select");
                    resultMap.put("data", list);
                }
            } else {
                int updateCount = st.getUpdateCount();
                resultMap.put("type", "update");
                resultMap.put("count", updateCount);
            }
        }
        return resultMap;
    }

    // 特定のレコードを更新するためのUPDATE文を動的に生成して実行します
    public int updateRecord(String table, Map<String, String[]> parameters, String[] whereKeys) throws Exception {
        StringBuilder sql = new StringBuilder("UPDATE " + table + " SET ");
        List<String> setValues = new ArrayList<>();
        List<String> whereValues = new ArrayList<>();

        // SET句の組み立てを行います
        for (String key : parameters.keySet()) {
            if (key.startsWith("cell_")) {
                String columnName = key.substring(5);
                sql.append(columnName).append(" = ?, ");
                setValues.add(parameters.get(key)[0]);
            }
        }
        sql.setLength(sql.length() - 2); // 末尾のカンマを除去します

        // WHERE句の組み立てを行います
        sql.append(" WHERE ");
        for (String whereKey : whereKeys) {
            String columnName = whereKey.substring(6);
            sql.append(columnName).append(" = ? AND ");
            whereValues.add(parameters.get(whereKey)[0]);
        }
        sql.setLength(sql.length() - 5); // 末尾のANDを除去します

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int idx = 1;
            for (String val : setValues) {
                ps.setString(idx++, val);
            }
            for (String val : whereValues) {
                ps.setString(idx++, val);
            }
            return ps.executeUpdate();
        }
    }

    // 特定のレコードを削除するためのDELETE文を動的に生成して実行します
    public int deleteRecord(String table, Map<String, String[]> parameters, String[] whereKeys) throws Exception {
        StringBuilder sql = new StringBuilder("DELETE FROM " + table + " WHERE ");
        List<String> whereValues = new ArrayList<>();

        for (String whereKey : whereKeys) {
            String columnName = whereKey.substring(6);
            sql.append(columnName).append(" = ? AND ");
            whereValues.add(parameters.get(whereKey)[0]);
        }
        sql.setLength(sql.length() - 5);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int idx = 1;
            for (String val : whereValues) {
                ps.setString(idx++, val);
            }
            return ps.executeUpdate();
        }
    }
}