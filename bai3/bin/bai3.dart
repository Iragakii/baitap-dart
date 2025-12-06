import 'dart:io';

void main(List<String> arguments) {
  stdout.write("Enter your first word : ");

  String? firstWord = stdin.readLineSync();

  print("Your first word is : $firstWord");
  stdout.write("Enter your second word :");
  String? secondWord = stdin.readLineSync();
  print("Your second word is : $secondWord");
  if (firstWord?.letterIndex(0) == secondWord?.letterIndex(0)) {
    print("Two words have the same first letter index");
  } else {
    print("Two words do not have the same first letter index");
  }
  if (firstWord == null || secondWord == null) {
    print("Error: one of the words is null");
    return;
  }
  if (firstWord.letterIndex(0) == secondWord[secondWord.length - 1]) {
    print("The secondWord is revert of firstWord");
  }
}

extension LetterIndexExt on String {
  String letterIndex(int index) => this[index];
}
