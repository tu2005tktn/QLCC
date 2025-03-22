// ApartmentOwnerDAO.java
package com.qlcc.dao;

import com.qlcc.model.ApartmentOwner;
import com.qlcc.model.User;
import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ApartmentOwnerDAO {
    
    public ApartmentOwner getOwnerByApartmentId(int apartmentId) {
        ApartmentOwner owner = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT ao.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM ApartmentOwners ao " +
                         "JOIN Users u ON ao.user_id = u.user_id " +
                         "JOIN Apartments a ON ao.apartment_id = a.apartment_id " +
                         "WHERE ao.apartment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                owner = new ApartmentOwner();
                owner.setOwnerId(rs.getInt("owner_id"));
                owner.setUserId(rs.getInt("user_id"));
                owner.setApartmentId(rs.getInt("apartment_id"));
                owner.setOwnershipDate(rs.getDate("ownership_date"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                owner.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                owner.setApartment(apartment);
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
        
        return owner;
    }
    
    public ApartmentOwner getOwnerByUserId(int userId) {
        ApartmentOwner owner = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT ao.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM ApartmentOwners ao " +
                         "JOIN Users u ON ao.user_id = u.user_id " +
                         "JOIN Apartments a ON ao.apartment_id = a.apartment_id " +
                         "WHERE ao.user_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                owner = new ApartmentOwner();
                owner.setOwnerId(rs.getInt("owner_id"));
                owner.setUserId(rs.getInt("user_id"));
                owner.setApartmentId(rs.getInt("apartment_id"));
                owner.setOwnershipDate(rs.getDate("ownership_date"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                owner.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                owner.setApartment(apartment);
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
        
        return owner;
    }
    
    public List<ApartmentOwner> getAllOwners() {
        List<ApartmentOwner> owners = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT ao.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM ApartmentOwners ao " +
                         "JOIN Users u ON ao.user_id = u.user_id " +
                         "JOIN Apartments a ON ao.apartment_id = a.apartment_id " +
                         "ORDER BY a.apartment_number";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                ApartmentOwner owner = new ApartmentOwner();
                owner.setOwnerId(rs.getInt("owner_id"));
                owner.setUserId(rs.getInt("user_id"));
                owner.setApartmentId(rs.getInt("apartment_id"));
                owner.setOwnershipDate(rs.getDate("ownership_date"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                owner.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                owner.setApartment(apartment);
                
                owners.add(owner);
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
        
        return owners;
    }
    
    public boolean addOwner(ApartmentOwner owner) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO ApartmentOwners (user_id, apartment_id, ownership_date) " +
                         "VALUES (?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, owner.getUserId());
            pstmt.setInt(2, owner.getApartmentId());
            pstmt.setDate(3, new java.sql.Date(owner.getOwnershipDate().getTime()));
            
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
    
    public boolean updateOwner(ApartmentOwner owner) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE ApartmentOwners SET user_id = ?, apartment_id = ?, ownership_date = ? " +
                         "WHERE owner_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, owner.getUserId());
            pstmt.setInt(2, owner.getApartmentId());
            pstmt.setDate(3, new java.sql.Date(owner.getOwnershipDate().getTime()));
            pstmt.setInt(4, owner.getOwnerId());
            
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
    
    public boolean deleteOwner(int ownerId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM ApartmentOwners WHERE owner_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ownerId);
            
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