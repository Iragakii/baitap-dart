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

bool hasUppercase(String s) {
  return RegExp(r'[A-Z]').hasMatch(s);
}

bool hasLowercase(String s) {
  return RegExp(r'[a-z]').hasMatch(s);
}

bool hasNumber(String s) {
  return RegExp(r'[0-9]').hasMatch(s);
}

bool hasExspecialLetter(String s) {
  return RegExp(r'[!@#\$%^&*]').hasMatch(s);
}

void main(List<String> arguments) {
  stdout.write("Enter your password :");
  String? inputPassword = stdin.readLineSync();
  if (inputPassword == null || inputPassword.isEmpty) {
    print("Password is empty");
    return;
  }
  int inputPassword_int = inputPassword.length;
  if (inputPassword_int < 8) {
    print("Password is too short");
  }
  if (!hasUppercase(inputPassword)) {
    print("Password must contain at least one uppercase letter");
  }
  if (!hasLowercase(inputPassword)) {
    print("Password must contain at least one lowercase letter");
  }
  if (!hasNumber(inputPassword)) {
    print("Password must contain at least one number");
  }
  if (!hasExspecialLetter(inputPassword)) {
    print("Password must contain at least Exspecial Letter");
  }
  print("Your password is : $inputPassword");
}
