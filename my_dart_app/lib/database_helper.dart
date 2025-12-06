import 'package:sqlite3/sqlite3.dart';
import 'student.dart';

class DatabaseHelper {
  late final Database db;

  // Constructor: Mở kết nối và tạo bảng nếu chưa có
  DatabaseHelper() {
    print('🔄 Đang kết nối Database...');
    // Mở file students.db (sẽ tự tạo nếu chưa có)
    db = sqlite3.open('students.db');

    _createTable();
  }

  void _createTable() {
    // SQL tạo bảng
    db.execute('''
      CREATE TABLE IF NOT EXISTS students (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        math_score REAL,
        eng_score REAL
      );
    ''');
  }

  // --- CÁC HÀM CRUD ---

  // 1. Lấy tất cả sinh viên
  List<Student> getAllStudents() {
    final ResultSet resultSet = db.select('SELECT * FROM students');

    // Convert từng dòng (Row) thành Student object
    // map() ở đây trả về Iterable, cần .toList()
    return resultSet.map((row) => Student.fromRow(row)).toList();
  }

  // 2. Thêm sinh viên (Dùng Prepare Statement để bảo mật & an toàn)
  void insertStudent(Student sv) {
    final stmt = db.prepare(
      'INSERT INTO students (id, name, math_score, eng_score) VALUES (?, ?, ?, ?)',
    );

    try {
      stmt.execute([sv.id, sv.name, sv.mathScore, sv.engScore]);
      print('✅ Đã lưu vào Database!');
    } catch (e) {
      print('❌ Lỗi: Có thể ID đã tồn tại.');
    }

    stmt.dispose(); // Giải phóng bộ nhớ
  }

  // 3. Xóa sinh viên
  bool deleteStudent(String id) {
    final stmt = db.prepare('DELETE FROM students WHERE id = ?');
    stmt.execute([id]);

    // db.getUpdatedRows() trả về số dòng bị ảnh hưởng
    bool isDeleted = db.getUpdatedRows() > 0;
    stmt.dispose();
    return isDeleted;
  }

  // 4. Tìm kiếm theo tên
  List<Student> searchByName(String keyword) {
    final stmt = db.prepare('SELECT * FROM students WHERE name LIKE ?');

    // %keyword% là cú pháp tìm kiếm tương đối trong SQL
    final ResultSet results = stmt.select(['%$keyword%']);

    List<Student> list = results.map((row) => Student.fromRow(row)).toList();
    stmt.dispose();
    return list;
  }

  // Đóng kết nối khi tắt app (Tuy nhiên console app ít khi cần gọi hàm này thủ công)
  void close() {
    db.dispose();
  }
}
