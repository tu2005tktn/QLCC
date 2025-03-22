// RequestAssignmentDAO.java
package com.qlcc.dao;

import com.qlcc.model.Request;
import com.qlcc.model.RequestAssignment;
import com.qlcc.model.User;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class RequestAssignmentDAO {
    
    public RequestAssignment getAssignmentByRequestId(int requestId) {
        RequestAssignment assignment = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT ra.*, s.full_name as staff_name, m.full_name as manager_name " +
                         "FROM RequestAssignments ra " +
                         "JOIN Users s ON ra.staff_id = s.user_id " +
                         "JOIN Users m ON ra.assigned_by = m.user_id " +
                         "WHERE ra.request_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, requestId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                assignment = new RequestAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setRequestId(rs.getInt("request_id"));
                assignment.setStaffId(rs.getInt("staff_id"));
                assignment.setAssignedBy(rs.getInt("assigned_by"));
                assignment.setAssignedDate(rs.getTimestamp("assigned_date"));
                assignment.setDeadline(rs.getTimestamp("deadline"));
                assignment.setNotes(rs.getString("notes"));
                
                // Đối tượng User (Staff)
                User staff = new User();
                staff.setUserId(rs.getInt("staff_id"));
                staff.setFullName(rs.getString("staff_name"));
                assignment.setStaff(staff);
                
                // Đối tượng User (Manager)
                User manager = new User();
                manager.setUserId(rs.getInt("assigned_by"));
                manager.setFullName(rs.getString("manager_name"));
                assignment.setManager(manager);
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
        
        return assignment;
    }
    
    public List<RequestAssignment> getAssignmentsByStaff(int staffId) {
        List<RequestAssignment> assignments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT ra.*, r.title as request_title, m.full_name as manager_name " +
                         "FROM RequestAssignments ra " +
                         "JOIN Requests r ON ra.request_id = r.request_id " +
                         "JOIN Users m ON ra.assigned_by = m.user_id " +
                         "WHERE ra.staff_id = ? " +
                         "ORDER BY ra.assigned_date DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, staffId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                RequestAssignment assignment = new RequestAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setRequestId(rs.getInt("request_id"));
                assignment.setStaffId(rs.getInt("staff_id"));
                assignment.setAssignedBy(rs.getInt("assigned_by"));
                assignment.setAssignedDate(rs.getTimestamp("assigned_date"));
                assignment.setDeadline(rs.getTimestamp("deadline"));
                assignment.setNotes(rs.getString("notes"));
                
                // Đối tượng Request
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setTitle(rs.getString("request_title"));
                assignment.setRequest(request);
                
                // Đối tượng User (Manager)
                User manager = new User();
                manager.setUserId(rs.getInt("assigned_by"));
                manager.setFullName(rs.getString("manager_name"));
                assignment.setManager(manager);
                
                assignments.add(assignment);
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
        
        return assignments;
    }
    
    public boolean updateAssignment(RequestAssignment assignment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE RequestAssignments SET deadline = ?, notes = ? WHERE assignment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            if (assignment.getDeadline() != null) {
                pstmt.setTimestamp(1, new Timestamp(assignment.getDeadline().getTime()));
            } else {
                pstmt.setNull(1, java.sql.Types.TIMESTAMP);
            }
            pstmt.setString(2, assignment.getNotes());
            pstmt.setInt(3, assignment.getAssignmentId());
            
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