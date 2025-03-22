// ParkingRegistrationDAO.java
package com.qlcc.dao;

import com.qlcc.model.ParkingRegistration;
import com.qlcc.model.User;
import com.qlcc.model.Apartment;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ParkingRegistrationDAO {
    
    public List<ParkingRegistration> getAllParkingRegistrations() {
        List<ParkingRegistration> registrations = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT pr.*, a.apartment_number, u.full_name as requester_name " +
                         "FROM ParkingRegistrations pr " +
                         "JOIN Apartments a ON pr.apartment_id = a.apartment_id " +
                         "JOIN Users u ON pr.requester_id = u.user_id " +
                         "ORDER BY a.apartment_number, pr.vehicle_type";
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                ParkingRegistration registration = new ParkingRegistration();
                registration.setParkingId(rs.getInt("parking_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setVehicleType(rs.getString("vehicle_type"));
                registration.setLicensePlate(rs.getString("license_plate"));
                registration.setVehicleBrand(rs.getString("vehicle_brand"));
                registration.setVehicleModel(rs.getString("vehicle_model"));
                registration.setVehicleColor(rs.getString("vehicle_color"));
                registration.setRegistrationDate(rs.getDate("registration_date"));
                registration.setStatus(rs.getString("status"));
                registration.setMonthlyFee(rs.getBigDecimal("monthly_fee"));
                
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
    
    public ParkingRegistration getParkingRegistrationById(int parkingId) {
        ParkingRegistration registration = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT pr.*, a.apartment_number, u.full_name as requester_name " +
                         "FROM ParkingRegistrations pr " +
                         "JOIN Apartments a ON pr.apartment_id = a.apartment_id " +
                         "JOIN Users u ON pr.requester_id = u.user_id " +
                         "WHERE pr.parking_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, parkingId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                registration = new ParkingRegistration();
                registration.setParkingId(rs.getInt("parking_id"));
                registration.setApartmentId(rs.getInt("apartment_id"));
                registration.setRequesterId(rs.getInt("requester_id"));
                registration.setVehicleType(rs.getString("vehicle_type"));
                registration.setLicensePlate(rs.getString("license_plate"));
                registration.setVehicleBrand(rs.getString("vehicle_brand"));
                registration.setVehicleModel(rs.getString("vehicle_model"));
                registration.setVehicleColor(rs.getString("vehicle_color"));
                registration.setRegistrationDate(rs.getDate("registration_date"));
                registration.setStatus(rs.getString("status"));
                registration.setMonthlyFee(rs.getBigDecimal("monthly_fee"));
                
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
    
    public List<ParkingRegistration> getParkingRegistrationsByApartment(int apartmentId) {
        List<ParkingRegistration> registrations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT pr.*, a.apartment_number, u.full_name as requester_name " +
                         "FROM ParkingRegistrations pr " +
                         "JOIN Apartments a ON pr.apartment_id = a.apartment_id " +
                         "JOIN Users u ON pr.requester_id = u.user_id " +
                         "WHERE pr.apartment_id = ? " +
                         "ORDER BY pr.vehicle_type";
            
          pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, apartmentId);
           
           rs = pstmt.executeQuery();
           while (rs.next()) {
               ParkingRegistration registration = new ParkingRegistration();
               registration.setParkingId(rs.getInt("parking_id"));
               registration.setApartmentId(rs.getInt("apartment_id"));
               registration.setRequesterId(rs.getInt("requester_id"));
               registration.setVehicleType(rs.getString("vehicle_type"));
               registration.setLicensePlate(rs.getString("license_plate"));
               registration.setVehicleBrand(rs.getString("vehicle_brand"));
               registration.setVehicleModel(rs.getString("vehicle_model"));
               registration.setVehicleColor(rs.getString("vehicle_color"));
               registration.setRegistrationDate(rs.getDate("registration_date"));
               registration.setStatus(rs.getString("status"));
               registration.setMonthlyFee(rs.getBigDecimal("monthly_fee"));
               
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
   
   public List<ParkingRegistration> getParkingRegistrationsByStatus(String status) {
       List<ParkingRegistration> registrations = new ArrayList<>();
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT pr.*, a.apartment_number, u.full_name as requester_name " +
                        "FROM ParkingRegistrations pr " +
                        "JOIN Apartments a ON pr.apartment_id = a.apartment_id " +
                        "JOIN Users u ON pr.requester_id = u.user_id " +
                        "WHERE pr.status = ? " +
                        "ORDER BY a.apartment_number, pr.vehicle_type";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, status);
           
           rs = pstmt.executeQuery();
           while (rs.next()) {
               ParkingRegistration registration = new ParkingRegistration();
               registration.setParkingId(rs.getInt("parking_id"));
               registration.setApartmentId(rs.getInt("apartment_id"));
               registration.setRequesterId(rs.getInt("requester_id"));
               registration.setVehicleType(rs.getString("vehicle_type"));
               registration.setLicensePlate(rs.getString("license_plate"));
               registration.setVehicleBrand(rs.getString("vehicle_brand"));
               registration.setVehicleModel(rs.getString("vehicle_model"));
               registration.setVehicleColor(rs.getString("vehicle_color"));
               registration.setRegistrationDate(rs.getDate("registration_date"));
               registration.setStatus(rs.getString("status"));
               registration.setMonthlyFee(rs.getBigDecimal("monthly_fee"));
               
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
   
   public boolean createParkingRegistration(ParkingRegistration registration) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "INSERT INTO ParkingRegistrations (apartment_id, requester_id, vehicle_type, license_plate, " +
                        "vehicle_brand, vehicle_model, vehicle_color, registration_date, status, monthly_fee) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, registration.getApartmentId());
           pstmt.setInt(2, registration.getRequesterId());
           pstmt.setString(3, registration.getVehicleType());
           pstmt.setString(4, registration.getLicensePlate());
           pstmt.setString(5, registration.getVehicleBrand());
           pstmt.setString(6, registration.getVehicleModel());
           pstmt.setString(7, registration.getVehicleColor());
           pstmt.setDate(8, new java.sql.Date(registration.getRegistrationDate().getTime()));
           pstmt.setString(9, "Đang hoạt động");
           pstmt.setBigDecimal(10, registration.getMonthlyFee());
           
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
   
   public boolean updateParkingRegistration(ParkingRegistration registration) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "UPDATE ParkingRegistrations SET vehicle_type = ?, license_plate = ?, " +
                        "vehicle_brand = ?, vehicle_model = ?, vehicle_color = ?, status = ?, monthly_fee = ? " +
                        "WHERE parking_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, registration.getVehicleType());
           pstmt.setString(2, registration.getLicensePlate());
           pstmt.setString(3, registration.getVehicleBrand());
           pstmt.setString(4, registration.getVehicleModel());
           pstmt.setString(5, registration.getVehicleColor());
           pstmt.setString(6, registration.getStatus());
           pstmt.setBigDecimal(7, registration.getMonthlyFee());
           pstmt.setInt(8, registration.getParkingId());
           
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
   
   public boolean deleteParkingRegistration(int parkingId) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "DELETE FROM ParkingRegistrations WHERE parking_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, parkingId);
           
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