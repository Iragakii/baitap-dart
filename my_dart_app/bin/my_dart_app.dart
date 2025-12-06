import 'dart:io';

import 'package:my_dart_app/database_helper.dart';
import 'package:my_dart_app/student.dart';

void main() {
  // Khởi tạo Database Helper
  final dbHelper = DatabaseHelper();

  while (true) {
    print('\n=== QUẢN LÝ SINH VIÊN (SQLITE) ===');
    print('1. Xem danh sách');
    print('2. Thêm sinh viên');
    print('3. Xóa sinh viên');
    print('4. Tìm kiếm');
    print('0. Thoát');
    stdout.write('Chọn: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // Gọi dữ liệu từ DB thay vì List
        var list = dbHelper.getAllStudents();
        showList(list);
        break;
      case '2':
        addStudentUI(dbHelper);
        break;
      case '3':
        deleteStudentUI(dbHelper);
        break;
      case '4':
        searchStudentUI(dbHelper);
        break;
      case '0':
        dbHelper.close(); // Đóng kết nối
        print('Bye!');
        exit(0);
      default:
        print('Sai lựa chọn!');
    }
  }
}

// --- CÁC HÀM UI ---

void showList(List<Student> list) {
  print('\n--- KẾT QUẢ ---');
  if (list.isEmpty) print('Trống!');
  for (var sv in list) {
    print(sv.toString());
  }
}

void addStudentUI(DatabaseHelper db) {
  stdout.write('ID: ');
  String id = stdin.readLineSync() ?? '';
  stdout.write('Tên: ');
  String name = stdin.readLineSync() ?? '';
  stdout.write('Điểm Toán: ');
  double math = double.tryParse(stdin.readLineSync()!) ?? 0.0;
  stdout.write('Điểm Anh: ');
  double eng = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  Student sv = Student(id: id, name: name, mathScore: math, engScore: eng);

  // Gọi hàm Insert của Database
  db.insertStudent(sv);
}

void deleteStudentUI(DatabaseHelper db) {
  stdout.write('Nhập ID cần xóa: ');
  String id = stdin.readLineSync() ?? '';

  bool success = db.deleteStudent(id);
  if (success) {
    print('✅ Đã xóa thành công.');
  } else {
    print('❌ Không tìm thấy ID này.');
  }
}

void searchStudentUI(DatabaseHelper db) {
  stdout.write('Nhập tên cần tìm: ');
  String name = stdin.readLineSync() ?? '';

  var list = db.searchByName(name);
  showList(list);
}
