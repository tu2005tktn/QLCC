// RequestDAO.java
package com.qlcc.dao;

import com.qlcc.model.Apartment;
import com.qlcc.model.Request;
import com.qlcc.model.RequestType;
import com.qlcc.model.User;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class RequestDAO {
    
    public List<Request> getAllRequests() {
       List<Request> requests = new ArrayList<>();
       Connection conn = null;
       Statement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           stmt = conn.createStatement();
           String sql = "SELECT r.*, a.apartment_number, u.full_name as requester_name, rt.type_name " +
                        "FROM Requests r " +
                        "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                        "JOIN Users u ON r.requester_id = u.user_id " +
                        "JOIN RequestTypes rt ON r.request_type_id = rt.request_type_id " +
                        "ORDER BY r.request_date DESC";
           
           rs = stmt.executeQuery(sql);
           while (rs.next()) {
               Request request = new Request();
               request.setRequestId(rs.getInt("request_id"));
               request.setApartmentId(rs.getInt("apartment_id"));
               request.setRequesterId(rs.getInt("requester_id"));
               request.setRequestTypeId(rs.getInt("request_type_id"));
               request.setTitle(rs.getString("title"));
               request.setDescription(rs.getString("description"));
               request.setRequestDate(rs.getTimestamp("request_date"));
               request.setStatus(rs.getString("status"));
               request.setPriority(rs.getString("priority"));
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               request.setApartment(apartment);
               
               // Đối tượng User (Requester)
               User requester = new User();
               requester.setUserId(rs.getInt("requester_id"));
               requester.setFullName(rs.getString("requester_name"));
               request.setRequester(requester);
               
               // Đối tượng RequestType
               RequestType requestType = new RequestType();
               requestType.setRequestTypeId(rs.getInt("request_type_id"));
               requestType.setTypeName(rs.getString("type_name"));
               request.setRequestType(requestType);
               
               requests.add(request);
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
       
       return requests;
   }
   
   public Request getRequestById(int requestId) {
       Request request = null;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT r.*, a.apartment_number, u.full_name as requester_name, rt.type_name " +
                        "FROM Requests r " +
                        "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                        "JOIN Users u ON r.requester_id = u.user_id " +
                        "JOIN RequestTypes rt ON r.request_type_id = rt.request_type_id " +
                        "WHERE r.request_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, requestId);
           
           rs = pstmt.executeQuery();
           if (rs.next()) {
               request = new Request();
               request.setRequestId(rs.getInt("request_id"));
               request.setApartmentId(rs.getInt("apartment_id"));
               request.setRequesterId(rs.getInt("requester_id"));
               request.setRequestTypeId(rs.getInt("request_type_id"));
               request.setTitle(rs.getString("title"));
               request.setDescription(rs.getString("description"));
               request.setRequestDate(rs.getTimestamp("request_date"));
               request.setStatus(rs.getString("status"));
               request.setPriority(rs.getString("priority"));
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               request.setApartment(apartment);
               
               // Đối tượng User (Requester)
               User requester = new User();
               requester.setUserId(rs.getInt("requester_id"));
               requester.setFullName(rs.getString("requester_name"));
               request.setRequester(requester);
               
               // Đối tượng RequestType
               RequestType requestType = new RequestType();
               requestType.setRequestTypeId(rs.getInt("request_type_id"));
               requestType.setTypeName(rs.getString("type_name"));
               request.setRequestType(requestType);
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
       
       return request;
   }
   
   public List<Request> getRequestsByApartment(int apartmentId) {
       List<Request> requests = new ArrayList<>();
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT r.*, a.apartment_number, u.full_name as requester_name, rt.type_name " +
                        "FROM Requests r " +
                        "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                        "JOIN Users u ON r.requester_id = u.user_id " +
                        "JOIN RequestTypes rt ON r.request_type_id = rt.request_type_id " +
                        "WHERE r.apartment_id = ? " +
                        "ORDER BY r.request_date DESC";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, apartmentId);
           
           rs = pstmt.executeQuery();
           while (rs.next()) {
               Request request = new Request();
               request.setRequestId(rs.getInt("request_id"));
               request.setApartmentId(rs.getInt("apartment_id"));
               request.setRequesterId(rs.getInt("requester_id"));
               request.setRequestTypeId(rs.getInt("request_type_id"));
               request.setTitle(rs.getString("title"));
               request.setDescription(rs.getString("description"));
               request.setRequestDate(rs.getTimestamp("request_date"));
               request.setStatus(rs.getString("status"));
               request.setPriority(rs.getString("priority"));
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               request.setApartment(apartment);
               
               // Đối tượng User (Requester)
               User requester = new User();
               requester.setUserId(rs.getInt("requester_id"));
               requester.setFullName(rs.getString("requester_name"));
               request.setRequester(requester);
               
               // Đối tượng RequestType
               RequestType requestType = new RequestType();
               requestType.setRequestTypeId(rs.getInt("request_type_id"));
               requestType.setTypeName(rs.getString("type_name"));
               request.setRequestType(requestType);
               
               requests.add(request);
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
       
       return requests;
   }
   
   public List<Request> getRequestsByStatus(String status) {
       List<Request> requests = new ArrayList<>();
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT r.*, a.apartment_number, u.full_name as requester_name, rt.type_name " +
                        "FROM Requests r " +
                        "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                        "JOIN Users u ON r.requester_id = u.user_id " +
                        "JOIN RequestTypes rt ON r.request_type_id = rt.request_type_id " +
                        "WHERE r.status = ? " +
                        "ORDER BY r.request_date DESC";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, status);
           
           rs = pstmt.executeQuery();
           while (rs.next()) {
               Request request = new Request();
               request.setRequestId(rs.getInt("request_id"));
               request.setApartmentId(rs.getInt("apartment_id"));
               request.setRequesterId(rs.getInt("requester_id"));
               request.setRequestTypeId(rs.getInt("request_type_id"));
               request.setTitle(rs.getString("title"));
               request.setDescription(rs.getString("description"));
               request.setRequestDate(rs.getTimestamp("request_date"));
               request.setStatus(rs.getString("status"));
               request.setPriority(rs.getString("priority"));
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               request.setApartment(apartment);
               
               // Đối tượng User (Requester)
               User requester = new User();
               requester.setUserId(rs.getInt("requester_id"));
               requester.setFullName(rs.getString("requester_name"));
               request.setRequester(requester);
               
               // Đối tượng RequestType
               RequestType requestType = new RequestType();
               requestType.setRequestTypeId(rs.getInt("request_type_id"));
               requestType.setTypeName(rs.getString("type_name"));
               request.setRequestType(requestType);
               
               requests.add(request);
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
       
       return requests;
   }
   
   public List<Request> getRequestsByStaff(int staffId) {
       List<Request> requests = new ArrayList<>();
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "SELECT r.*, a.apartment_number, u.full_name as requester_name, rt.type_name " +
                        "FROM Requests r " +
                        "JOIN RequestAssignments ra ON r.request_id = ra.request_id " +
                        "JOIN Apartments a ON r.apartment_id = a.apartment_id " +
                        "JOIN Users u ON r.requester_id = u.user_id " +
                        "JOIN RequestTypes rt ON r.request_type_id = rt.request_type_id " +
                        "WHERE ra.staff_id = ? " +
                        "ORDER BY r.request_date DESC";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, staffId);
           
           rs = pstmt.executeQuery();
           while (rs.next()) {
               Request request = new Request();
               request.setRequestId(rs.getInt("request_id"));
               request.setApartmentId(rs.getInt("apartment_id"));
               request.setRequesterId(rs.getInt("requester_id"));
               request.setRequestTypeId(rs.getInt("request_type_id"));
               request.setTitle(rs.getString("title"));
               request.setDescription(rs.getString("description"));
               request.setRequestDate(rs.getTimestamp("request_date"));
               request.setStatus(rs.getString("status"));
               request.setPriority(rs.getString("priority"));
               
               // Đối tượng Apartment
               Apartment apartment = new Apartment();
               apartment.setApartmentId(rs.getInt("apartment_id"));
               apartment.setApartmentNumber(rs.getString("apartment_number"));
               request.setApartment(apartment);
               
               // Đối tượng User (Requester)
               User requester = new User();
               requester.setUserId(rs.getInt("requester_id"));
               requester.setFullName(rs.getString("requester_name"));
               request.setRequester(requester);
               
               // Đối tượng RequestType
               RequestType requestType = new RequestType();
               requestType.setRequestTypeId(rs.getInt("request_type_id"));
               requestType.setTypeName(rs.getString("type_name"));
               request.setRequestType(requestType);
               
               requests.add(request);
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
       
       return requests;
   }
   
   public boolean createRequest(Request request) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "INSERT INTO Requests (apartment_id, requester_id, request_type_id, title, description, request_date, status, priority) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, request.getApartmentId());
           pstmt.setInt(2, request.getRequesterId());
           pstmt.setInt(3, request.getRequestTypeId());
           pstmt.setString(4, request.getTitle());
           pstmt.setString(5, request.getDescription());
           pstmt.setTimestamp(6, new Timestamp(request.getRequestDate().getTime()));
           pstmt.setString(7, request.getStatus());
           pstmt.setString(8, request.getPriority());
           
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
   
   public boolean updateRequest(Request request) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "UPDATE Requests SET title = ?, description = ?, status = ?, priority = ? " +
                        "WHERE request_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, request.getTitle());
           pstmt.setString(2, request.getDescription());
           pstmt.setString(3, request.getStatus());
           pstmt.setString(4, request.getPriority());
           pstmt.setInt(5, request.getRequestId());
           
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
   
   public boolean updateRequestStatus(int requestId, String status) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "UPDATE Requests SET status = ? WHERE request_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, status);
           pstmt.setInt(2, requestId);
           
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
   
   public boolean assignRequest(int requestId, int staffId, int managerId) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           conn.setAutoCommit(false);
           
           // Cập nhật trạng thái yêu cầu
           String sqlUpdateRequest = "UPDATE Requests SET status = 'Đang xử lý' WHERE request_id = ?";
           pstmt = conn.prepareStatement(sqlUpdateRequest);
           pstmt.setInt(1, requestId);
           pstmt.executeUpdate();
           pstmt.close();
           
           // Thêm bản ghi vào bảng RequestAssignments
           String sqlAddAssignment = "INSERT INTO RequestAssignments (request_id, staff_id, assigned_by, assigned_date) " +
                                     "VALUES (?, ?, ?, GETDATE())";
           pstmt = conn.prepareStatement(sqlAddAssignment);
           pstmt.setInt(1, requestId);
           pstmt.setInt(2, staffId);
           pstmt.setInt(3, managerId);
           pstmt.executeUpdate();
           
           // Thêm bản ghi vào bảng RequestProgress
           String sqlAddProgress = "INSERT INTO RequestProgress (request_id, status, update_date, updated_by, notes) " +
                                    "VALUES (?, 'Đang xử lý', GETDATE(), ?, N'Đã giao việc cho nhân viên')";
           pstmt = conn.prepareStatement(sqlAddProgress);
           pstmt.setInt(1, requestId);
           pstmt.setInt(2, managerId);
           pstmt.executeUpdate();
           
           conn.commit();
           success = true;
       } catch (SQLException e) {
           try {
               if (conn != null) {
                   conn.rollback();
               }
           } catch (SQLException ex) {
               ex.printStackTrace();
           }
           e.printStackTrace();
       } finally {
           try {
               if (conn != null) {
                   conn.setAutoCommit(true);
               }
               if (pstmt != null) pstmt.close();
               if (conn != null) DBConnection.closeConnection(conn);
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return success;
   }
   
   public boolean updateRequestProgress(int requestId, String status, String notes, int updatedBy) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           conn.setAutoCommit(false);
           
           // Cập nhật trạng thái yêu cầu
           String sqlUpdateRequest = "UPDATE Requests SET status = ? WHERE request_id = ?";
           pstmt = conn.prepareStatement(sqlUpdateRequest);
           pstmt.setString(1, status);
           pstmt.setInt(2, requestId);
           pstmt.executeUpdate();
           pstmt.close();
           
           // Thêm bản ghi vào bảng RequestProgress
           String sqlAddProgress = "INSERT INTO RequestProgress (request_id, status, update_date, updated_by, notes) " +
                                    "VALUES (?, ?, GETDATE(), ?, ?)";
           pstmt = conn.prepareStatement(sqlAddProgress);
           pstmt.setInt(1, requestId);
           pstmt.setString(2, status);
           pstmt.setInt(3, updatedBy);
           pstmt.setString(4, notes);
           pstmt.executeUpdate();
           
           conn.commit();
           success = true;
       } catch (SQLException e) {
           try {
               if (conn != null) {
                   conn.rollback();
               }
           } catch (SQLException ex) {
               ex.printStackTrace();
           }
           e.printStackTrace();
       } finally {
           try {
               if (conn != null) {
                   conn.setAutoCommit(true);
               }
               if (pstmt != null) pstmt.close();
               if (conn != null) DBConnection.closeConnection(conn);
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return success;
   }
   
   public boolean deleteRequest(int requestId) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "DELETE FROM Requests WHERE request_id = ?";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, requestId);
           
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