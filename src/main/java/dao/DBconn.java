package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconn {
    //객체 생성 x , 어디서든 DBconn.getConnection() 으로 호출가능
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            //DB 주소 , 아이디 , 비밀번호
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe",
                "system",
                "1234"
            );
            //오류 발생시
        } catch (Exception e) {
            e.printStackTrace();
        }
        //연결 성공시 객체반환
        return conn;
    }
}
