package com.me.lab8Student.dao;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;

import com.me.lab8Student.exception.AdvertException;
import com.me.lab8Student.pojo.Advert;

public class AdvertDAO extends DAO {
	public Advert create(Advert advert) throws AdvertException {
		try {
			begin();
			getSession().save(advert);
			commit();
			return advert;
		} catch (HibernateException e) {
			rollback();
			// throw new AdException("Could not create advert", e);
			throw new AdvertException("Exception while creating advert: " + e.getMessage());
		}
	}

	public void delete(Advert advert) throws AdvertException {
		try {
			begin();
			getSession().delete(advert);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new AdvertException("Could not delete advert", e);
		}
	}

	public List<Advert> list() throws AdvertException {

		try {
			begin();
			Query q = getSession().createQuery("from Advert");
			List<Advert> adverts = q.list();
			commit();
			return adverts;
		} catch (HibernateException e) {
			rollback();
			throw new AdvertException("Could not delete advert", e);
		}

	}

	

	public List<Advert> getMovie(String a) throws AdvertException{
		java.sql.Connection connection = null;
        String query = a;
        Statement stmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie", "root", "root");
            stmt = connection.createStatement();
        } catch (ClassNotFoundException ex) {
            System.out.println("ClassNotFoundException" + ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("SQLException" + ex.getMessage());
        }
        String sqlQuery="";
        
        sqlQuery = "select * from advert_table where title  LIKE '%" +query+"%'";
       
        
        ArrayList<Advert> mList = new ArrayList<Advert>();
        try {
            ResultSet rs = stmt.executeQuery(sqlQuery);

            while (rs.next()) {
                Advert m = new Advert();
                m.setTitle(rs.getString("title"));
                m.setDate(rs.getString("date"));
                m.setTime(rs.getString("time"));
                m.setMessage(rs.getString("message"));
                m.setPrice(rs.getDouble("price"));
                mList.add(m);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                System.out.println("SQLException" + ex.getMessage());
            }
        }

        return mList;
    }
    	
    
}
