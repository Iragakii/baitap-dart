import 'package:sqlite3/sqlite3.dart';

class Student {
  String id;
  String name;
  double mathScore;
  double engScore;

  Student({
    required this.id,
    required this.name,
    required this.mathScore,
    required this.engScore,
  });

  double get averageScore => (mathScore + engScore) / 2;

  String get rank {
    if (averageScore >= 8.0) return 'Giỏi';
    if (averageScore >= 6.5) return 'Khá';
    if (averageScore >= 5.0) return 'Trung Bình';
    return 'Yếu';
  }

  // 1. Chuyển từ Object -> Map (Để lưu vào DB)
  // Tên key trong Map phải trùng tên cột trong Table
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'math_score': mathScore,
      'eng_score': engScore,
    };
  }

  // 2. Chuyển từ Database Row -> Object (Để hiển thị lên App)
  factory Student.fromRow(Row row) {
    return Student(
      id: row['id'] as String,
      name: row['name'] as String,
      mathScore: row['math_score'] as double,
      engScore: row['eng_score'] as double,
    );
  }

  @override
  String toString() {
    return 'ID: $id | Tên: $name | ĐTB: ${averageScore.toStringAsFixed(1)}';
  }
}
