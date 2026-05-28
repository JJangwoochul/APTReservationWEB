package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconn {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe",
                "system",
                "1234"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
