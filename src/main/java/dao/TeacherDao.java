package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.Teacher;

public class TeacherDao extends Dao {

    public Teacher login(
            String id,
            String password
    ) throws Exception {

        Teacher teacher = null;

        Connection connection =
            getConnection();

        PreparedStatement statement =
            connection.prepareStatement(
                "select * from teacher " +
                "where id = ? and password = ?"
            );

        statement.setString(1, id);
        statement.setString(2, password);

        ResultSet rSet =
            statement.executeQuery();

        if (rSet.next()) {

            teacher = new Teacher();

            teacher.setId(
                rSet.getString("id")
            );

            teacher.setName(
                rSet.getString("name")
            );
        }

        statement.close();
        connection.close();

        return teacher;
    }
}