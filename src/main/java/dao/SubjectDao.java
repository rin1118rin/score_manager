package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDao extends Dao {
	public Subject get(String cd, School school) throws Exception {
		
		Subject subject = new Subject();
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		try {
			statement = connection.prepareStatement("select * from subject where cd = ? and school_cd = ?");
			
			statement.setString(1, cd);
			
			statement.setString(2, school.getCd());
			
			ResultSet rSet = statement.executeQuery();
			
			SchoolDao sDao = new SchoolDao();
			if (rSet.next()) {
				
				subject.setCd(rSet.getString("cd"));
			
				subject.setSchool(sDao.get(rSet.getString("school_cd")));
			} else {
				subject = null;
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
		return subject;
	}
	
	public List<Subject> filter(School school) throws Exception {
		
		List<Subject> list = new ArrayList<>();
		
		Connection connection = getConnection();
		
		PreparedStatement statement = null;
		
		try {
			
			statement = connection.prepareStatement("select * from subject where school_cd = ? order by subject");
			
			statement.setString(1, school.getCd());
			
			ResultSet rSet = statement.executeQuery();
			
			SchoolDao sDao = new SchoolDao();
			
			while (rSet.next()) {
				
				Subject subject = new Subject();

				subject.setSchool(sDao.get(rSet.getString("school_cd")));
				subject.setCd(rSet.getString("cd"));
				subject.setName(rSet.getString("name"));
				
				list.add(subject);
				
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
		return list;
	}  
	
	public boolean save(Subject subject) throws Exception {
		
		Connection connection = getConnection();
		
	    PreparedStatement statement = null;
	    
	    int count = 0;
	    
	    try {
	    	Subject old = get(subject.getCd(), subject.getSchool());
	    	if (old == null) {
		    	statement = connection.prepareStatement("INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)");
		    	statement.setString(1, subject.getSchool().getCd());
		        statement.setString(2, subject.getCd());
		        statement.setString(3, subject.getName());
	    	} else {
	    		statement = connection.prepareStatement("UPDATE SUBJECT SET NAME=? WHERE SCHOOL_CD=? AND CD=?");
	    		statement.setString(3, subject.getName());
	    		statement.setString(1, subject.getSchool().getCd());
		        statement.setString(2, subject.getCd());
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
			if (connection != null) {
				try {
					connection.close();
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
	
	public boolean delete(Subject subject) throws Exception {
		
		Connection connection = getConnection();
		
	    PreparedStatement statement = null;
	    
	    int count = 0;
		
	    try {
	    	
	    	statement = connection.prepareStatement("DELETE FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?");
	    	
	    	statement.setString(1, subject.getSchool().getCd());
	    	
	        statement.setString(2, subject.getCd());
	        
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
			if (connection != null) {
				try {
					connection.close();
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