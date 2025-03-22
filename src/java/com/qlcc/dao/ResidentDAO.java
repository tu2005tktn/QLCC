// ResidentDAO.java
package com.qlcc.dao;

import com.qlcc.model.Resident;
import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ResidentDAO {
    
    public List<Resident> getAllResidents() {
        List<Resident> residents = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT r.*, a.apartment_number " +
                         "FROM Residents r " +
                         "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                         "ORDER BY a.apartment_number, r.full_name";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setResidentId(rs.getInt("resident_id"));
                resident.setApartmentId(rs.getInt("apartment_id"));
                resident.setFullName(rs.getString("full_name"));
                resident.setDob(rs.getDate("dob"));
                resident.setGender(rs.getString("gender"));
                resident.setIdCard(rs.getString("id_card"));
                resident.setRelationship(rs.getString("relationship"));
                resident.setPhone(rs.getString("phone"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                resident.setApartment(apartment);
                
                residents.add(resident);
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
        
        return residents;
    }
    
    public Resident getResidentById(int residentId) {
        Resident resident = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT r.*, a.apartment_number " +
                         "FROM Residents r " +
                         "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                         "WHERE r.resident_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, residentId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                resident = new Resident();
                resident.setResidentId(rs.getInt("resident_id"));
                resident.setApartmentId(rs.getInt("apartment_id"));
                resident.setFullName(rs.getString("full_name"));
                resident.setDob(rs.getDate("dob"));
                resident.setGender(rs.getString("gender"));
                resident.setIdCard(rs.getString("id_card"));
                resident.setRelationship(rs.getString("relationship"));
                resident.setPhone(rs.getString("phone"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                resident.setApartment(apartment);
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
        
        return resident;
    }
    
    public List<Resident> getResidentsByApartment(int apartmentId) {
        List<Resident> residents = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT r.*, a.apartment_number " +
                         "FROM Residents r " +
                         "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                         "WHERE r.apartment_id = ? " +
                         "ORDER BY r.relationship, r.full_name";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setResidentId(rs.getInt("resident_id"));
                resident.setApartmentId(rs.getInt("apartment_id"));
                resident.setFullName(rs.getString("full_name"));
                resident.setDob(rs.getDate("dob"));
                resident.setGender(rs.getString("gender"));
                resident.setIdCard(rs.getString("id_card"));
                resident.setRelationship(rs.getString("relationship"));
                resident.setPhone(rs.getString("phone"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                resident.setApartment(apartment);
                
                residents.add(resident);
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
        
        return residents;
    }
    
    public boolean addResident(Resident resident) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Residents (apartment_id, full_name, dob, gender, id_card, relationship, phone) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, resident.getApartmentId());
            pstmt.setString(2, resident.getFullName());
            
            if (resident.getDob() != null) {
                pstmt.setDate(3, new java.sql.Date(resident.getDob().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.DATE);
            }
            
            pstmt.setString(4, resident.getGender());
            pstmt.setString(5, resident.getIdCard());
            pstmt.setString(6, resident.getRelationship());
            pstmt.setString(7, resident.getPhone());
            
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
    
    public boolean updateResident(Resident resident) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Residents SET apartment_id = ?, full_name = ?, dob = ?, gender = ?, " +
                         "id_card = ?, relationship = ?, phone = ? " +
                         "WHERE resident_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, resident.getApartmentId());
            pstmt.setString(2, resident.getFullName());
            
            if (resident.getDob() != null) {
                pstmt.setDate(3, new java.sql.Date(resident.getDob().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.DATE);
            }
            
            pstmt.setString(4, resident.getGender());
            pstmt.setString(5, resident.getIdCard());
            pstmt.setString(6, resident.getRelationship());
            pstmt.setString(7, resident.getPhone());
            pstmt.setInt(8, resident.getResidentId());
            
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
    
    public boolean deleteResident(int residentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Residents WHERE resident_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, residentId);
            
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