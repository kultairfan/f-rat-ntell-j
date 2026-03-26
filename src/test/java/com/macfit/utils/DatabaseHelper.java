package com.macfit.utils;

import java.sql.*;

public class DatabaseHelper {

    private static final String URL      = "jdbc:mysql://10.10.100.81:3306/?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "devApp";
    private static final String PASSWORD = "tV753knM3Ppr";

    public Connection connect() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public String smsCodeGetir(String telefon) {
        String sql = "SELECT sc.Code FROM Messaging.SmsCodes sc WHERE sc.Phone = ? ORDER BY sc.Id DESC LIMIT 1";
        try (Connection conn = connect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, telefon);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("Code");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
