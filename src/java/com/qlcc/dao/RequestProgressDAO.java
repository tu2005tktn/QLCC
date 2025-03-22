// RequestProgressDAO.java
package com.qlcc.dao;

import com.qlcc.model.RequestProgress;
import com.qlcc.model.User;
import com.qlcc.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class RequestProgressDAO {
    
    public List<RequestProgress> getProgressByRequestId(int requestId) {
        List<RequestProgress> progressList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT rp.*, u.full_name as updater_name " +
                         "FROM RequestProgress rp " +
                         "JOIN Users u ON rp.updated_by = u.user_id " +
                         "WHERE rp.request_id = ? " +
                         "ORDER BY rp.update_date DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, requestId);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                RequestProgress progress = new RequestProgress();
                progress.setProgressId(rs.getInt("progress_id"));
                progress.setRequestId(rs.getInt("request_id"));
                progress.setStatus(rs.getString("status"));
                progress.setUpdateDate(rs.getTimestamp("update_date"));
                progress.setUpdatedBy(rs.getInt("updated_by"));
                progress.setNotes(rs.getString("notes"));
                
                // Đối tượng User (Updater)
                User updater = new User();
                updater.setUserId(rs.getInt("updated_by"));
                updater.setFullName(rs.getString("updater_name"));
                progress.setUpdater(updater);
                
                progressList.add(progress);
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
       
       return progressList;
   }
   
   public boolean addProgress(RequestProgress progress) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean success = false;
       
       try {
           conn = DBConnection.getConnection();
           String sql = "INSERT INTO RequestProgress (request_id, status, update_date, updated_by, notes) " +
                        "VALUES (?, ?, ?, ?, ?)";
           
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, progress.getRequestId());
           pstmt.setString(2, progress.getStatus());
           pstmt.setTimestamp(3, new Timestamp(progress.getUpdateDate().getTime()));
           pstmt.setInt(4, progress.getUpdatedBy());
           pstmt.setString(5, progress.getNotes());
           
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