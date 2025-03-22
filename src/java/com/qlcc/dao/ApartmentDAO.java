// ApartmentDAO.java
package com.qlcc.dao;

import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ApartmentDAO {
    
    public List<Apartment> getAllApartments() {
        List<Apartment> apartments = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM Apartments";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                apartment.setFloorNumber(rs.getInt("floor_number"));
                apartment.setArea(rs.getDouble("area"));
                apartment.setStatus(rs.getString("status"));
                
                apartments.add(apartment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return apartments;
    }
    
    public Apartment getApartmentById(int apartmentId) {
        Apartment apartment = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Apartments WHERE apartment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                apartment.setFloorNumber(rs.getInt("floor_number"));
                apartment.setArea(rs.getDouble("area"));
                apartment.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return apartment;
    }
    
    public int getApartmentIdByUserId(int userId) {
        int apartmentId = -1;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT apartment_id FROM ApartmentOwners WHERE user_id = ? " +
                         "UNION " +
                         "SELECT apartment_id FROM Tenants WHERE user_id = ? AND is_representative = 1";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, userId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                apartmentId = rs.getInt("apartment_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return apartmentId;
    }
    
    public boolean addApartment(Apartment apartment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Apartments (apartment_number, floor_number, area, status) " +
                         "VALUES (?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, apartment.getApartmentNumber());
            pstmt.setInt(2, apartment.getFloorNumber());
            pstmt.setDouble(3, apartment.getArea());
            pstmt.setString(4, apartment.getStatus());
            
            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    public boolean updateApartment(Apartment apartment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Apartments SET apartment_number = ?, floor_number = ?, area = ?, status = ? " +
                         "WHERE apartment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, apartment.getApartmentNumber());
            pstmt.setInt(2, apartment.getFloorNumber());
            pstmt.setDouble(3, apartment.getArea());
            pstmt.setString(4, apartment.getStatus());
            pstmt.setInt(5, apartment.getApartmentId());
            
            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    public boolean deleteApartment(int apartmentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Apartments WHERE apartment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) DBConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
}