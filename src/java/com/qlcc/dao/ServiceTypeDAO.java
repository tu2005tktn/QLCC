// ServiceTypeDAO.java
package com.qlcc.dao;

import com.qlcc.model.ServiceType;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ServiceTypeDAO {
    
    public List<ServiceType> getAllServiceTypes() {
        List<ServiceType> serviceTypes = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM ServiceTypes";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceType.setDescription(rs.getString("description"));
                
                serviceTypes.add(serviceType);
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
        
        return serviceTypes;
    }
    
    public ServiceType getServiceTypeById(int serviceTypeId) {
        ServiceType serviceType = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM ServiceTypes WHERE service_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, serviceTypeId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setTypeName(rs.getString("type_name"));
                serviceType.setDescription(rs.getString("description"));
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
        
        return serviceType;
    }
    
    public boolean addServiceType(ServiceType serviceType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO ServiceTypes (type_name, description) VALUES (?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, serviceType.getTypeName());
            pstmt.setString(2, serviceType.getDescription());
            
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
    
    public boolean updateServiceType(ServiceType serviceType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE ServiceTypes SET type_name = ?, description = ? WHERE service_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, serviceType.getTypeName());
            pstmt.setString(2, serviceType.getDescription());
            pstmt.setInt(3, serviceType.getServiceTypeId());
            
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
    
    public boolean deleteServiceType(int serviceTypeId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM ServiceTypes WHERE service_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, serviceTypeId);
            
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