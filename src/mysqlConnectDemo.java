import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class mysqlConnectDemo {
    // Thông tin kết nối
    // Nếu bạn dùng XAMPP mặc định thì user là "root", password để trống ""
    private static final String URL = "jdbc:mysql://localhost:3306/RapPhimDB";
    private static final String USER = "root"; 
    private static final String PASS = ""; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // 1. Đăng ký Driver (bản mới dùng cj) [cite: 31]
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Tạo kết nối [cite: 32, 33]
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Kết nối thành công tới MySQL!");
            
        } catch (ClassNotFoundException ex) {
            System.out.println("Lỗi: Không tìm thấy Driver JDBC.");
            ex.printStackTrace();
        } catch (SQLException ex) {
            System.out.println("Lỗi: Không thể kết nối tới Database. Kiểm tra lại tên DB, user, pass.");
            ex.printStackTrace();
        }
        return conn;
    }

    // Hàm main để chạy thử ngay lập tức [cite: 130]
    public static void main(String[] args) {
        getConnection();
    }
}
