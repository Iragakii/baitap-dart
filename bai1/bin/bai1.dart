import 'dart:convert';
import 'dart:io';

String safeFixMojibake(String s) {
  try {
    final bytes = latin1.encode(s);
    return utf8.decode(bytes);
  } catch (_) {
    return s;
  }
}

String titleCaseVietnamese(String s) {
  return s
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .map((word) {
        final runes = word.runes.toList();
        if (runes.isEmpty) return word;
        final first = String.fromCharCode(runes[0]).toUpperCase();
        final rest = runes.length > 1
            ? String.fromCharCodes(runes.sublist(1)).toLowerCase()
            : '';
        return '$first$rest';
      })
      .join(' ');
}

void main(List<String> args) {
  stdout.write("Enter your Name : ");
  String? inputName = stdin.readLineSync();

  if (inputName == null || inputName.isEmpty) {
    print("Your Name is : Empty");
    return;
  }

  final fixed = safeFixMojibake(inputName);
  final formatted = titleCaseVietnamese(fixed);

  print("Your Name is : $formatted");
}
