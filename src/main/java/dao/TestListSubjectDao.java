package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDao extends Dao {
	
	private List<TestListSubject> postFilter(ResultSet rSet) throws Exception {
		
		List<TestListSubject> list = new ArrayList<>();
		
		while (rSet.next()) {
			
			TestListSubject testListSubject = new TestListSubject();
			
			testListSubject.setEntYear(rSet.getInt("entYear"));
			testListSubject.setStudentNo(rSet.getString("studentNo"));
			testListSubject.setStudentName(rSet.getString("studentName"));
			testListSubject.setClassNum(rSet.getString("classNum"));
			testListSubject.putPoint(rSet.getInt("no"), rSet.getInt("point"));
			
			list.add(testListSubject);
		}
		return list;
	}
	
	public List<TestListSubject> filter(int entYear,String classNum,Subject subject,School school) throws Exception {
		
		List<TestListSubject> list = new ArrayList<>();

	    Connection connection = getConnection();
	    
	    PreparedStatement statement = null;
	    
	    ResultSet rSet = null;
	    
	    try {
	    	
	    	statement = connection.prepareStatement("SELECT S.ENT_YEAR, S.NO, S.NAME, S.CLASS_NUM, T.NO AS TEST_NO, T.POINT FROM STUDENT S LEFT JOIN TEST T ON S.NO = T.STUDENT_NO AND T.SUBJECT_CD = ? AND T.SCHOOL_CD = ? WHERE S.ENT_YEAR = ? AND S.CLASS_NUM = ? AND S.SCHOOL_CD = ? ORDER BY S.NO, T.NO");
	    	
	    	statement.setString(1, subject.getCd());
	        statement.setString(2, school.getCd());
	        statement.setInt(3, entYear);
	        statement.setString(4, classNum);
	        statement.setString(5, school.getCd());
	        
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
