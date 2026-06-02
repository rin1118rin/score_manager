package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDao extends Dao {
	
	private String baseSql = "SELECT * FROM TEST WHERE SCHOOL_CD=?";
	
	public Test get(Student student,Subject subject,School school,int no) throws Exception {
		
		Test test = new Test();
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		String condition = " AND STUDENT_NO=?";
		
		String order = " AND SUBJECT_CD=?";
		
		String condition2 = " AND NO=?";
		
		try {
			statement = connection.prepareStatement(baseSql + condition + order + condition2);
			
			statement.setString(1, school.getCd());
			statement.setString(2, student.getNo());
			statement.setString(3, subject.getCd());
			statement.setInt(4, no); 
			
			ResultSet rSet = statement.executeQuery();
			
			if (rSet.next()) {
				
				test.setNo(rSet.getInt("NO"));
				test.setPoint(rSet.getInt("POINT"));
				test.setStudent(student);
				test.setSubject(subject);
				test.setSchool(school);
			} else {
				test = null;
			}
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
		return test;
	}
	
	public List<Test> postFilter(ResultSet rSet,School school) throws Exception {
		
		List<Test> list = new ArrayList<>();
		
		
	}
	
	public List<Test> filter(int entYear,String classNum,Subject subject,int num,School school) throws Exception {
		
	}
	
	public boolean sava(List<Test> list) throws Exception {
		
	}
	
	private boolean save(Test test,Connection connection) throws Exception {
		
	}
}
