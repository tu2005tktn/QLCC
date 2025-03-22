// ServiceFeeDAO.java
package com.qlcc.dao;

import com.qlcc.model.Apartment;
import com.qlcc.model.ServiceFee;
import com.qlcc.model.ServiceType;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ServiceFeeDAO {
    
    public List<ServiceFee> getAllServiceFees() {
        List<ServiceFee> serviceFees = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT sf.*, a.apartment_number, st.type_name " +
                         "FROM ServiceFees sf " +
                         "JOIN Apartments a ON sf.apartment_id = a.apartment_id " +
                         "JOIN ServiceTypes st ON sf.service_type_id = st.service_type_id " +
                         "ORDER BY sf.year DESC, sf.month DESC, a.apartment_number";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("fee_id"));
                serviceFee.setApartmentId(rs.getInt("apartment_id"));
                serviceFee.setServiceTypeId(rs.getInt("service_type_id"));
                serviceFee.setMonth(rs.getInt("month"));
                serviceFee.setYear(rs.getInt("year"));
                serviceFee.setAmount(rs.getBigDecimal("amount"));
                serviceFee.setStatus(rs.getString("status"));
                serviceFee.setIssueDate(rs.getDate("issue_date"));
                serviceFee.setPaymentDate(rs.getDate("payment_date"));
                serviceFee.setDetails(rs.getString("details"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                serviceFee.setApartment(apartment);
                
                // Đối tượng ServiceType
                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceFee.setServiceType(serviceType);
                
                serviceFees.add(serviceFee);
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
        
        return serviceFees;
    }
    
    public List<ServiceFee> getServiceFeesByApartment(int apartmentId) {
        List<ServiceFee> serviceFees = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT sf.*, a.apartment_number, st.type_name " +
                         "FROM ServiceFees sf " +
                         "JOIN Apartments a ON sf.apartment_id = a.apartment_id " +
                         "JOIN ServiceTypes st ON sf.service_type_id = st.service_type_id " +
                         "WHERE sf.apartment_id = ? " +
                         "ORDER BY sf.year DESC, sf.month DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("fee_id"));
                serviceFee.setApartmentId(rs.getInt("apartment_id"));
                serviceFee.setServiceTypeId(rs.getInt("service_type_id"));
                serviceFee.setMonth(rs.getInt("month"));
                serviceFee.setYear(rs.getInt("year"));
                serviceFee.setAmount(rs.getBigDecimal("amount"));
                serviceFee.setStatus(rs.getString("status"));
                serviceFee.setIssueDate(rs.getDate("issue_date"));
                serviceFee.setPaymentDate(rs.getDate("payment_date"));
                serviceFee.setDetails(rs.getString("details"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                serviceFee.setApartment(apartment);
                
                // Đối tượng ServiceType
                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceFee.setServiceType(serviceType);
                
                serviceFees.add(serviceFee);
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
        
        return serviceFees;
    }
    
    public List<ServiceFee> getServiceFeesByMonthYear(int month, int year) {
        List<ServiceFee> serviceFees = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT sf.*, a.apartment_number, st.type_name " +
                         "FROM ServiceFees sf " +
                         "JOIN Apartments a ON sf.apartment_id = a.apartment_id " +
                         "JOIN ServiceTypes st ON sf.service_type_id = st.service_type_id " +
                         "WHERE sf.month = ? AND sf.year = ? " +
                         "ORDER BY a.apartment_number";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, month);
            pstmt.setInt(2, year);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("fee_id"));
                serviceFee.setApartmentId(rs.getInt("apartment_id"));
                serviceFee.setServiceTypeId(rs.getInt("service_type_id"));
                serviceFee.setMonth(rs.getInt("month"));
                serviceFee.setYear(rs.getInt("year"));
                serviceFee.setAmount(rs.getBigDecimal("amount"));
                serviceFee.setStatus(rs.getString("status"));
                serviceFee.setIssueDate(rs.getDate("issue_date"));
                serviceFee.setPaymentDate(rs.getDate("payment_date"));
                serviceFee.setDetails(rs.getString("details"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                serviceFee.setApartment(apartment);
                
                // Đối tượng ServiceType
                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceFee.setServiceType(serviceType);
                
                serviceFees.add(serviceFee);
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
        
        return serviceFees;
    }
    
    public ServiceFee getServiceFeeById(int feeId) {
        ServiceFee serviceFee = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT sf.*, a.apartment_number, st.type_name " +
                         "FROM ServiceFees sf " +
                         "JOIN Apartments a ON sf.apartment_id = a.apartment_id " +
                         "JOIN ServiceTypes st ON sf.service_type_id = st.service_type_id " +
                         "WHERE sf.fee_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, feeId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("fee_id"));
                serviceFee.setApartmentId(rs.getInt("apartment_id"));
                serviceFee.setServiceTypeId(rs.getInt("service_type_id"));
                serviceFee.setMonth(rs.getInt("month"));
                serviceFee.setYear(rs.getInt("year"));
                serviceFee.setAmount(rs.getBigDecimal("amount"));
                serviceFee.setStatus(rs.getString("status"));
                serviceFee.setIssueDate(rs.getDate("issue_date"));
                serviceFee.setPaymentDate(rs.getDate("payment_date"));
                serviceFee.setDetails(rs.getString("details"));
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                serviceFee.setApartment(apartment);
                
                // Đối tượng ServiceType
                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceFee.setServiceType(serviceType);
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
        
        return serviceFee;
    }
    
    public boolean addServiceFee(ServiceFee serviceFee) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO ServiceFees (apartment_id, service_type_id, month, year, amount, status, issue_date, details) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, serviceFee.getApartmentId());
            pstmt.setInt(2, serviceFee.getServiceTypeId());
            pstmt.setInt(3, serviceFee.getMonth());
            pstmt.setInt(4, serviceFee.getYear());
            pstmt.setBigDecimal(5, serviceFee.getAmount());
            pstmt.setString(6, serviceFee.getStatus());
            pstmt.setDate(7, new java.sql.Date(serviceFee.getIssueDate().getTime()));
            pstmt.setString(8, serviceFee.getDetails());
            
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
    
    public boolean updateServiceFee(ServiceFee serviceFee) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE ServiceFees SET amount = ?, status = ?, details = ? WHERE fee_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setBigDecimal(1, serviceFee.getAmount());
            pstmt.setString(2, serviceFee.getStatus());
            pstmt.setString(3, serviceFee.getDetails());
            pstmt.setInt(4, serviceFee.getFeeId());
            
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
    
    public boolean markAsPaid(int feeId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE ServiceFees SET status = 'Đã thanh toán', payment_date = GETDATE() WHERE fee_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, feeId);
            
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
    
    public boolean deleteServiceFee(int feeId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM ServiceFees WHERE fee_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, feeId);
            
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