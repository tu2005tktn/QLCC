// TenantDAO.java
package com.qlcc.dao;

import com.qlcc.model.Tenant;
import com.qlcc.model.User;
import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class TenantDAO {
    
    public List<Tenant> getAllTenants() {
        List<Tenant> tenants = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT t.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM Tenants t " +
                         "JOIN Users u ON t.user_id = u.user_id " +
                         "JOIN Apartments a ON t.apartment_id = a.apartment_id " +
                         "ORDER BY a.apartment_number";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Tenant tenant = new Tenant();
                tenant.setTenantId(rs.getInt("tenant_id"));
                tenant.setUserId(rs.getInt("user_id"));
                tenant.setApartmentId(rs.getInt("apartment_id"));
                tenant.setRentalStartDate(rs.getDate("rental_start_date"));
                tenant.setRentalEndDate(rs.getDate("rental_end_date"));
                tenant.setRepresentative(rs.getBoolean("is_representative"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                tenant.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                tenant.setApartment(apartment);
                
                tenants.add(tenant);
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
        
        return tenants;
    }
    
    public Tenant getTenantById(int tenantId) {
        Tenant tenant = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT t.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM Tenants t " +
                         "JOIN Users u ON t.user_id = u.user_id " +
                         "JOIN Apartments a ON t.apartment_id = a.apartment_id " +
                         "WHERE t.tenant_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tenantId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                tenant = new Tenant();
                tenant.setTenantId(rs.getInt("tenant_id"));
                tenant.setUserId(rs.getInt("user_id"));
                tenant.setApartmentId(rs.getInt("apartment_id"));
                tenant.setRentalStartDate(rs.getDate("rental_start_date"));
                tenant.setRentalEndDate(rs.getDate("rental_end_date"));
                tenant.setRepresentative(rs.getBoolean("is_representative"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                tenant.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                tenant.setApartment(apartment);
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
        
        return tenant;
    }
    
    public List<Tenant> getTenantsByApartment(int apartmentId) {
        List<Tenant> tenants = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT t.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM Tenants t " +
                         "JOIN Users u ON t.user_id = u.user_id " +
                         "JOIN Apartments a ON t.apartment_id = a.apartment_id " +
                         "WHERE t.apartment_id = ? " +
                         "ORDER BY t.is_representative DESC, u.full_name";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Tenant tenant = new Tenant();
                tenant.setTenantId(rs.getInt("tenant_id"));
                tenant.setUserId(rs.getInt("user_id"));
                tenant.setApartmentId(rs.getInt("apartment_id"));
                tenant.setRentalStartDate(rs.getDate("rental_start_date"));
                tenant.setRentalEndDate(rs.getDate("rental_end_date"));
                tenant.setRepresentative(rs.getBoolean("is_representative"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                tenant.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                tenant.setApartment(apartment);
                
                tenants.add(tenant);
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
        
        return tenants;
    }
    
    public Tenant getRepresentativeTenantByApartmentId(int apartmentId) {
        Tenant tenant = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT t.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                         "FROM Tenants t " +
                         "JOIN Users u ON t.user_id = u.user_id " +
                         "JOIN Apartments a ON t.apartment_id = a.apartment_id " +
                         "WHERE t.apartment_id = ? AND t.is_representative = 1";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apartmentId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                tenant = new Tenant();
                tenant.setTenantId(rs.getInt("tenant_id"));
                tenant.setUserId(rs.getInt("user_id"));
                tenant.setApartmentId(rs.getInt("apartment_id"));
                tenant.setRentalStartDate(rs.getDate("rental_start_date"));
                tenant.setRentalEndDate(rs.getDate("rental_end_date"));
                tenant.setRepresentative(rs.getBoolean("is_representative"));
                
                // Đối tượng User
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                tenant.setUser(user);
                
                // Đối tượng Apartment
                Apartment apartment = new Apartment();
                apartment.setApartmentId(rs.getInt("apartment_id"));
                apartment.setApartmentNumber(rs.getString("apartment_number"));
                tenant.setApartment(apartment);
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
        
        return tenant;
    }
    
   public Tenant getTenantByUserId(int userId) {
       Tenant tenant = null;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT t.*, u.username, u.email, u.full_name, u.phone, a.apartment_number " +
                        "FROM Tenants t " +
                        "JOIN Users u ON t.user_id = u.user_id " +
                        "JOIN Apartments a ON t.apartment_id = a.apartment_id " +
                        "WHERE t.user_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, userId);
           
           rs = pstmt.executeQuery();
           if (rs.next()) {
               tenant = new Tenant();
               tenant.setTenantId(rs.getInt("tenant_id"));
               tenant.setUserId(rs.getInt("user_id"));
               tenant.setApartmentId(rs.getInt("apartment_id"));
               tenant.setRentalStartDate(rs.getDate("rental_start_date"));
               tenant.setRentalEndDate(rs.getDate("rental_end_date"));
               tenant.setRepresentative(rs.getBoolean("is_representative"));
               
               // Đối tượng User
               User user = new User();
               user.setUserId(rs.getInt("user_id"));
               user.setUsername(rs.getString("username"));
               user.setEmail(rs.getString("email"));
               user.setFullName(rs.getString("full_name"));
               user.setPhone(rs.getString("phone"));
               tenant.setUser(user);
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               tenant.setApartment(apartment);
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
       
       return tenant;
   }
   
   public boolean addTenant(Tenant tenant) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "INSERT INTO Tenants (user_id, apartment_id, rental_start_date, rental_end_date, is_representative) " +
                        "VALUES (?, ?, ?, ?, ?)";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, tenant.getUserId());
           pstmt.setInt(2, tenant.getApartmentId());
           pstmt.setDate(3, new java.sql.Date(tenant.getRentalStartDate().getTime()));
           
           if (tenant.getRentalEndDate() != null) {
               pstmt.setDate(4, new java.sql.Date(tenant.getRentalEndDate().getTime()));
           } else {
               pstmt.setNull(4, java.sql.Types.DATE);
           }
           
           pstmt.setBoolean(5, tenant.isRepresentative());
           
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
   
   public boolean updateTenant(Tenant tenant) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "UPDATE Tenants SET user_id = ?, apartment_id = ?, rental_start_date = ?, " +
                        "rental_end_date = ?, is_representative = ? " +
                        "WHERE tenant_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, tenant.getUserId());
           pstmt.setInt(2, tenant.getApartmentId());
           pstmt.setDate(3, new java.sql.Date(tenant.getRentalStartDate().getTime()));
           
           if (tenant.getRentalEndDate() != null) {
               pstmt.setDate(4, new java.sql.Date(tenant.getRentalEndDate().getTime()));
           } else {
               pstmt.setNull(4, java.sql.Types.DATE);
           }
           
           pstmt.setBoolean(5, tenant.isRepresentative());
           pstmt.setInt(6, tenant.getTenantId());
           
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
   
   public boolean deleteTenant(int tenantId) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "DELETE FROM Tenants WHERE tenant_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, tenantId);
           
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