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
			
			 String studentNo = rSet.getString("NO");

		        TestListSubject testListSubject = null;

		        for (TestListSubject t : list) {
		            if (t.getStudentNo().equals(studentNo)) {
		                testListSubject = t;
		                break;
		            }
		        }
		        if (testListSubject == null) {

		            testListSubject = new TestListSubject();

		            testListSubject.setEntYear(
		                rSet.getInt("ENT_YEAR")
		            );

		            testListSubject.setStudentNo(studentNo);

		            testListSubject.setStudentName(
		                rSet.getString("NAME")
		            );

		            testListSubject.setClassNum(
		                rSet.getString("CLASS_NUM")
		            );

		            list.add(testListSubject);
		        }

		        int testNo = rSet.getInt("TEST_NO");

		        if (!rSet.wasNull()) {
		            testListSubject.putPoint(
		                testNo,
		                rSet.getInt("POINT")
		            );
		        }
		        for (TestListSubject t : list) {
		            System.out.println(
		                t.getStudentNo() + " => " + t.getPoints()
		            );
		        }
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
