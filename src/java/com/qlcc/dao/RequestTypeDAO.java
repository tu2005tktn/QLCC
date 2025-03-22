// RequestTypeDAO.java
package com.qlcc.dao;

import com.qlcc.model.RequestType;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class RequestTypeDAO {
    
    public List<RequestType> getAllRequestTypes() {
        List<RequestType> requestTypes = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM RequestTypes";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                RequestType requestType = new RequestType();
                requestType.setRequestTypeId(rs.getInt("request_type_id"));
                requestType.setTypeName(rs.getString("type_name"));
                requestType.setDescription(rs.getString("description"));
                
                requestTypes.add(requestType);
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
        
        return requestTypes;
    }
    
    public RequestType getRequestTypeById(int requestTypeId) {
        RequestType requestType = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM RequestTypes WHERE request_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, requestTypeId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                requestType = new RequestType();
                requestType.setRequestTypeId(rs.getInt("request_type_id"));
                requestType.setTypeName(rs.getString("type_name"));
                requestType.setDescription(rs.getString("description"));
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
        
        return requestType;
    }
    
    public boolean addRequestType(RequestType requestType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO RequestTypes (type_name, description) VALUES (?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, requestType.getTypeName());
            pstmt.setString(2, requestType.getDescription());
            
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
    
    public boolean updateRequestType(RequestType requestType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE RequestTypes SET type_name = ?, description = ? WHERE request_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, requestType.getTypeName());
            pstmt.setString(2, requestType.getDescription());
            pstmt.setInt(3, requestType.getRequestTypeId());
            
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
    
    public boolean deleteRequestType(int requestTypeId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM RequestTypes WHERE request_type_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, requestTypeId);
            
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