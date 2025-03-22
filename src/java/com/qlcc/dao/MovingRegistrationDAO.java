// MovingRegistrationDAO.java
package com.qlcc.dao;

import com.qlcc.model.MovingRegistration;
import com.qlcc.model.User;
import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class MovingRegistrationDAO {
    
    public List<MovingRegistration> getAllMovingRegistrations() {
        List<MovingRegistration> registrations = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT mr.*, a.apartment_number, r.full_name as requester_name, ap.full_name as approver_name " +
                         "FROM MovingRegistrations mr " +
                         "JOIN Apartments a ON mr.apartment_id = a.apartment_id " +
                         "JOIN Users r ON mr.requester_id = r.user_id " +
                         "LEFT JOIN Users ap ON mr.approved_by = ap.user_id " +
                         "ORDER BY mr.moving_date DESC, mr.moving_time_start DESC";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                MovingRegistration registration = new MovingRegistration();
                registration.setMovingId(rs.getInt("moving_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setMovingType(rs.getString("moving_type"));
                registration.setMovingDate(rs.getDate("moving_date"));
                registration.setMovingTimeStart(rs.getTime("moving_time_start"));
                registration.setMovingTimeEnd(rs.getTime("moving_time_end"));
                registration.setItemsDescription(rs.getString("items_description"));
                registration.setStatus(rs.getString("status"));
                registration.setApprovalDate(rs.getTimestamp("approval_date"));
                
                Integer approvedBy = rs.getInt("approved_by");
                if (!rs.wasNull()) {
                    registration.setApprovedBy(approvedBy);
                }
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                registration.setApartment(apartment);
                
                // Đối tượng User (Requester)
                User requester = new User();
                requester.setUserId(rs.getInt("requester_id"));
                requester.setFullName(rs.getString("requester_name"));
                registration.setRequester(requester);
                
                // Đối tượng User (Approver), nếu có
                if (registration.getApprovedBy() != null) {
                    User approver = new User();
                    approver.setUserId(registration.getApprovedBy());
                    approver.setFullName(rs.getString("approver_name"));
                    registration.setApprover(approver);
                }
                
                registrations.add(registration);
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
        
        return registrations;
    }
    
    public MovingRegistration getMovingRegistrationById(int movingId) {
        MovingRegistration registration = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT mr.*, a.apartment_number, r.full_name as requester_name, ap.full_name as approver_name " +
                         "FROM MovingRegistrations mr " +
                         "JOIN Apartments a ON mr.apartment_id = a.apartment_id " +
                         "JOIN Users r ON mr.requester_id = r.user_id " +
                         "LEFT JOIN Users ap ON mr.approved_by = ap.user_id " +
                         "WHERE mr.moving_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, movingId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                registration = new MovingRegistration();
                registration.setMovingId(rs.getInt("moving_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setMovingType(rs.getString("moving_type"));
                registration.setMovingDate(rs.getDate("moving_date"));
                registration.setMovingTimeStart(rs.getTime("moving_time_start"));
                registration.setMovingTimeEnd(rs.getTime("moving_time_end"));
                registration.setItemsDescription(rs.getString("items_description"));
                registration.setStatus(rs.getString("status"));
                registration.setApprovalDate(rs.getTimestamp("approval_date"));
                
                Integer approvedBy = rs.getInt("approved_by");
                if (!rs.wasNull()) {
                    registration.setApprovedBy(approvedBy);
                }
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                registration.setApartment(apartment);
                
                // Đối tượng User (Requester)
                User requester = new User();
                requester.setUserId(rs.getInt("requester_id"));
                requester.setFullName(rs.getString("requester_name"));
                registration.setRequester(requester);
                
                // Đối tượng User (Approver), nếu có
                if (registration.getApprovedBy() != null) {
                    User approver = new User();
                    approver.setUserId(registration.getApprovedBy());
                    approver.setFullName(rs.getString("approver_name"));
                    registration.setApprover(approver);
                }
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
        
        return registration;
    }
    
    public List<MovingRegistration> getMovingRegistrationsByApartment(int apartmentId) {
        List<MovingRegistration> registrations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT mr.*, a.apartment_number, r.full_name as requester_name, ap.full_name as approver_name " +
                         "FROM MovingRegistrations mr " +
                         "JOIN Apartments a ON mr.apartment_id = a.apartment_id " +
                         "JOIN Users r ON mr.requester_id = r.user_id " +
                         "LEFT JOIN Users ap ON mr.approved_by = ap.user_id " +
                         "WHERE mr.apartment_id = ? " +
                         "ORDER BY mr.moving_date DESC, mr.moving_time_start DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MovingRegistration registration = new MovingRegistration();
                registration.setMovingId(rs.getInt("moving_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setMovingType(rs.getString("moving_type"));
                registration.setMovingDate(rs.getDate("moving_date"));
                registration.setMovingTimeStart(rs.getTime("moving_time_start"));
                registration.setMovingTimeEnd(rs.getTime("moving_time_end"));
                registration.setItemsDescription(rs.getString("items_description"));
                registration.setStatus(rs.getString("status"));
                registration.setApprovalDate(rs.getTimestamp("approval_date"));
                
                Integer approvedBy = rs.getInt("approved_by");
                if (!rs.wasNull()) {
                    registration.setApprovedBy(approvedBy);
                }
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                registration.setApartment(apartment);
                
                // Đối tượng User (Requester)
                User requester = new User();
                requester.setUserId(rs.getInt("requester_id"));
                requester.setFullName(rs.getString("requester_name"));
                registration.setRequester(requester);
                
                // Đối tượng User (Approver), nếu có
                if (registration.getApprovedBy() != null) {
                    User approver = new User();
                    approver.setUserId(registration.getApprovedBy());
                    approver.setFullName(rs.getString("approver_name"));
                    registration.setApprover(approver);
                }
                
                registrations.add(registration);
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
        
        return registrations;
    }
    
    public List<MovingRegistration> getMovingRegistrationsByStatus(String status) {
        List<MovingRegistration> registrations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT mr.*, a.apartment_number, r.full_name as requester_name, ap.full_name as approver_name " +
                         "FROM MovingRegistrations mr " +
                         "JOIN Apartments a ON mr.apartment_id = a.apartment_id " +
                         "JOIN Users r ON mr.requester_id = r.user_id " +
                         "LEFT JOIN Users ap ON mr.approved_by = ap.user_id " +
                         "WHERE mr.status = ? " +
                         "ORDER BY mr.moving_date DESC, mr.moving_time_start DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MovingRegistration registration = new MovingRegistration();
                registration.setMovingId(rs.getInt("moving_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setMovingType(rs.getString("moving_type"));
                registration.setMovingDate(rs.getDate("moving_date"));
                registration.setMovingTimeStart(rs.getTime("moving_time_start"));
                registration.setMovingTimeEnd(rs.getTime("moving_time_end"));
                registration.setItemsDescription(rs.getString("items_description"));
                registration.setStatus(rs.getString("status"));
                registration.setApprovalDate(rs.getTimestamp("approval_date"));
                
                Integer approvedBy = rs.getInt("approved_by");
                if (!rs.wasNull()) {
                    registration.setApprovedBy(approvedBy);
                }
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                registration.setApartment(apartment);
                
                // Đối tượng User (Requester)
                User requester = new User();
                requester.setUserId(rs.getInt("requester_id"));
                requester.setFullName(rs.getString("requester_name"));
                registration.setRequester(requester);
                
                // Đối tượng User (Approver), nếu có
                if (registration.getApprovedBy() != null) {
                    User approver = new User();
                    approver.setUserId(registration.getApprovedBy());
                    approver.setFullName(rs.getString("approver_name"));
                    registration.setApprover(approver);
                }
                
                registrations.add(registration);
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
        
        return registrations;
    }
    
    public boolean createMovingRegistration(MovingRegistration registration) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO MovingRegistrations (apartment_id, requester_id, moving_type, moving_date, " +
                         "moving_time_start, moving_time_end, items_description, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, registration.getApartmentId());
            pstmt.setInt(2, registration.getRequesterId());
            pstmt.setString(3, registration.getMovingType());
            pstmt.setDate(4, new java.sql.Date(registration.getMovingDate().getTime()));
            pstmt.setTime(5, registration.getMovingTimeStart());
            pstmt.setTime(6, registration.getMovingTimeEnd());
            pstmt.setString(7, registration.getItemsDescription());
            pstmt.setString(8, "Đang chờ phê duyệt");
            
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
    
    public boolean updateMovingRegistration(MovingRegistration registration) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("UPDATE MovingRegistrations SET moving_type = ?, moving_date = ?, ");
            sqlBuilder.append("moving_time_start = ?, moving_time_end = ?, items_description = ?, status = ?");
            
            if (registration.getApprovalDate() != null && registration.getApprovedBy() != null) {
                sqlBuilder.append(", approval_date = ?, approved_by = ?");
            }
            
            sqlBuilder.append(" WHERE moving_id = ?");
            
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            pstmt.setString(1, registration.getMovingType());
            pstmt.setDate(2, new java.sql.Date(registration.getMovingDate().getTime()));
            pstmt.setTime(3, registration.getMovingTimeStart());
            pstmt.setTime(4, registration.getMovingTimeEnd());
            pstmt.setString(5, registration.getItemsDescription());
            pstmt.setString(6, registration.getStatus());
            
            int paramIndex = 7;
            
            if (registration.getApprovalDate() != null && registration.getApprovedBy() != null) {
                pstmt.setTimestamp(paramIndex++, new Timestamp(registration.getApprovalDate().getTime()));
                pstmt.setInt(paramIndex++, registration.getApprovedBy());
            }
            
            pstmt.setInt(paramIndex, registration.getMovingId());
            
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
    
    public boolean deleteMovingRegistration(int movingId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM MovingRegistrations WHERE moving_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, movingId);
            
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