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
				
				test.setNo(rSet.getInt("no"));
				test.setPoint(rSet.getInt("point"));
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
		
		try {
			while (rSet.next()) {
				Test test = new Test();
				Subject subject = new Subject();
				Student student = new Student();
				
				student.setNo(rSet.getString("STUDENT_NO"));
			    student.setName(rSet.getString("NAME"));
			    student.setClassNum(rSet.getString("CLASS_NUM"));
			    student.setEntYear(rSet.getInt("ENT_YEAR"));

			    subject.setCd(rSet.getString("SUBJECT_CD"));

			    test.setStudent(student);
			    test.setSubject(subject);
			    test.setNo(rSet.getInt("NO"));
			    test.setPoint(rSet.getInt("POINT"));
			    test.setSchool(school);
			    test.setClassNum(rSet.getString("CLASS_NUM"));
				
				list.add(test);
			}
		} catch (SQLException | NullPointerException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<Test> filter(int entYear,String classNum,Subject subject,int no,School school) throws Exception {
		
		List<Test> list = new ArrayList<>();
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		ResultSet rSet = null;
		
		try {
			statement = connection.prepareStatement("SELECT * FROM TEST T INNER JOIN STUDENT S ON T.STUDENT_NO = S.NO WHERE T.SCHOOL_CD=? AND S.ENT_YEAR=? AND S.CLASS_NUM=? AND T.SUBJECT_CD=? AND T.NO=?");
			
			statement.setString(1, school.getCd());
			statement.setInt(2, entYear);
			statement.setString(3, classNum);
			statement.setString(4, subject.getCd());
			statement.setInt(5, no);
			
			System.out.println(statement);
			
			rSet = statement.executeQuery();
			
			list = postFilter(rSet, school);
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
	
	public boolean save(List<Test> list) throws Exception {
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		try {
			for (Test test : list) {
				save(test, connection);
			}
			return true;
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
	}
	
	private boolean save(Test test,Connection connection) throws Exception {
		
		PreparedStatement statement = null;
		
		int count = 0;
		
		try {
			Test old = get(test.getStudent(),test.getSubject(),test.getSchool(),test.getNo());
			
			if (old == null) {
				statement = connection.prepareStatement("INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES (?, ?, ?, ?, ?, ?)");
				
				statement.setString(1, test.getStudent().getNo());
	            statement.setString(2, test.getSubject().getCd());
	            statement.setString(3, test.getSchool().getCd());
	            statement.setInt(4, test.getNo());
	            statement.setInt(5, test.getPoint());
	            statement.setString(6, test.getClassNum());
			} else {
				statement = connection.prepareStatement("UPDATE TEST SET POINT=? WHERE STUDENT_NO=? AND SUBJECT_CD=? AND SCHOOL_CD=? AND NO=?");
				
				statement.setInt(1, test.getPoint());
	            statement.setString(2, test.getStudent().getNo());
	            statement.setString(3, test.getSubject().getCd());
	            statement.setString(4, test.getSchool().getCd());
	            statement.setInt(5, test.getNo());
			}
			count = statement.executeUpdate();
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
		}
		if (count > 0) {
			return true;
		} else {
			return false;
		}
		
	}
}
