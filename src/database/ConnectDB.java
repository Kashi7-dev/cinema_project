package database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class ConnectDB {
    private static final String HOST_NAME = "localhost";
    private static final String PORT = "3306";
    private static final String DB_NAME = "Cinemadb"; // Tên database bạn vừa tạo
    private static final String USER = "root";
    private static final String PASS = "";
    private static final String URL = "jdbc:mysql://" + HOST_NAME + ":" + PORT + "/" + DB_NAME 
            + "?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Nạp Driver (bắt buộc với một số phiên bản cũ, bản mới tự nhận nhưng nên giữ)
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Tạo kết nối
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException ex) {
            System.out.println("Lỗi: Không tìm thấy Driver JDBC!");
            ex.printStackTrace();
        } catch (SQLException ex) {
            System.out.println("Lỗi: Không thể kết nối vào Database! Kiểm tra lại tên DB hoặc XAMPP.");
            ex.printStackTrace();
        }
        return conn;
}
    public static void main(String[] args) {
        Connection c = getConnection();
        if (c != null) {
            System.out.println("=== ket noi thanh cong toi 'Cinemadb' ===");
            try {
                c.close(); // Test xong đóng lại cho đỡ tốn tài nguyên
            } catch (SQLException e) {}
        } else {
            System.out.println("=== ket noi that bai ===");
        }
    }
}
