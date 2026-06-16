package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.TestListStudent;

public class TestListStudentDao extends Dao {
	
	private List<TestListStudent> postFilter(ResultSet rSet) throws Exception {
		
		List<TestListStudent> list = new ArrayList<>();
		
		while (rSet.next()) {
			
			
			TestListStudent testListStudent = new TestListStudent();

			testListStudent.setSubjectName(rSet.getString("NAME"));
			testListStudent.setSubjectCd(rSet.getString("SUBJECT_CD"));
			testListStudent.setNo(rSet.getInt("NO"));
			testListStudent.setPoint(rSet.getInt("POINT"));
			
			list.add(testListStudent);
			
		}
		return list;
		
	}
	
	public List<TestListStudent> filter(Student student) throws Exception {
		
		List<TestListStudent> list = new ArrayList<>();
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		ResultSet rSet = null;
		
		try {
			statement = connection.prepareStatement("SELECT T.SUBJECT_CD, S.NAME, T.NO, T.POINT FROM TEST T INNER JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD WHERE T.STUDENT_NO=? ORDER BY T.SUBJECT_CD, T.NO");
			
			statement.setString(1, student.getNo());
			
			rSet = statement.executeQuery();
			
			list = postFilter(rSet);
			
		} catch (Exception e) {
			throw e;
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}
		return list;
	}
}
